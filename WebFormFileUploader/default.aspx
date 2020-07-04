<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="WebFormFileUploader._default" %>

<!DOCTYPE html>
<html lang="en">
    <head id="Head1" runat="server">
        <title></title>
	    <style type="text/css">
		    body {
			    font-family: sans-serif;
		    }
		    a {
			    color: #369;
		    }
		    .note {
			    width: 500px;
			    margin: 50px auto;
			    font-size: 1.1em;
			    color: #333;
			    text-align: justify;
		    }
		    #drop-area {
			    border: 2px dashed #ccc;
			    border-radius: 20px;
			    width: 480px;
			    margin: 50px auto;
			    padding: 20px;
		    }
		    #drop-area.highlight {
			    border-color: #39bfd3;
		    }
		    p {
			    margin-top: 0;
		    }
		    .my-form {
			    margin-bottom: 10px;
		    }
		    #gallery {
			    margin-top: 10px;
		    }
		    #gallery img {
			    width: 150px;
			    margin-bottom: 10px;
			    margin-right: 10px;
			    vertical-align: middle;
		    }
		    .button {
			    display: inline-block;
			    padding: 10px;
			    background: #ccc;
			    cursor: pointer;
			    border-radius: 5px;
			    border: 1px solid #ccc;
		    }
		    .button:hover {
			    background: #ddd;
		    }
		    #fileElem {
			    display: none;
		    }
            
           .box__icon
           {    
               width: 100%;
                height: 80px;
                fill: #92b0b3;
                display: block;
                margin-bottom: 40px;
           }

           .error
           {
               color: red;
               font-weight:bold;
           }

           .success
           {
               color: green;
               font-weight:bold;
           }

           .file
           {
               cursor: pointer;
           }

          #gallery img:hover,  #gallery img:focus {
            background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAAqklEQVR4XqWRMQ6DMAxF/1Fyilyj2SmIBUG5QcTCyJA5Z8jGhlBPgRi4TmoDraVmKFJlWYrlp/g5QfwRlwEVNWVa4WzfH9jK6kCkEkBjwxOhLghheMWMELUAqqwQ4OCbnE4LJnhr5IYdqQt4DJQjhe9u4vBBmnxHHNzRFkDGjHDo0VuTAqy2vAG4NkvXXDHxbGsIGlj3e835VFNtdugma/Jk0eXq0lP//5svi4PtO01oFfYAAAAASUVORK5CYII=");
          }

	        #test:hover, #test:focus {
	            background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAAqklEQVR4XqWRMQ6DMAxF/1Fyilyj2SmIBUG5QcTCyJA5Z8jGhlBPgRi4TmoDraVmKFJlWYrlp/g5QfwRlwEVNWVa4WzfH9jK6kCkEkBjwxOhLghheMWMELUAqqwQ4OCbnE4LJnhr5IYdqQt4DJQjhe9u4vBBmnxHHNzRFkDGjHDo0VuTAqy2vAG4NkvXXDHxbGsIGlj3e835VFNtdugma/Jk0eXq0lP//5svi4PtO01oFfYAAAAASUVORK5CYII=");
	        }

.gallery-container {
  position: relative;
  margin-top: 50px;
  width: 500px;
  height: 300px;
}
// https://codepen.io/philcheng/pen/YWyYwG
.gallery-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0);
  transition: background 0.5s ease;
}

.gallery-container:hover .overlay {
  display: block;
  background: rgba(0, 0, 0, .3);
  background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAAqklEQVR4XqWRMQ6DMAxF/1Fyilyj2SmIBUG5QcTCyJA5Z8jGhlBPgRi4TmoDraVmKFJlWYrlp/g5QfwRlwEVNWVa4WzfH9jK6kCkEkBjwxOhLghheMWMELUAqqwQ4OCbnE4LJnhr5IYdqQt4DJQjhe9u4vBBmnxHHNzRFkDGjHDo0VuTAqy2vAG4NkvXXDHxbGsIGlj3e835VFNtdugma/Jk0eXq0lP//5svi4PtO01oFfYAAAAASUVORK5CYII=");
        
}

