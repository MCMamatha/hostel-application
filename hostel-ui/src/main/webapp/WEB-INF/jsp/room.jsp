<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        input {
            margin: 10px 0px 5px 0px;
        }

        p {
            margin: 10px 0px -7px 0px;
        }

        #backbtn {
            margin: 5px 0px 10px 0px;
        }

        body {
            background-image: url('/static/images/images.jpeg');
            background-size: cover;
        }

        tr,
        th,
        td {
            border: 1px solid green;
            border-collapse: collapse;
            height: 35px;
            text-align: center;
        }

        table {
            height: 50%;
            width: 50%;
            border-collapse: collapse;
            margin: 30px auto;
        }

        #btnContainer {
            text-align: center;
        }

        .id-input {
            background-color: transparent;
            outline: none;
            border: none;
        }
    </style>
</head>

<body>
    <div id="main-div">
        <div>
            <p>To add Rooms</p>
            <input type="text" id="rno" placeholder="Enter the room no"><br>
            <input type="text" id="rsha" placeholder="enter no of sharing"><br>
            <button id="addbtn">Add</button>
            <button id="backbtn">BACK</button>
        </div>
        <div>
            <p> To view room details</p>
            <input type="text" id="rid" placeholder="Enter the room id">
            <button id="viewbtn">VIEW</button>
        </div>
        <div>
            <p> To delete room details</p>
            <input type="text" id="rdid" placeholder="Enter the room id">
            <button id="deletebtn">DELETE</button>
        </div>
        <div>
            <p> To edit room details</p>
            <input type="text" id="reid" placeholder="Enter the room id">
            <button id="okbtn4">OK</button>
        </div>

    </div>
    <div id="btnContainer"></div>
    <script>

        let no = document.getElementById("rno")
        let sharing = document.getElementById("rsha")

        async function addroomget(url = "") {
            const res = await fetch(url, {
                method: "GET",
            })
            return res.json();
        }
        async function addroompost(url = "", data = {}) {

            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams(data).toString()
            });
            return response.json();

        }
        async function getviewdetails(url = "") {
            const res = await fetch(url, {
                method: "GET",
            })
            return res.json();
        }

        async function deleteroom(url = "", data = {}) {
            console.log(data);
            const response = await fetch(url, {
                method: "DELETE",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams(data).toString()
            })

            return response.json();

        }
        async function getiddetails(url = " ") {
            const response = await fetch(url, {
                method: "GET",
            })
            return response.json();
        }
        async function editmethod(url = "", data = {}) {
            console.log(data);
            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams(data).toString()
            })

            return response.json();

        }
        document.getElementById('addbtn').addEventListener('click', function () {
            addroompost('/newroom', { r_no: no.value, r_sharing: sharing.value }).then((response) => {
                if (response.status == 'success') {
                    console.log(response.data)
                    alert("room added successfully")
                } else {
                    alert(response.message);
                }

            })
        })
        document.getElementById("backbtn").addEventListener("click", function () {
            window.location.href = '/home';
        })

        document.getElementById('viewbtn').addEventListener('click', function () {
            let viewdetails = document.getElementById("rid")
            let mainContainerEl = document.getElementById("main-div")
            getviewdetails("/oneviewdetails/" + viewdetails.value).then((response) => {
                if (response.status == 'success') {
                    viewdetails.value = ""
                    console.log(response)
                    let tableTag = document.createElement("table")
                    let ColumnNameEl = document.createElement("tr")

                    let ColumnHeader1 = document.createElement("th")
                    ColumnHeader1.textContent = "room_id"
                    ColumnNameEl.appendChild(ColumnHeader1)

                    let ColumnHeader2 = document.createElement("th")
                    ColumnHeader2.textContent = "Room_no"
                    ColumnNameEl.appendChild(ColumnHeader2)

                    let ColumnHeader3 = document.createElement("th")
                    ColumnHeader3.textContent = "room_sharing"
                    ColumnNameEl.appendChild(ColumnHeader3)

                    tableTag.appendChild(ColumnNameEl)

                    let detailsEl = document.createElement("tr")



                    let idEl = document.createElement("td")
                    idEl.textContent = response.data.r_id
                    detailsEl.appendChild(idEl)

                    let rnoEl = document.createElement("td")
                    rnoEl.textContent = response.data.r_no
                    detailsEl.appendChild(rnoEl)

                    let sharingEl = document.createElement("td")
                    sharingEl.textContent = response.data.r_sharing
                    tableTag.appendChild(detailsEl)
                    detailsEl.appendChild(sharingEl)
                    mainContainerEl.appendChild(tableTag)



                } else {
                    alert(response.message);
                }
            })
        })
        document.getElementById('deletebtn').addEventListener('click', function () {
            if (confirm("are you sure to delete") == true) {
                let deleteid = document.getElementById('rdid').value
                deleteroom("/delete/roomdetails", { "id": deleteid }).then((response) => {
                    if (response.status == 'success') {
                        alert("id deleted successfully")
                        window.location.href = '/room';
                        document.getElementById('deletebtn').value
                    } else {
                        alert(response.message)
                    }
                })
            } else {
                alert("id is not deleted")
            }
        })
        let clicked = false
        document.getElementById('okbtn4').addEventListener('click', function () {
            let getid = document.getElementById("reid")
            let mainContainerEl = document.getElementById("main-div")
            console.log(getid)
            getiddetails("/getedit/details/" + getid.value).then((response) => {

                if (response.status == 'success') {
                    console.log(response)
                    let tableT = document.createElement("table")
                    let columnName = document.createElement("tr")

                    let columnh1 = document.createElement("th")
                    columnh1.textContent = "Room_id"
                    columnName.appendChild(columnh1)

                    let columnh2 = document.createElement("th")
                    columnh2.textContent = "Room no"
                    columnName.appendChild(columnh2)

                    let columnh3 = document.createElement("th")
                    columnh3.textContent = "Room_sharing"
                    columnName.appendChild(columnh3)

                    tableT.appendChild(columnName)

                    let detailsE = document.createElement("tr")

                    let idE = document.createElement("td")
                    let idinputEl = document.createElement("input")

                    idinputEl.value = response.data.r_id
                    idinputEl.classList.add("id-input")
                    idE.appendChild(idinputEl)
                    detailsE.appendChild(idE)

                    let roomnoE = document.createElement("td")
                    let noinputEl = document.createElement("input")
                    noinputEl.value = response.data.r_no
                    noinputEl.classList.add("id-input")
                    roomnoE.appendChild(noinputEl)
                    detailsE.appendChild(roomnoE)

                    let sharingE = document.createElement("td")
                    let sharinginputEl = document.createElement("input")
                    sharinginputEl.value = response.data.r_sharing
                    sharinginputEl.classList.add("id-input")
                    sharingE.appendChild(sharinginputEl)
                    tableT.appendChild(detailsE)
                    detailsE.appendChild(sharingE)
                    mainContainerEl.appendChild(tableT)

                    let btnContainerEl = document.getElementById("btnContainer")
                    let postbtn = document.createElement("button")

                    if (clicked == false) {
                        postbtn.textContent = "Update"
                        btnContainerEl.appendChild(postbtn)
                        clicked = true
                    }


                    postbtn.addEventListener('click', function () {
                        console.log("update btn clicked")
                        editmethod("/edit/tenent/details", { r_id: parseInt(idinputEl.value), r_no: parseInt(noinputEl.value), r_sharing: parseInt(sharinginputEl.value) }).then((response) => {
                            console.log(response)
                            if (response.status == 'success') {
                                alert("updated successfully")
                                window.location.href='/rooms'
                            }

                        })
                    })

                } else {
                    alert(response.message);
                }
            })

        })

    </script>

</body>

</html>