<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <style>
        input {
            margin: 10px 0px;
        }

        #divp {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }

        tr,
        td,
        th {
            border: 1px solid green;
            border-collapse: collapse;
            height: 35px;
            text-align: center;

        }

        body {
            background-image: url("static/images/loginbac.jpg");
        }

        table {
            width: 80%;
            border: 1px solid;
            border-collapse: collapse;
            margin: 30px auto;
        }

        p {
            margin: 10px 0px -7px 0px;
        }

        .modal {
            display: none;
            /* Hidden by default */
            position: fixed;
            /* Stay in place */
            z-index: 1;
            /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;
            /* Full width */
            height: 100%;
            /* Full height */
            overflow: auto;
            /* Enable scroll if needed */
            background-color: rgb(0, 0, 0);
            /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4);
            /* Black w/ opacity */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 90%;
            /* Could be more or less, depending on screen size */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>

</head>

<body>
    <div id="main-container">
        <div>
            <button id="aroom">Add Rooms</button>
            <button id="viewall">To view all the tenent details</button>
            <div id="myModal" class="modal">
                <div class="modal-content" id="modal-content">
                    <span class="close">&times;</span>
                    <table id="table"></table>
                </div>
            </div>
        </div>
        <div id="divp">
            <div id="div1">
                <p>Add Tenenet details</p>
                <input type="text" id="tname" placeholder="tenent name" /><br>
                <input type="text" id="taddress" placeholder="tenent address" /><br>
                <input type="tel" id="phone" placeholder="phone no" /><br>
                <input type="text" id="roomno" placeholder="room no" /><br>
                <input type="text" id="profession" placeholder="profession" /><br>
                <button id="add">ADD</button>
            </div>
            <div class="divsContainer">
                <div id="div2">
                    <p>To edit the details of the Tenent</p>
                    <input type="text" id="id" placeholder="enter id">
                    <button id="ok">OK</button>
                </div>
                <div>
                    <p>To delete the details</p>
                    <input type="text" id="deleteid" placeholder="enter id">
                    <button id="delete">DELETE</button>
                </div>
                <div>
                    <p>To view the tenentdetails</p>
                    <input type="text" id="viewInput" placeholder="enter id">
                    <button id="viewBtn">VIEW</button>
                </div>
                <div>
                    <p>to upload image of the Tenenet</p>
                    <input type="text" id="upload" placeholder="enter id">
                    <button id="okbtn">Ok</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        let name = document.getElementById("tname")
        var taddress = document.getElementById('taddress');
        var phone = document.getElementById('phone');
        let mainContainerEl = document.getElementById("main-container")
        console.log(phone)
        console.log(name)

        var room = document.getElementById('roomno');
        var profession = document.getElementById('profession');
        async function updateEx(url = "") {
            const res = await fetch(url, {
                method: "GET",
            })
            return res.json();
        }
        async function postData(url = "", data = {}) {
            console.log(data);
            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams(data).toString()
            });
            return response.json();
            console.log("hello")
        }
        async function deleteEx(url = "", data = {}) {
            console.log(data);
            const response = await fetch(url, {
                method: "DELETE",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams(data).toString()
            });
            return response.json();
            console.log("hello")
        }
        async function getdetails(url = "") {
            const ress = await fetch(url, {
                method: "GET",
            })
            return ress.json();
        }

        document.getElementById('add').addEventListener('click', function () {

            postData("/newtenent", { t_name: name.value, t_address: taddress.value, t_phone: phone.value, room_no: room.value, t_profession: profession.value }).then((response) => {
                console.log("response" + response.status);
                if (response.status == 'success') {

                    window.location.href = '/main';
                } else {
                    alert(response.message);
                }
            })
        })
        document.getElementById('ok').addEventListener('click', function () {
            updateEx("/updateEx/" + id.value).then((response) => {
                if (response.status == 'success') {
                    window.location.href = '/mainupdate/' + id.value;
                } else {
                    alert(response.message);
                }
            })
        })
        document.getElementById('delete').addEventListener('click', function () {

            if (confirm("are you sure to delete") == true) {
                let delete_id = document.getElementById('deleteid').value
                deleteEx("/delete/details", { "id": delete_id }).then((response) => {
                    if (response.status == 'success') {
                        alert("id deleted sucessfully")
                        window.location.href = '/home' + id.value;
                        document.getElementById('deleteid').value
                    } else {
                        alert(response.message);
                    }
                })
            } else {
                alert("id is not deleted")
            }
        })
        document.getElementById('viewBtn').addEventListener('click', function () {
            let viewInputEl = document.getElementById("viewInput")
            
            getdetails("/onedetails/" + viewInputEl.value).then((response) => {
                if (response.status == 'success') {
                    viewInputEl.value=""
                    let tableTag = document.createElement("table")
                    let ColumnNameEl = document.createElement("tr")

                    let ColumnHeader1 = document.createElement("th")
                    ColumnHeader1.textContent = "Id"
                    ColumnNameEl.appendChild(ColumnHeader1)

                    let ColumnHeader2 = document.createElement("th")
                    ColumnHeader2.textContent = "Name"
                    ColumnNameEl.appendChild(ColumnHeader2)

                    let ColumnHeader3 = document.createElement("th")
                    ColumnHeader3.textContent = "Address"
                    ColumnNameEl.appendChild(ColumnHeader3)

                    let ColumnHeader4 = document.createElement("th")
                    ColumnHeader4.textContent = "Phone no"
                    ColumnNameEl.appendChild(ColumnHeader4)

                    let ColumnHeader5 = document.createElement("th")
                    ColumnHeader5.textContent = "Date of joining"
                    ColumnNameEl.appendChild(ColumnHeader5)

                    let ColumnHeader6 = document.createElement("th")
                    ColumnHeader6.textContent = "Room no"
                    ColumnNameEl.appendChild(ColumnHeader6)

                    let ColumnHeader7 = document.createElement("th")
                    ColumnHeader7.textContent = "Profession"
                    ColumnNameEl.appendChild(ColumnHeader7)

                    tableTag.appendChild(ColumnNameEl)

                    let detailsEl = document.createElement("tr")

                    let idEl = document.createElement("td")
                    idEl.textContent = response.data.t_id
                    detailsEl.appendChild(idEl)

                    let nameEl = document.createElement("td")
                    nameEl.textContent = response.data.t_name
                    detailsEl.appendChild(nameEl)

                    let addressEl = document.createElement("td")
                    addressEl.textContent = response.data.t_address
                    detailsEl.appendChild(addressEl)

                    let phoneEl = document.createElement("td")
                    phoneEl.textContent = response.data.t_phone
                    detailsEl.appendChild(phoneEl)

                    let dateEl = document.createElement("td")
                    dateEl.textContent = response.data.date_of_joining
                    detailsEl.appendChild(dateEl)

                    let roomEl = document.createElement("td")
                    roomEl.textContent = response.data.room_no
                    detailsEl.appendChild(roomEl)

                    let professionEl = document.createElement("td")
                    professionEl.textContent = response.data.t_profession
                    detailsEl.appendChild(professionEl)

                    tableTag.appendChild(detailsEl)
                    mainContainerEl.appendChild(tableTag)



                } else {
                    alert(response.message);
                }
            })

        })
        document.getElementById('aroom').addEventListener('click', function () {
            window.location.href = '/room';
        })
        async function getone_id(url = "") {
            const ress = await fetch(url, {
                method: "GET",
            })
            return ress.json();
        }

        async function getall(url = "") {
            const ress = await fetch(url, {
                method: "GET",
            })
            return ress.json();
        }

        document.getElementById('okbtn').addEventListener('click', function () {
            let idvalue = document.getElementById('upload')
            console.log(idvalue)
            getone_id("/getoneid/" + idvalue.value).then((response) => {
                if (response.status == 'success') {
                    window.location.href = '/image';
                } else {
                    alert(response.message)
                }
            })

        })

        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];
        span.onclick = function () {
            modal.style.display = "none";
        }
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
       
        let modelEl = document.getElementById("modal-content")
        let tableTagEl = document.getElementById("table")
        function appendAllTenents(tenent){
            console.log(tenent.t_profession
            )
            let rowEl=document.createElement("tr")

            tIdEl=document.createElement("td")
            tIdEl.textContent=tenent.t_id
            
            tNameEl=document.createElement("td")
            tNameEl.textContent=tenent.t_name

            tAddEl=document.createElement("td")
            tAddEl.textContent=tenent.t_address

            tPhoneEl=document.createElement("td")
            tPhoneEl.textContent=tenent.t_phone

            tJoiningDtEl=document.createElement("td")
            tJoiningDtEl.textContent=tenent.date_of_joining

            tRoomNoEl=document.createElement("td")
            tRoomNoEl.textContent=tenent.room_no

            tProfessionEl=document.createElement("td")
            tProfessionEl.textContent=tenent.t_profession


            rowEl.append(tIdEl,tNameEl,tAddEl,tPhoneEl,tJoiningDtEl,tRoomNoEl,tProfessionEl)
            tableTagEl.append(rowEl)
            modelEl.appendChild(tableTagEl)
        }
        document.getElementById('viewall').addEventListener('click', function () {
            getall("/viewall/tenent").then((response) => {
                if (response.status == "success") {
                    tableTagEl.innerHTML=""
                    modal.style.display = "block";
                    let modelEl = document.getElementById("modal-content")
                    let headingEl = document.createElement("tr")
                    let listOfHeadings = ["ID", "NAME", "ADDRESS", "PHONE", "DATE_OF_JOINING", "ROOM_NO", "PROFESSION"]

                    for (let heading of listOfHeadings) {
                        let hdTag = document.createElement("th")
                        hdTag.textContent = heading
                        headingEl.appendChild(hdTag)
                    }
                    tableTagEl.appendChild(headingEl)
                    modelEl.appendChild(tableTagEl)

                    for (let tenent of response.data) {
                        appendAllTenents(tenent)
                    }
                }
            })

        })

    </script>
</body>

</html>