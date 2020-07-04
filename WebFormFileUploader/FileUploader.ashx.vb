Imports System
Imports System.Collections.Generic
Imports System.Drawing
Imports System.IO
Imports System.Linq
Imports System.Net
Imports System.Web

Public Class FileUploader
    Implements IHttpHandler, System.Web.SessionState.IRequiresSessionState

    Private ReadOnly _FileUploadValidator As IFileUploadValidator
    Private ReadOnly _ImageUpload As IImageUpload

    Public Sub New()
        _FileUploadValidator = New FileUploadValidator()
        _ImageUpload = New ImageUpload()
    End Sub

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim amountOfFilesUploaded As Integer = 5 ' TODO get number from database or appSettings
        Dim request = HttpContext.Current.Request

        For i As Integer = 0 To request.Files.Count - 1
            Dim file As HttpPostedFile = request.Files(i)
            Dim repsonse = Me._FileUploadValidator.Validate(file, amountOfFilesUploaded)

            If Not repsonse.Success Then
                context.Response.StatusCode = CInt(HttpStatusCode.BadRequest)
                context.Response.Write(repsonse.Message)
                HttpContext.Current.Response.[End]()
            End If
        Next

        For i As Integer = 0 To request.Files.Count - 1
            Dim file As HttpPostedFile = request.Files(i)
            Dim fileName = Path.GetFileName(file.FileName)
            Dim fileNameAndPath = HttpContext.Current.Server.MapPath(String.Format("~/_img/{0}", fileName))
            Dim config = New Config() With {
                .FileNameAndPath = fileNameAndPath
            }
            Me._ImageUpload.SaveImage(file, config)
        Next
    End Sub

    Public ReadOnly Property IsReusable As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    Interface IImageUpload
        Sub SaveImage(ByVal file As HttpPostedFile, ByVal config As Config)
    End Interface

    Public Class ImageUpload
        Implements IImageUpload

        Public Sub SaveImage(ByVal file As HttpPostedFile, ByVal config As Config) Implements IImageUpload.SaveImage
            Using sourceimage = Image.FromStream(file.InputStream)
                sourceimage.Save(config.FileNameAndPath)
            End Using
        End Sub
    End Class

    Interface IFileUploadValidator
        Function Validate(ByVal file As HttpPostedFile, ByVal amountUploadFiles As Integer) As Response
    End Interface

    Public Class FileUploadValidator
        Implements IFileUploadValidator

        Public Function Validate(ByVal file As HttpPostedFile, ByVal amountUploadFiles As Integer) As Response Implements IFileUploadValidator.Validate
            Dim results = New Response() {IsValidFileType(file), IsValidSize(file), IsMaximumUploadExceed(amountUploadFiles)}
            Dim firstFailedResults = results.FirstOrDefault(Function(m) Not m.Success)
            Return If(firstFailedResults Is Nothing, New Response(True, ""), firstFailedResults)
        End Function

        Private Function IsValidFileType(ByVal file As HttpPostedFile) As Response
            Dim extensions As String() = {"jpg", "jpeg", "gif", "bmp", "png"}

            Dim success = extensions.Any(Function(extension) String.Format("image/{0}", extension).Equals(file.ContentType, StringComparison.OrdinalIgnoreCase)) AndAlso extensions.Any(Function(extension) String.Format(".{0}", extension).Equals(Path.GetExtension(file.FileName.ToLower()), StringComparison.OrdinalIgnoreCase))

            Return New Response(success, String.Format("{0} extention must be a jpg, jpeg, gif, bmp or png.", file.FileName))
        End Function

        Private Function IsValidSize(ByVal file As HttpPostedFile) As Response
            Dim success = file.ContentLength < 2100000
            Return New Response(success, String.Format("{0} must be less than 2MB.", file.FileName))
        End Function

        Private Function IsMaximumUploadExceed(ByVal amountUploadFiles As Integer) As Response
            Dim success = amountUploadFiles < 10
            Return New Response(success, "You have reached your upload limit of 10.")
        End Function
    End Class

    Public Class Config
        Public Sub New()
            Resize = New List(Of ConfigResize)()
        End Sub

        Public Property FileNameAndPath As String
        Public Property Resize As List(Of ConfigResize)
    End Class

    Public Class ConfigResize
        Public Property Width As Integer
        Public Property Height As Integer
    End Class

    Public Class Response
        Public Sub New(ByVal success As Boolean, ByVal message As String)
            _Success = success

            If Not success Then
                _Message = message
            End If
        End Sub


        Private _Success As Boolean
        Public ReadOnly Property Success As Boolean
            Get
                Return _Success
            End Get
        End Property

        Private _Message As String
        Public ReadOnly Property Message As String
            Get
                Return _Message
            End Get
        End Property

    End Class
End Class
