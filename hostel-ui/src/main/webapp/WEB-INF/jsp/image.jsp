<%@page import="com.hostel.controller.HostelController" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<div>
    <div>
    <p>tenent_id:<span id="t_id"></span></p>
    <p>name:<span id="t_name"></span></p>
    </div>
    <div>
    <form action="static/images" method="post" enctype="multipart/form-data">
    <input type="file" id="fileid" name="filename">
    <input type="submit" id="submitbtn" value="Upload">
    </form>
    </div>
</div>
    <script type="text/javascript">
        let idEl=document.getElementById("t_id")
        let nameEl=document.getElementById("t_name")

        function populateTenentDetails(tenentData){
            let tenentIDEl=document.getElementById("t_id")
            tenentIDEl.textContent=tenentData.data.t_id

            let nameEl=document.getElementById("t_name")
            nameEl.textContent=tenentData.data.t_name
        }
        document.getElementById('submitbtn').addEventListener('click',function(){
            let fileEl=document.getElementById("fileid")
            
        })
    

        populateTenentDetails(<%=HostelController.getTenentDetails()%>);
    </script>
</body>
</html>