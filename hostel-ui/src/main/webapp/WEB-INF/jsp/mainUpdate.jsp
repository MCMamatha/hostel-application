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
            <label for="id">ID:</label>
            <input type="text" id="t_id" placeholder="" disabled><br>
            <label for="name">NAME:</label>
            <input type="text" id="name" placeholder=""><br>
            <label for="address">ADDRESS:</label>
            <input type="text" id="address" placeholder=""><br>
            <label for="phone">PHONE:</label>
            <input type="text" id="phone" placeholder="" ><br>
            <label for="date_of_joining">DATE OF JOINING:</label>
            <input type="text" id="date_id" placeholder="" disabled><br>
            <label for="room_no">ROOM NO:</label>
            <input type="text" id="roomno" placeholder=""><br>
            <label for="profession">PROFESSION:</label>
            <input type="text" id="profession" placeholder=""><br>
        </div>

        <button id="post">POST</button>
        <button id="back">BACK</button>

        <script type="text/javascript">
            let idEl = document.getElementById("t_id")
            let nameEl = document.getElementById("name")
            let addressEl = document.getElementById("address")
            let phoneEl = document.getElementById("phone")
            let dateEl = document.getElementById("date_id")
            let roomNoEl = document.getElementById("roomno")
            let proffEl = document.getElementById("profession")

            async function postData(url = "", data = {}) {
                const response = await fetch(url, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: new URLSearchParams(data).toString()
                });
                return response.json();
            }

            //let id;
            function updatedDetails(res) {
                idEl.value= res.data.t_id
                //id = res.data.t_id
                nameEl.value = res.data.t_name
                addressEl.value = res.data.t_address
                phoneEl.value = res.data.t_phone
                dateEl.value = res.data.date_of_joining
                roomNoEl.value = res.data.room_no
                proffEl.value = res.data.t_profession
            }

            document.getElementById("post").addEventListener("click", function (event) {
                idEl = document.getElementById("t_id");
                nameEl = document.getElementById("name");
                addressEl = document.getElementById("address");
                phoneEl = document.getElementById("phone");
                roomEl = document.getElementById("roomno");
                proffEl = document.getElementById("profession");
               


                postData('/edit/details/',{t_id:idEl.value,t_name:nameEl.value, t_address: addressEl.value, t_phone: phoneEl.value,room_no: roomEl.value, t_profession: proffEl.value}).then((response)=> {
                    
                    if (response.status == "success") {
                        alert("data posted successfully");
                        window.location.href='/home';
                    } else {
                        alert(response.message);
                    }
                })

                
                if (nameEl == null && addressEl == null && phoneEl == null && roomEl == null && proffEl == null) {
                    alert("No Changes Made")

                } else if (nameEl == "" && addressEl == "" && phoneEl == "" && roomEl == "" && proffEl == "") {
                    alert("field must be filled out")
                }
               
            })

            document.getElementById("back").addEventListener("click",function(){
                window.location.href='/home';
            })

            console.log()

            updatedDetails(<%=HostelController.getDetails()%>);
        </script>



    </body>

    </html>