/*
img {
  position: absolute;
  width: 500px;
  height: 300px;
  left: 0;
}

.title {
  position: absolute;
  width: 500px;
  left: 0;
  top: 120px;
  font-weight: 700;
  font-size: 30px;
  text-align: center;
  text-transform: uppercase;
  color: white;
  z-index: 1;
  transition: top .5s ease;
}

.gallery-container:hover .title {
  top: 90px;
}

img {
  position: absolute;
  width: 500px;
  left:0;
  top: 180px;
  text-align: center;
  opacity: 1;
  transition: opacity .35s ease;
}

.button a {
  width: 200px;
  padding: 12px 48px;
  text-align: center;
  color: white;
  border: solid 2px white;
  z-index: 1;
}

.gallery-container:hover img {
  opacity: 0.5;
}
     */

	    </style>
    </head>
    <body>
        <form id="form1" runat="server" class="box">
            <div id="drop-area" style="text-align: center;">     
                <svg class="box__icon" xmlns="http://www.w3.org/2000/svg" width="50" height="43" viewBox="0 0 50 43"><path d="M48.4 26.5c-.9 0-1.7.7-1.7 1.7v11.6h-43.3v-11.6c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v13.2c0 .9.7 1.7 1.7 1.7h46.7c.9 0 1.7-.7 1.7-1.7v-13.2c0-1-.7-1.7-1.7-1.7zm-24.5 6.1c.3.3.8.5 1.2.5.4 0 .9-.2 1.2-.5l10-11.6c.7-.7.7-1.7 0-2.4s-1.7-.7-2.4 0l-7.1 8.3v-25.3c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v25.3l-7.1-8.3c-.7-.7-1.7-.7-2.4 0s-.7 1.7 0 2.4l10 11.6z" /></svg>
                <input type="file" id="fileElem" multiple accept="image/*" onchange="handleFiles(this.files)">
                <label class="file" for="fileElem"><strong>Choose some files</strong> or drag and drop here</label>
                <div>
                    <div id="gallery"></div>                    
                    <progress id="progress-bar" max="100" value="0"></progress>
                    <div id="uploadStatus"></div>
                    <input id="btnUpload" type="submit" value="Upload" />
                </div>
            </div> 
        </form>	

        <script type="text/javascript">	
        let URL = 'FileUploader.ashx' 
        let Files = []
        let UploadProgress = []
        let ProgressBar = document.getElementById('progress-bar')
        let DropArea = document.getElementById("drop-area");

        let BtnUpload = document.getElementById("btnUpload")
        BtnUpload.addEventListener('click', uploadFiles, false)

        function galleryClick(event) {
            event.preventDefault();
            var thisFileId = parseInt(this.attributes["fileid"].value);

            for (var i = Files.length - 1; i >= 0; i--) {
                if (Files[i].Id === thisFileId) {
                    Files.splice(i, 1);
                }
            }

            let imgs = document.querySelectorAll('#gallery img');

            for (var i = imgs.length - 1; i >= 0; i--) {
                if (parseInt(imgs[i].attributes["fileid"].value) === thisFileId) {
                    imgs[i].parentNode.removeChild(imgs[i]);
                }
            }
        }

        function uploadFiles(event) {
            event.preventDefault();
            initializeProgress(Files.length)
            // TODO - Validate file size & add delete overlay. 
            uploadFile(Files[0], 0);
        }
               
        var form = document.getElementById('form1');
        ['drag', 'dragstart', 'dragend', 'dragover', 'dragenter', 'dragleave', 'drop'].forEach(function (event) {
            form.addEventListener(event, function (e) {
                preventDefaults(e);
            });
        });

        // Prevent default drag behaviors
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(function (eventName) {
            DropArea.addEventListener(eventName, preventDefaults, false)
        });

        ['dragenter', 'dragover'].forEach(function (eventName) {
            DropArea.addEventListener(eventName, highlight, false)
        });

        ['dragleave', 'drop'].forEach(function (eventName) {
            DropArea.addEventListener(eventName, unhighlight, false)
        });

        // Handle dropped files
        DropArea.addEventListener('drop', handleDrop, false)

        function highlight(e) {
            DropArea.classList.add('highlight')
        }

        function unhighlight(e) {
            DropArea.classList.remove('highlight')
        }

        function preventDefaults(e) {
            e.preventDefault()
            e.stopPropagation()
        }

        function handleDrop(e) {
            var dt = e.dataTransfer
            var files = dt.files

            handleFiles(files)
        }

        function initializeProgress(numFiles) {
            setResponseMessage("");
            ProgressBar.value = 0
            UploadProgress = []

            for (let i = numFiles; i > 0; i--) {
                UploadProgress.push(0)
            }
        }

        function updateProgress(fileNumber, percent) {
            UploadProgress[fileNumber] = percent
            let total = UploadProgress.reduce(function (tot, curr) {
                return tot + curr;
            }, 0) / UploadProgress.length

            ProgressBar.value = total
            return total
        }

        function handleFiles(files) {
            initializeProgress(files.length)
            var fileId = Files.length > 0 ? Files[Files.length - 1].Id : 0

            for (var i = 0; i < files.length; i++) {
                fileId++;
                Files.push({ "Id": fileId, "Data": files[i] })
            }

            buildGallery();
        }

        function buildGallery() {
            document.getElementById('gallery').innerHTML = "";
            for (var i = 0; i < Files.length; i++) {
                previewFile(Files[i]);
            }
        }

        function previewFile(file) {
            let reader = new FileReader()
            reader.readAsDataURL(file.Data)
            reader.onloadend = function () {
                //let container = document.createElement('div')
                //container.setAttribute('class', 'gallery-container');
                        
                let img = document.createElement('img')
                img.setAttribute('fileid', file.Id);
                img.setAttribute('title', 'Click to remove.');
                img.src = reader.result
                img.addEventListener('click', galleryClick, false)
                document.getElementById('gallery').appendChild(img)

                // overlay = document.createElement('div')
                //overlay.setAttribute('class', 'gallery-overlay');

                //container.appendChild(img)
                //container.appendChild(overlay)

                //document.getElementById('gallery').appendChild(container)
            }
        }

        function findNextFile(previousFile) {
            for (var i = 0; i < Files.length; i++)
                if (Files[i].Id === previousFile.Id) {
                    return Files[i + 1];
                }
            return null;
        }

        function setResponseMessage(message, hasErrored) {
            let uploadStatus = document.getElementById('uploadStatus');
            uploadStatus.setAttribute("class", hasErrored ? "error" : "success");
            uploadStatus.innerText = message;
        }

        function uploadFile(file, i) {
            var url = URL;
            var xhr = new XMLHttpRequest()
            var formData = new FormData()
            xhr.open('POST', url, true)
            xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')
   
            xhr.upload.addEventListener("progress", function (e) {
                updateProgress(i, (e.loaded * 100.0 / e.total) || 100)
            })

            xhr.addEventListener('readystatechange', function (e) {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    total = updateProgress(i, 100); 
                    nextFile = findNextFile(file);
                    if (nextFile) {
                        i++;
                        uploadFile(nextFile, i);
                    }
                    else if (total === 100) {
                        setResponseMessage("Completed");
                    }
                }
                else if (xhr.readyState == 4 && xhr.status != 200) {                    
                    initializeProgress(0)
                    setResponseMessage(xhr.response, true);
                }
            })

            formData.append('file', file.Data)
            xhr.send(formData)
        }
            
        </script>
    </body>
</html>