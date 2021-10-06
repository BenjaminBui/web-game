
<%@page import="DTO.User"%>
<%@page import="DAO.DAOUser"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    </head>
    <body id="particles-js"></body>
    <%
        String user_id = (String) session.getAttribute("Name").toString();
        DAOUser daouser = new DAOUser();
        User user = daouser.getUserbyUsername(user_id);
    %>
    <div class="animate__animated animate__backInDown">
        <div class="navigation">
            <a id="a1" class="button" href="homepage.jsp" >
                <img id="imgNav" src="img/exit.png">
                <div class="logout" href="homepage.jsp">Quit</div>
            </a>
        </div>
    </div>
    <div class="animate__animated animate__backInDown">
        <div class="navigation">
            <a id="a1" class="button" href="PayGame.jsp" >
                <img id="imgNav" src="img/coin-stack.png">
                <div class="logout" href="PayGame.jsp">Point</div>
            </a>
        </div>
    </div>
    <div class="animate__animated animate__backInDown">
        <div class="container" style="height: 50px; top: 70px">
            <input type="text" value="<% user.getPoint(); %>" style="border-radius: 0px 8px 8px 0px; font-size: 15px; height: 20px;width: 80px;text-align: center; float: right; top: 25%; right: 5%; position: absolute; cursor: default" readonly >
            <input type="text" value="<% user.getPoint();%>" style="border-radius: 8px 0px 0px 8px ; font-size: 15px; height: 20px;width: 120px;text-align: center; float: right; top: 25%; right: 28%; position: absolute; cursor: default" readonly >
        </div>
    </div>
    <div class="animate__animated animate__backInDown">
        <div class="container" style="top: 150px">
            <div>
                <h1 style="color: #ffffff">Roll</h1>
                <img class="img1" src="img/dice6.png">
                <img class="img2" src="img/dice6.png">
                <img class="img3" src="img/dice6.png">
            </div>
            <div style="margin-top: 20px">
                <h2 style="color: #ffffff; font-size: 18px">&nbsp;</h2>
                <h3 style="color: #ffffff"></h3>
                <input id="xubet" type="number" placeholder="Point" onkeypress="myFunction(event)" style="border-radius: 8px; font-size: 17px; height: 30px;width: 250px;bottom: 50%;text-align: center">
                <p id="demo"></p>
                <button class="bn632-hover bn20" id="tai" value="Tài" onclick="checkwinTai()" style="width: 100px; height: 100px; align-items: center"><img id="max" src="img/up.png" style="height: 50px;"></button>
                <button class="bn632-hover bn20" id="xiu" value="Tài" onclick="checkwinXiu()" style="width: 100px; height: 100px; align-items: center"><img id="min" src="img/up.png" style="height: 50px; transform: rotate(180deg);"></button>
            </div>
        </div>
    </div>

    <script src="particles.js-master/particles.js"></script>
    <script src="particles.js-master/demo/js/app.js"></script>
    <script type="text/javascript">
                    var total = 0;
                    var bet = 0;
                    const pointuser = point.value;
                    var websocket = new WebSocket("ws://localhost:8080/Webtaixiu/Playgame");
                    websocket.onopen = function (message) {
                        processOpen(message);
                    };
                    websocket.onmessage = function (message) {
                        processMessage(message);
                    };
                    websocket.onclose = function (message) {
                        processClose(message);
                    };
                    websocket.onerror = function (message) {
                        processError(message);
                    };

                    function processOpen(message) {

                    }
                    function processMessage(message) {
                        document.querySelector("h2").innerHTML = "Please bet";
                        document.getElementById("tai").disabled = false;
                        document.getElementById("xiu").disabled = false;
                        setDedefault();
                        setTimeout(function () {
                            console.log(message);
                            const ab = message.data.split("/");
                            const a = ab[0];

                            console.log(a);
                            document.querySelector(".img1").setAttribute("src",
                                    "img/dice" + a[0] + ".png");
                            document.querySelector(".img2").setAttribute("src",
                                    "img/dice" + a[1] + ".png");
                            document.querySelector(".img3").setAttribute("src",
                                    "img/dice" + a[2] + ".png");
                            total = Number(a[0]) + Number(a[1]) + Number(a[2]);
                            if (total < 10) {
                                if (bet == 2) {
                                    document.querySelector("h2").innerHTML = "Congratulations you Win";
                                    bet = 0;
                                    let xuafterbet = Number(pointuser) + Number(xubet.value * 1.5);
                                    point.value = xuafterbet;
                                    sendResult("thang", "xiu", xubet.value, xubet.value * 1.5, ab[1]);

                                } else if (bet == 0) {
                                    document.querySelector("h2").innerHTML = "You haven't bet";
                                } else {
                                    let xuafterbet = Number(pointuser) - Number(xubet.value);
                                    point.value = xuafterbet;
                                    sendResult("thua", "xiu", xubet.value, 0, ab[1]);
                                    bet = 0;
                                    document.querySelector("h2").innerHTML = "Sorry you lose";
                                }
                                document.querySelector("h1").innerHTML = "Min";
                            } else {
                                if (bet == 1) {
                                    let xuafterbet = Number(pointuser) + Number(xubet.value * 1.5);
                                    point.value = xuafterbet;
                                    document.querySelector("h2").innerHTML = "Congratulations you Win";
                                    bet = 0;
                                    sendResult("thang", "tai", xubet.value, xubet.value * 1.5, ab[1]);
                                } else if (bet == 0) {
                                    document.querySelector("h2").innerHTML = "You haven't bet";

                                } else {
                                    let xuafterbet = Number(pointuser) - Number(xubet.value);
                                    point.value = xuafterbet;
                                    bet = 0;
                                    sendResult("thua", "tai", xubet.value, 0, ab[1]);
                                    document.querySelector("h2").innerHTML = "Sorry you lose";
                                }
                                document.querySelector("h1").innerHTML = "Max";
                            }
                            document.getElementById("tai").disabled = true;
                            document.getElementById("xiu").disabled = true;
                            total = 0;
                        }, 10000);

                    }
                    function processClose(message) {
                        textAreaMessage.value += "Server Disconnect... \n";
                    }
                    function processError(message) {
                        textAreaMessage.value += "Error... " + message + " \n";
                    }
                    function  checkwinTai() {
                        var checkbetTai = document.getElementById("tai").value;
                        bet = 1;
                        document.querySelector("h2").innerHTML = "You just bet max";
                    }
                    function  checkwinXiu() {
                        var checkbetXiu = document.getElementById("xiu").value;
                        bet = 2;
                        document.querySelector("h2").innerHTML = "You just bet min";
                    }
                    function setDedefault() {
                        document.querySelector("h1").innerHTML = "Please wait 60s";
                        document.querySelector(".img1").setAttribute("src",
                                "img/dice6.png");
                        document.querySelector(".img2").setAttribute("src",
                                "img/dice6.png");
                        document.querySelector(".img3").setAttribute("src",
                                "img/dice6.png");
                    }
                    var reusltserver = new WebSocket("ws://localhost:8080/Webtaixiu/sendresults");
                    reusltserver.onopen = function (message1) {
                        processOpen(message1);
                    };
                    reusltserver.onmessage = function (message1) {
                        processMessage(message);
                    };
                    reusltserver.onclose = function (message1) {
                        processClose(message);
                    };
                    reusltserver.onerror = function (message1) {
                        processError(message1);
                    };
                    function sendResult(result, bet, xubet, xuresult, idroom) {
                        if (typeof reusltserver != 'undefined' && reusltserver.readyState == WebSocket.OPEN) {
                            reusltserver.send(document.getElementById("id_user").value + "/" + result + "/" + bet + "/" + xubet + "/" + xuresult + "/" + idroom);
                        }
                    }
                    ;
                    function myFunction(event) {
                        var x = event.which || event.keyCode;
                        let text = String.fromCharCode(x);
                        console.log(text);
                        if (Number(text) > Number(pointuser)) {
                            document.getElementById("demo").innerHTML = "Your point is not enough";
                            document.getElementById("tai").disabled = true;
                            document.getElementById("xiu").disabled = true;
                        } else {
                            let xuafterbet = Number(pointuser) - Number(text);
                            point.value = xuafterbet;
                            document.getElementById("tai").disabled = false;
                            document.getElementById("xiu").disabled = false;
                            document.getElementById("demo").innerHTML = "";
                        }

                    }
    </script>
</html>
