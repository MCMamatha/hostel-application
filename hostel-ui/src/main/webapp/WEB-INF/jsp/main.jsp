<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <p>id:<span id="t_id"></span></p>
    <p>name:<span id="name"></span></p>
    <p>address:<span id="address"></span></p>
    <p>phone:<span id="phone"></span></p>
    <p>date_of_joining:<span id="date_id"></span></p>
    <p>room no:<span id="roomno"></span></p>
    <p>profession:<span id="profession"></span></p>
    <button id="back">BACK</button>
    
  
    
    <script type="text/javascript">

        let idEl=document.getElementById("t_id")
        let nameEl=document.getElementById("name")
        let addressEl=document.getElementById("address")
        let phoneEl=document.getElementById("phone")
        let dateEl=document.getElementById("date_id")
        let roomNoEl=document.getElementById("roomno")
        let proffEl=document.getElementById("profession")
        

        async function res(url = "") {
            const response = await fetch(url, {
                method:"GET"
                
            });
            return response.json();
        }

        res("/details").then((response) => {
            if(response.status=="success"){
                idEl.textContent=response.data.t_id;
                nameEl.textContent=response.data.t_name;
                addressEl.textContent=response.data.t_address;
                phoneEl.textContent=response.data.t_phone;
                dateEl.textContent=response.data.date_of_joining;
                roomNoEl.textContent=response.data.room_no;
                proffEl.textContent=response.data.t_profession;
               
            }
            else{
                alert(response.message)
            }
        
        });
        document.getElementById('back').addEventListener('click',function(){
           
                window.location.href='/home';
         
        })
    </script>
</body>
</html>