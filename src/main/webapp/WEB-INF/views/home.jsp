<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.aspera.web.vo.itemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
	<head>
		<title>ASPERA by KJLEE</title>
		<meta charset="utf-8">
   	 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="resources/reset.css">
		<link rel="stylesheet" href="/resources/lib/jquery-ui.min.css">
<%--    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>--%>
		<script type="text/javascript" src="/resources/lib/jquery-3.6.0.min.js"></script>
		<script type="text/javascript" src="/resources/lib/jquery-ui.min.js"></script>
<%--		<script type="text/javascript" src="//d3gcli72yxqn2z.cloudfront.net/connect/v4/asperaweb-4.min.js"></script>--%>
		<script type="text/javascript" src="/resources/connect/v4/asperaweb-4.min.js"></script>
	   	<script type="text/javascript" src="/resources/connect/v4/connectinstaller-4.min.js"></script>
<%--		<script type="text/javascript" src="//d3gcli72yxqn2z.cloudfront.net/connect/v4/connectinstaller-4.min.js"></script>--%>
<%--		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">--%>
<%--		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>--%>
		<link rel="stylesheet" href="/resources/lib/bootstrap.min.css">
		<script type="text/javascript" src="/resources/lib/bootstrap.min.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/style.css" type="text/css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/mystyle.css" type="text/css">

		<script src="${request.getContextPath()}/resources/my-common.js?ver=1"></script>

		<!-- script src="<%=request.getContextPath() %>/resources/script.js?ver=1"></script-->
		<%-- <script src="${request.getContextPath()}/resources/script.js?ver=1"></script> --%>
		
	</head>

	<body>
		<h2 class="page-title">ASPERA by KJLEE</h2>
		<input id="logoutBtn" type="button" class="btn btn-default" style="position: absolute; right: 250px; top: 50px; width 120px" value="logout"></input>

		<h4 id="info">?????? ??????</h4>
		<div id="infoPannel">
		<ul>
			<li>?????? ??????
				<ul>
					<li>Spring framework 3.1.1</li>
					<li>Java 1.8</li>
					<li>Tomcat 9.0</li>
					<li>jQuery 1.11.2</li>
					<li>Aspera Connect 3.9.9.177872</li>
				</ul>
			</li>
			<li>?????? ??? ?????? ??????
				<ul>
					<li>Server : Linux 115.71.42.22</li>
					<li>Node API ?????? : admin</li>
					<li>Aspera Connect ?????? : asperatest</li>
				</ul>
			</li>
		</ul>
		</div>

		<!--Upload Area, note IDs match JavaScript for targeting-->
		<div class="row" id="uploadArea">
			<div class="col-lg-5">
				<div class="input-group">
					<button class="btn btn-default" id="refresh" type="button" name="${self.path }">Refresh</button>&nbsp;
					<button class="btn btn-default" id="create" type="button" name="${self.path }">Create Folder</button>&nbsp;
          			<button class="btn btn-default" id="downloadBtn" type="button" name="${self.path }">Download</button>&nbsp;
					<button class="btn btn-default" id="uploadfile" type="button" name="${self.path }">Upload File</button>&nbsp;
					<button class="btn btn-default" id="uploadfolder" type="button" name="${self.path }">Upload Folder</button>&nbsp;
					<button class="btn btn-default" id="deleteBtn" type="button" name="${self.path }">Delete Files</button>&nbsp;
					<button class="btn btn-default" id="transferWindowBtn" type="button" name="${self.path }">Transfer Window</button>&nbsp;
					<button class="btn btn-default" id="ajaxtest" type="button">Ajax API Test</button>&nbsp;
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-10">
				<div class="panel panel-default">
					<div class="panel-heading" id="currentDir">
						<div style="display:inline-block; overflow:hidden;">
							Browsing&nbsp;&nbsp;&nbsp;&nbsp;<span id="currentDirectory">${self.path }</span>
						</div>
					</div>
					<table class="table" id="fileListTable">
						<tr>
							<!--Table Header Rows, make sure that generated table listings match pattern-->
              <th>
                <input type="checkbox">
              </th>
							<th class="type-col headerRow">Type<span class="glyphicon glyphicon-sort-by-attributes sort-icon" aria-hidden="true"></span></th>
							<th class="name-col headerRow">Name<span class="glyphicon glyphicon-sort-by-attributes sort-icon" aria-hidden="true"></span></th>
							<th class="size-col headerRow">Size<span class="glyphicon glyphicon-sort-by-attributes sort-icon" aria-hidden="true"></span></th>
							<th class="mod-col headerRow">Last Modified<span class="glyphicon glyphicon-sort-by-attributes sort-icon" aria-hidden="true"></span></th>
							<th class="act-col"></th>
							<th class="act-col"></th>
						</tr>
						<c:if test="${self.path ne '/' }">
							<tr>
								<td class="type-col"></td>
								<td class="name-col"><a id="parentDirectory" name="${self.path }">Parent Directory</a></td>
								<td class="size-col"></td>
								<td class="mod-col"></td>
								<td class="act-col"></td>
								<td></td>
							</tr>						
						</c:if>
						<c:forEach var="i" items="${list}">
							<tr>
                <td><input type="checkbox" id="chk_${i.basename}" class="chkItem"></td>
								<td class="type-col">${i.type }</td>
								<c:choose>
									<c:when test="${i.type eq 'directory'}">
										<td class="name-col"><a class="move" name="${self.path }">${i.basename }</a></td>
										<td class="size-col"></td>
									</c:when>
									<c:when test="${i.type ne 'directory'}">
										<td class="name-col">${i.basename }</td>
										<td class="size-col">${i.size }</td>
									</c:when>
								</c:choose>
								<td class="mod-col">${i.mtime }</td>
								<td class="act-col" name="${self.path }"><a class="download" id="${i.basename }">download</a></td>
								<td>
									<div id="pageMenuButton">
										<a href="#" class="dropdown-toggle" id="pageMenuDrop" data-toggle="dropdown" aria-expanded="true"><span class="glyphicon glyphicon-cog"></span></a>
										<ul class="dropdown-menu" role="menu" aria-labelledby="pageMenuDrop">
											<li role="presentation"><a role="menuitem" tabindex="1" class="rename" id="${i.basename }" name="${self.path }">Rename</a></li>
											<li role="presentation"><a role="menuitem" tabindex="2" class="delete" id="${i.basename }" name="${self.path }">Delete</a></li>
										</ul>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div class="panel-heading" id="foot">
						<span>
							<select id="sort">
								<option value="default">?????? ??????</option>
								<option value="type_a">Default</option>	
								<option value="path_a">Name up</option>
								<option value="path_d">Name down</option>
								<option value="size_a">Size up</option>
								<option value="size_d">Size down</option>
								<option value="mtime_a">Time up</option>
								<option value="mtime_d">Time down</option>
							</select>
						</span>
					</div>
				</div>
			</div>
		</div>
		
    <!--  -->
    <!--  -->
		<!-- <div id="transferPopup" style="position:absolute;top:30%;left:50%;transform:translate(-50%, -50%); width: 550px; height: 300px; border: 1px solid black;display:none">
		 	<div style="display:flex;flex-direction:column; width: 100%; height:100%;">
				<div id="header" style="height:30px;background-color:#6C6CAA;"></div>
				<div id="body" style="flex:1; background-color:white;">
					<div id="inner" style="padding:5px 10px;height: 100%; display:flex;flex-direction:column;">
						<div style="height: 30px; margin:5px;display:flex;">
							<div style="width: 90px; height:30px;line-height:30px;text-align:center;">?????? ??????</div>
							<div style="flex: 1;"></div>
						</div>
						
						<div style="height: 60px;margin:5px;display:flex">
							<div style="" class="innerTableWrapper1">
								<div style="flex-direction: column" class="innerTableWrapper1">
									
										<div class="innerTable1 innerText1">?????? ??????:</div>
										<div class="innerTable1 innerText1">?????? ??????:</div>
									
								</div>
							</div>
							<div style="" class="innerTableWrapper1">
								<div style="flex-direction: column" class="innerTableWrapper1">
									
										<div class="innerTable1 innerText1"></div>
										<div class="innerTable1 innerText1"></div>
									
								</div>
							</div>	
							<div style="" class="innerTableWrapper1">
								<div style="flex-direction: column" class="innerTableWrapper1">
									
										<div class="innerTable1 innerText1">?????? ??????:</div>
										<div class="innerTable1 innerText1">?????? ??????:</div>
									
								</div>
							</div>
							<div style="" class="innerTableWrapper1">
								<div style="flex-direction: column" class="innerTableWrapper1">
									
										<div class="innerTable1 innerText1"></div>
										<div class="innerTable1 innerText1"></div>
									
								</div>
							</div>	
						</div>
						
						<div style="flex: 1;margin:5px;border: 1px solid black; display: flex;flex-direction:column;">
						
							<div style="height: 20px; display:flex;">
								
								<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">?????? ??????</div>
								<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">?????? ??????</div>
								<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">?????? ??????</div>
								<div  style="width:17px;" ></div>
							</div>
							<div style="overflow-y: scroll;  height:70px;display:flex;flex-direction:column;justify-content:flex-start;">
								<div style="height: 20px;display:flex;">
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>	
								</div>
								<div style="height: 20px;display:flex;">
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>	
								</div>
								<div style="height: 20px;display:flex;">
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>	
								</div>
								<div style="height: 20px;display:flex;">
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>	
								</div>
								<div style="height: 20px;display:flex;">
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>	
								</div>
								<div style="height: 20px;display:flex;">
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>
									<div style="flex:1;border: 1px solid lightblue;line-height:20px; text-align: center;">xxxx</div>	
								</div>
							</div>
						
						</div>
					</div>
				</div>
				<div id="bottom" style="height:30px; background-color:white;position: relative;">
					<input type="button" style="position: absolute; top: 2px; right: 120px;" class="button1" value="?????? ??????">
					<input type="button" style="position: absolute; top: 2px; right: 20px;" class="button1" value="??????">
				</div>
			</div>
		</div> -->

    <div
      id="transferPopup"
      style="
        position: absolute;
        top: 30%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 550px;
        height: 300px;
        border: 1px solid black;
        display: none;
      "
	  class="ui-widget-content"
    >
      <div
        style="display: flex; flex-direction: column; width: 100%; height: 100%"
      >
        <div
          id="header"
          style="
            height: 30px;
            background-color: #6c6caa;
            color: white;
            font-weight: bold;
          "
        >
          <!--  -->
          <span class=""></span>
          <span id="Aspera_UP_total_upload_percent" class=""></span>
          <span class="">-</span>
          <span id="Aspera_UP_current_upload_file_name"></span>
          <div style="float: right">
            <button
              id="Aspera_UP_close_btn"
              type="button"
              value="??????"
              style="
                width: 23px;
                margin: 0;
                padding: 0;
                height: 23px;
                font-size: 0;
                line-height: -1000em;
                border: 0;
                background: url(<%=request.getContextPath()%>/resources/image/close_btn.png)
                  no-repeat 0 0;
                background-size: cover;
              "
            >
              ??????
            </button>
          </div>
          <!--  -->
        </div>
        <div id="body" style="flex: 1; background-color: white">
          <div
            id="inner"
            style="
              padding: 5px 10px;
              height: 100%;
              display: flex;
              flex-direction: column;
            "
          >
            <div style="height: 30px; margin: 5px; display: flex">
              <div
                style="
                  width: 90px;
                  height: 30px;
                  line-height: 30px;
                  text-align: center;
                "
              >
                ?????? ??????
              </div>
              <div style="flex: 1">
                <span
                  id="Aspera_UP_total_upload_progress_bar"
                  class="pbar_value"
                  style="
                    display: inline-block;
                    width: 0%;
                    height: 100%;
                    background-color: blue;
                  "
                ></span>
              </div>
            </div>

            <div style="height: 60px; margin: 5px; display: flex">
              <div style="width: 90px; flex-direction: column">
                <div class="innerTable1 innerText1">?????? ??????:</div>
                <div class="innerTable1 innerText1">?????? ??????:</div>
              </div>
              <div class="innerTableWrapper1" style="flex-direction: column">
                <div
                  class="innerTable1 innerText1"
                  id="Aspera_UP_upload_count"
                ></div>
                <div
                  class="innerTable1 innerText1"
                  id="Aspera_UP_upload_size"
                ></div>
              </div>
              <div style="width: 90px; flex-direction: column">
                <div class="innerTable1 innerText1">?????? ??????:</div>
                <div class="innerTable1 innerText1">?????? ??????:</div>
              </div>
              <div class="innerTableWrapper1" style="flex-direction: column">
                <div
                  class="innerTable1 innerText1"
                  id="Aspera_UP_upload_speed"
                ></div>
                <div
                  class="innerTable1 innerText1"
                  id="Aspera_UP_upload_remainingtime"
                ></div>
              </div>
            </div>

            <div
              style="
                flex: 1;
                margin: 5px;
                border: 1px solid black;
                display: flex;
                flex-direction: column;
              "
            >
              <div style="height: 20px; display: flex">
                <div
                  style="
                    flex: 1;
                    border: 1px solid lightblue;
                    line-height: 20px;
                    text-align: center;
                  "
                >
                  ?????? ??????
                </div>
                <div
                  style="
                    flex: 1;
                    border: 1px solid lightblue;
                    line-height: 20px;
                    text-align: center;
                  "
                >
                  ?????? ??????
                </div>
                <div
                  style="
                    flex: 1;
                    border: 1px solid lightblue;
                    line-height: 20px;
                    text-align: center;
                  "
                >
                  ?????? ??????
                </div>
                <div style="width: 17px"></div>
              </div>
              <div
                style="
                  overflow-y: scroll;
                  height: 75px;
                  display: flex;
                  flex-direction: column;
                  justify-content: flex-start;
                "
                id="Aspera_UP_uploading_file_list"
              ></div>
              <!--  -->
              <!-- <div
                style="
                  overflow-y: scroll;
                  height: 70px;
                  display: flex;
                  flex-direction: column;
                  justify-content: flex-start;
                "
                id="Aspera_UP_uploading_file_list"
              >
                <div style="height: 20px; display: flex">
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                </div>
                <div style="height: 20px; display: flex">
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                </div>
                <div style="height: 20px; display: flex">
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                </div>
                <div style="height: 20px; display: flex">
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                </div>
                <div style="height: 20px; display: flex">
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                </div>
                <div style="height: 20px; display: flex">
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                  <div
                    style="
                      flex: 1;
                      border: 1px solid lightblue;
                      line-height: 20px;
                      text-align: center;
                    "
                  >
                    xxxx
                  </div>
                </div> 
              </div>-->
              <!--  -->
            </div>
          </div>
        </div>
        <div
          id="bottom"
          style="height: 30px; background-color: white; position: relative"
        >
          <input
            type="button"
            style="position: absolute; top: 2px; right: 120px"
            class="button1"
            value="?????? ??????"
            onclick="newTapTransfer()"
          />
          <input id="cancelOrCloseBtn"
            type="button"
            style="position: absolute; top: 2px; right: 20px"
            class="button1"
            value="??????"
            onclick="cancelAsperaTransfer()"
          />
        </div>
      </div>
      <div id="Aspera_init_chk"></div>
    </div>



	</body>
</html>




<script>
let asperaWeb = null;
let connectInstaller = null;
let transferUUID = "";
// installType ??????
let installType = {
	get: function () {
		if (localStorageSupported()) {
			return localStorage.installType || '';
		}
		return '';
	},
	set: function (installation) {
		if (localStorageSupported()) {
			try {
				localStorage.installType = installation;
			} catch (e) {
				// Ignore localStorage overages, for now.
			}
		}
	},
	unset: function () {
		if (localStorageSupported()) {
			localStorage.installType = '';
		}
	}
}
// fileControls ??????
let fileControls = {};
fileControls.setup = function ()
{
	// Add the Connect Plugin.
	asperaWeb = new AW4.Connect({pollingTime: 100});
	connectInstaller = new AW4.ConnectInstaller();
	asperaWeb.addEventListener(AW4.Connect.EVENT.STATUS, statusEventListener);
	asperaWeb.addEventListener(AW4.Connect.EVENT.TRANSFER, transferEventListener);

	// asperaWeb.initSession();
	let randomId = generateUUID();
	const appId = 'aspera_' + randomId;
	asperaWeb.initSession(appId);
	//console.log(appId);
}

function setUp() {
	installType.unset(); // ?????????????????? ?????????
	if (asperaWeb == null) {
		// Called if Aspera Connect is installed and meets version requirements.
		fileControls.setup();
	}
}

// ?????? ????????? ????????? ??????
document.addEventListener("DOMContentLoaded", function()
{
	// transferSpec get
	// $.ajax("/gettransferspec")
	// 	.done(function(json) {
	// 		// console.log('transferSpec:',json);
	//
	// 	})
	$( "#transferPopup" ).draggable();

	setUp();
});

// ????????????
document.getElementById('logoutBtn').addEventListener("click", function(event){
	  event.preventDefault();
	  location.href = '<%=request.getContextPath()%>' + "/logout";

});
// ????????? ?????? ??????
document.getElementById('transferWindowBtn').addEventListener("click", function(event){
	  event.preventDefault();
	  // openWindowPop("/transfer-popup", "");
	  let popupElement = document.getElementById('transferPopup');
	  toggle(popupElement);
});
// ????????????
document.getElementById('downloadBtn').addEventListener("click", function(event){
	  event.preventDefault();
	  //
    let pathList = [];
    let isChecked = false;
    $('.chkItem').each(function (index, obj) {
        if (this.checked === true) {
            //console.log(this.id);
            let pathItem = {
              "source": this.id.substring(4)
            };
            pathList.push(pathItem);
            isChecked = true;
        } 
    });

    if( isChecked === false ) {
      alert("??????????????? ????????? ???????????? ?????? ??? ?????????????????????!");
      return false;
    }

	let currentDirectory = $("#currentDirectory").text();

	//console.log('transferSpec', ${transferSpec});
	//let transferSpec = JSON.parse('${transferSpec}');
	let transferSpec = null;
	$.ajax("/gettransferspec")
	.done(function(result) {
		// console.log('transferSpec:',json);
		transferSpec = result;
		transferSpec.direction = "receive";
		transferSpec.source_root = currentDirectory;
		transferSpec.paths = pathList;

		var connectSpec = {
			"allow_dialogs" : false,
			"return_paths" : false,
			"return_files" : true,
			"use_absolute_destination_path" : false
		};

		var transferCallback = {
			success: function(result) {
				console.log('Start Aspera Transfer');
			},
			error: function(result) {
				var errorCode = result.error.code;
				var internal_message = result.error.internal_message;
				var user_message = result.error.user_message;
				console.log('Transfer Start Error(' + errorCode + ')' + ' ' + internal_message + ', ' + user_message);
			}
		};

		asperaWeb.startTransfer(transferSpec, connectSpec, transferCallback);
	})


    //////////////////////////
	// var transferSpec = {
    //     "direction": "receive",
    //     "remote_host": "115.71.42.22",
    //     "source_root": currentDirectory,
    //     "paths": pathList,
    //     //"remote_user": "asperatest",
    //     //"remote_password": "rootroot",
    //     "cipher": "none",
    //     "http_fallback": "true",
    //     "http_fallback_port": 8080,
    //     "rate_policy": "fair",
    //     "fasp_port": 33001,
    //     "ssh_port": 33001,
    //     "lock_min_rate": "false",
    //     "lock_policy": "false",
    //     "lock_target_rate": "false",
    //     "min_rate_kbps": 0,
    //     "target_rate_kbps": 1000000
    //     };
});

//
$("#ajaxtest").click(function (){
	// jquery AJAX sample
	// $.ajax({
	// 	url: 'apitestpost',
	// 	data: JSON.stringify({
	// 		id: 'myid',
	// 		password: 'mypassword'
	// 	}),
	// 	type: 'POST',
	// 	dataType: 'json',
	// 	contentType: 'application/json',
	// 	success: function (response){
	// 		console.log(response);
	// 	},
	// 	error: function (error){
	// 		console.log(error);
	// 	}
	// })
	//

	// vanilla js AJAX sample
	(async () => {
		const rawResponse = await fetch('/apitestpost', {
			method: 'POST',
			headers: {
				'Accept': 'application/json',
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				id: 'myid',
				password: 'mypassword'
			})
		});
		const content = await rawResponse.json();

		console.log('result:',content);
	})();
})
//
$("#Aspera_UP_close_btn").click(function(){
	cancelAsperaTransfer(); // ????????????
});

//browse parent directory
$("#parentDirectory").click(function(){
	filesPost("browse", $(this).attr("name") + "/", [".."]);
});

//browse
$(".move").click(function(){
	let current;
	if($(this).attr("name") === '/'){
		current =  $(this).attr("name");
	}else{
		current = $(this).attr("name") + "/";
	}

	filesPost("browse", current, [$(this).text()]);
});

//refresh
$("#refresh").click(function(){
	console.log('click');
	var current;
	if($(this).attr("name") === '/'){
		current =  $(this).attr("name");
	}else{
		current = $(this).attr("name") + "/";
	}

	filesPost("browse", current, ["", "type_a"]);
});

//create folder
$("#create").click(function(){
	var foldername = prompt("Enter a name for the new folder");
	var current;
	if($(this).attr("name") === '/'){
		current =  $(this).attr("name");
	}else{
		current = $(this).attr("name") + "/";
	}

	filesPost("create", current, [foldername]);
});

//download
$(".download").click(function(){
	// var transferSpec = {
	// 	"direction": "receive",
	// 	"remote_host": "115.71.42.22",
	// 	//"source_root": $(this).parent().attr("id")+"/",
	// 	"source_root": $("#currentDirectory").text(),
	// 	"paths": [
	// 		{
	// 			"source": $(this).attr("id")
	// 		}
	// 	],
	// 	"remote_user": "asperatest",
	// 	"remote_password": "rootroot",
	// 	"cipher": "none",
	// 	"http_fallback": "true",
	// 	"http_fallback_port": 8080,
	// 	"rate_policy": "fair",
	// 	"fasp_port": 33001,
	// 	"ssh_port": 33001,
	// 	"lock_min_rate": "false",
	// 	"lock_policy": "false",
	// 	"lock_target_rate": "false",
	// 	"min_rate_kbps": 0,
	// 	"target_rate_kbps": 1000000
	// };
	let source = $(this).attr("id");

	$.ajax("/gettransferspec")
		.done(function(result) {

			// console.log('transferSpec:',result);
			let transferSpec = result;
			transferSpec.direction = "receive";
			transferSpec.source_root = $("#currentDirectory").text();
			transferSpec.paths = [
				{
					"source": source
				}
			]

			var connectSpec = {
				"allow_dialogs" : false,
				"return_paths" : false,
				"return_files" : true,
				"use_absolute_destination_path" : false
			};

			var transferCallback = {
				success: function(result) {
					console.log('Start Aspera Transfer');
				},
				error: function(result) {
					var errorCode = result.error.code;
					var internal_message = result.error.internal_message;
					var user_message = result.error.user_message;
					console.log('Transfer Start Error(' + errorCode + ')' + ' ' + internal_message + ', ' + user_message);
				}
			};

			console.log('transferSpec:',result);
		 	asperaWeb.startTransfer(transferSpec, connectSpec, transferCallback);
		})

});

// ????????????
$(".rename").click(function(){
	var current;
	if($(this).attr("name") === '/'){
		current =  $(this).attr("name");
	}else{
		current = $(this).attr("name") + "/";
	}
	var changename = prompt("Enter a name for the name change");
	filesPost("rename", current, [$(this).attr("id"), changename]);
});

//delete
$(".delete").click(function(){
	if(confirm("The files/folders you have selected will be permanently deleted. Continue?")){
		var current;
		if($(this).attr("name") === '/'){
			current =  $(this).attr("name");
		}else{
			current = $(this).attr("name") + "/";
		}
		filesPost("delete", current, [$(this).attr("id")]);
	} else {
		return;
	}

});

$("#deleteBtn").click(function(event){
	event.preventDefault();
	  //
    let pathList = [];
    let isChecked = false;
    $('.chkItem').each(function (index, obj) {
        if (this.checked === true) {
            //console.log(this.id);
            let pathItem = this.id.substring(4);
            pathList.push(pathItem);
            isChecked = true;
        } 
    });

    if( isChecked === false ) {
      alert("????????? ????????? ???????????? ?????? ??? ???????????????!");
      return false;
    }

	// ????????? ????????????
	if(confirm("The files/folders you have selected will be permanently deleted. Continue?")){

		//$('.chkItem').each(function (index, obj) {
		//	if (this.checked === true) {
		//		//console.log(this.id);
		//		filesPost("delete", '/', this.id.substring(4));
		//	} 
    	//});
		//let currentDirectory = document.getElementById("currentDirectory").value;
		let currentDirectory = document.getElementById("currentDirectory").innerText;
		// let currentDirectory = $("#currentDirectory").text();
		filesPost("delete", currentDirectory, pathList);

	} else {
		return;
	}

});

//file upload
$("#uploadfile").click(function(){
	var current;
	if($(this).attr("name") === '/'){
		current = $(this).attr("name");
	}else{
		current = $(this).attr("name") + "/";
	}
	asperaWeb.showSelectFileDialog({
		success: function(dataTransfer) {
			let pathsList = [];
			for(var i=0; i<dataTransfer.dataTransfer.files.length; i++)
			{
				let pathItem = {
					"source": dataTransfer.dataTransfer.files[i].name
				}
				pathsList.push(pathItem);
			}
			//console.log('pathsList', pathsList);

			// var transferSpec = {
			// 	"direction": "send",
			// 	"remote_host": "115.71.42.22",
			// 	"destination_root": current,
			// 	"paths": pathsList,
			// 	"remote_user": "asperatest",
			// 	"remote_password": "rootroot",
			// 	"cipher": "none",
			// 	"http_fallback": "true",
			// 	"http_fallback_port": 8080,
			// 	"rate_policy": "fair",
			// 	"fasp_port": 33001,
			// 	"ssh_port": 33001,
			// 	"lock_min_rate": "false",
			// 	"lock_policy": "false",
			// 	"lock_target_rate": "false",
			// 	"min_rate_kbps": 0,
			// 	"target_rate_kbps": 1000000
			// };

			$.ajax("/gettransferspec")
				.done(function(result) {
					let transferSpec = result;
					transferSpec.direction = "send";
					transferSpec.destination_root = current;
					transferSpec.paths = pathsList;


					var connectSpec = {
						"allow_dialogs" : false,
						"return_paths" : false,
						"return_files" : true,
						"use_absolute_destination_path" : false
					};

					var transferCallback = {
						success: function(result) {
							console.log('Start Aspera Transfer');
						},
						error: function(result) {
							var errorCode = result.error.code;
							var internal_message = result.error.internal_message;
							var user_message = result.error.user_message;
							console.log('Transfer Start Error(' + errorCode + ')' + ' ' + internal_message + ', ' + user_message);
						}
					};

					asperaWeb.startTransfer(transferSpec, connectSpec, transferCallback);
				})
		},
		error: function () {
			//throw new Error('An error occurred with the Aspera Connect file dialog.');
			console.log('asperaWeb.showSelectFileDialog() failed');
		}
	});
});

//folder upload
$("#uploadfolder").click(function(){
	var current;
	if($(this).attr("name") === '/'){
		current = $(this).attr("name");
	}else{
		current = $(this).attr("name") + "/";
	}
	asperaWeb.showSelectFolderDialog({
		success: function(dataTransfer) {
			var temp = {
				"direction": "send",
				"remote_host": "115.71.42.22",
				"destination_root": current,
				"paths": [
					{
						"destination": "",
						"source": dataTransfer.dataTransfer.files[0].name
					}
				],
				"remote_user": "asperatest",
				"cipher": "none",
				"http_fallback": "true",
				"http_fallback_port": 8080,
				"rate_policy": "fair",
				"fasp_port": 33001,
				"ssh_port": 33001,
				"lock_min_rate": "false",
				"lock_policy": "false",
				"lock_target_rate": "false",
				"min_rate_kbps": 0,
				"target_rate_kbps": 1000000
			};
			asperaWeb.startTransfer(temp);
		},
		error: function () {
			//throw new Error('An error occurred with the Aspera Connect file dialog.');
		}
	});
});

// ???????????????
$("#info").click(function(){
	var toggle = document.getElementById("infoPannel");
	if(toggle.style.display === "block"){
		toggle.style.display = "none";
	}else {
		toggle.style.display = "block";
	}
});

// ??????
$("#sort").change(function(){
	var current;
	if($("#currentDirectory").text() === '/'){
		current =  $("#currentDirectory").text();
	}else{
		current = $("#currentDirectory").text() + "/";
	}
	filesPost("browse", current, ["", $(this).val()]);
});

//?????? ?????? ??????
function setAsperaPopup() {
	// console.log("AsperaPopup called");
	let popupElement = document.getElementById("transferPopup");
	// popupElement.style.display = "block";
	show(popupElement);
	// console.log(popupElement.style.display);
}

//?????? ?????? ??????
function delAsperaPopup() {
	let popupElement = document.getElementById("transferPopup");
	// popupElement.style.display = "none";
	$("#transferPopup").css("display","none");
}

//?????? ?????? X, ?????? ?????? ?????? ??? ????????? ??????
function cancelAsperaTransfer() {
	$("#Aspera_init_chk").text(""); // ????????? ?????? ????????? ???????????? ???????????? ?????? ????????? ????????? ?????????

	if (transferUUID == "" || transferUUID == undefined) {
		console.log('============ transferUUID is undefined!! =========');
		delAsperaPopup(); // ?????? ?????? ??????
		// ?????? ?????? ??????
		//document.getElementById('refresh').click(); // ???????????? ?????? ????????????
		return;
	}
	if (confirm("????????? ?????? ????????????. ????????? ?????????????????????????")) {
		var cancelCallback = {
			success: function (result) {
				delAsperaPopup();
				//
				asperaWeb.removeTransfer(transferUUID, {
					success: function (result){console.log(result)},
					error: function (result){console.log(result)}
				});
				// rest api delete

			},
			error: function (result) {
				var errorCode = result.error.code;
				var internal_message = result.error.internal_message;
				var user_message = result.error.user_message;
				console.log(
						"Transfer Start Error(" +
						errorCode +
						")" +
						" " +
						internal_message +
						", " +
						user_message
				);
				alert('Error : canceling Transfer');
				// popup close..
				delAsperaPopup();
			},
		};
		// asperaWeb.removeTransfer(transferUUID, cancelCallback);
		asperaWeb.stopTransfer(transferUUID, cancelCallback);
	}
}

// ?????????????????? ????????? ?????? ??????
function setTransferPopupData(data) {
	//console.log("enter!!!!!!!!!", data.transfers[0]);
	//????????????
	var totalFiles = data.transfers[0].files.length; //????????????
	var filesTitle = data.transfers[0].title; //?????? ?????????
	var compFiles = data.transfers[0].file_counts.completed; //??????????????????
	var transRate = data.transfers[0].calculated_rate_kbps; //????????????_kbps
	var percentage = data.transfers[0].percentage; //?????????
	var totalSize = data.transfers[0].bytes_expected; //????????????
	var writeSize = data.transfers[0].bytes_written; //???????????????
	var remainSize = totalSize - writeSize; //????????????
	//var remainTime = remainSize / (transRate / 8); //????????????
	var remainTime = data.transfers[0].remaining_usec / 1000000; //????????????
	var remainHour = parseInt(remainTime / 3600);
	var remainMin = parseInt((remainTime % 3600) / 60);
	var remainSec = remainTime % 60;

	var percentageStr = Math.floor(percentage * 100) + "%";
	var transRateStr =
			transRate / 8 > 1024
					? (transRate / 8 / 1024).toFixed(2) + " MB"
					: (transRate / 8).toFixed(2) + " KB";
	var totalSizeStr =
			totalSize / 1024 > 1024
					? (totalSize / 1024 / 1024).toFixed(2) + " MB"
					: (totalSize / 1024).toFixed(2) + " KB";
	var writeSizeStr =
			writeSize / 1024 > 1024
					? (writeSize / 1024 / 1024).toFixed(2) + " MB"
					: (writeSize / 1024).toFixed(2) + " KB";
	var remainTimeStr =
			remainHour != 0
					? remainHour + "?????? " + remainMin + "??? " + remainSec + "???"
					: remainMin != 0
							? remainMin + "??? " + remainSec + "???"
							: remainSec + "???";

	$("#Aspera_UP_current_upload_file_name").text(filesTitle);
	$("#Aspera_UP_total_upload_percent").text(percentageStr);
	$("#Aspera_UP_total_upload_progress_bar").css("width", percentageStr);
	$("#Aspera_UP_upload_count").text(compFiles + "/" + totalFiles);
	$("#Aspera_UP_upload_size").text(writeSizeStr + "/" + totalSizeStr);
	$("#Aspera_UP_upload_speed").text(transRateStr);
	$("#Aspera_UP_upload_remainingtime").text(remainTimeStr);

	////////////////////////////////////////////////////////////
	var initChk =
			( $("#Aspera_init_chk").text() != totalFiles + "" ) ? true : false; //?????? ????????? ?????? ??????

	//console.log('totalFiles', totalFiles);
	//////////////////////// only 1 time ////////////////////////////
	if (initChk) {
		// console.log('draw', totalFiles);
		var fileListhtml = "";
		for (var i = 0; i < totalFiles; i++) {
			var eachFileNameID = "Aspera_UP_uploadFileName_" + i;
			var eachFileSizeID = "Aspera_UP_uploadFileSize_" + i;
			var eachFileProgID = "Aspera_UP_uploadFileProgress_" + i;
			var eachFileStatID = "Aspera_UP_uploadFileStatus_" + i;

			fileListhtml += "<li style='display: flex;'>";
			fileListhtml +=
					"	<span id=" +
					eachFileNameID +
					' class="fname" style="display: inline-block;width: 170px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">';
			fileListhtml +=
					'		<span class="ficon"><img src="<%=request.getContextPath()%>/resources/image/etc.png" alt="mov"></span>';
			fileListhtml += "	</span>";
			fileListhtml +=
					'	<span class="fprogress" style="display: inline-block;width: calc( 100% - 180px );">';
			fileListhtml +=
					"		<span id=" +
					eachFileSizeID +
					' class="st" style="display: inline-block;width: 170px;"></span>';
			fileListhtml += '		<span class="pbar">';
			fileListhtml +=
					"			<span id=" + eachFileProgID + ' class="pbar_value"></span>';
			fileListhtml += "		</span>";
			fileListhtml +=
					"		<span id=" +
					eachFileStatID +
					' class="transfer_status dext5_ko-kr"></span>';
			fileListhtml += "	</span>";
			fileListhtml += "</li>";
		}
		// console.log(fileListhtml);
		$("#Aspera_UP_uploading_file_list").html(fileListhtml);
	}
	////////////////////////////////////////////////////////////////////////

	for (var i = 0; i < totalFiles; i++) {
		var eachFileNameID = "#Aspera_UP_uploadFileName_" + i;
		var eachFileSizeID = "#Aspera_UP_uploadFileSize_" + i;
		var eachFileProgID = "#Aspera_UP_uploadFileProgress_" + i;
		var eachFileStatID = "#Aspera_UP_uploadFileStatus_" + i;

		var eachData = data.transfers[0].files[i];

		var eachTotalSize = eachData.bytes_expected; //????????????
		var eachWriteSize = eachData.bytes_written; //???????????????

		// var eachStatusStr = eachWriteSize == 0 ? "?????????" : "?????????";
		var eachStatusStr = "";
		if (eachWriteSize == 0){
			eachStatusStr = "?????????" ;
		} else if( eachData.bytes_expected !== eachData.bytes_written ){
			eachStatusStr = "?????????" ;
		} else if(eachData.bytes_expected === eachData.bytes_written){
			eachStatusStr = "????????????" ;
		}

		$(eachFileStatID).text(eachStatusStr);

		var eachPercentageStr =
				((eachWriteSize / eachTotalSize) * 100).toFixed(1) + "%";
		$(eachFileProgID).css("width", eachPercentageStr);

		if (initChk) {
			var eachName = eachData.file; //????????????
			var sepIndex =
					eachName.lastIndexOf("/") >= 0
							? eachName.lastIndexOf("/")
							: eachName.lastIndexOf("\\");

			var eachFileNameStr = eachName.substring(sepIndex + 1);
			$(eachFileNameID).append(eachFileNameStr);

			var eachTotalSizeStr =
					eachTotalSize / 1024 > 1024
							? (eachTotalSize / 1024 / 1024).toFixed(2) + " MB"
							: (eachTotalSize / 1024).toFixed(2) + " KB";
			$(eachFileSizeID).text(eachTotalSizeStr);
		}
	}

	if (initChk) {
		$("#Aspera_init_chk").text(totalFiles);
	}
}

// ???????????? ??????????????? ?????? ????????? ??????
function statusEventListener(eventType, data) {
	if (eventType === AW4.Connect.EVENT.STATUS && data == AW4.Connect.STATUS.INITIALIZING) {
		connectInstaller.showLaunching();
	} else if (eventType === AW4.Connect.EVENT.STATUS && data == AW4.Connect.STATUS.FAILED) {
		connectInstaller.showDownload();
	} else if (eventType === AW4.Connect.EVENT.STATUS && data == AW4.Connect.STATUS.OUTDATED) {
		connectInstaller.showUpdate();
	} else if (eventType === AW4.Connect.EVENT.STATUS && data == AW4.Connect.STATUS.RUNNING) {
		connectInstaller.connected();
	}
};

// ???????????? ??????????????? ?????? ????????? ??????
function transferEventListener(eventType, data) {
	//console.log("tranfer????????? ??????!!", eventType, data);

	if (data.transfers.length <= 0) return; // exception early return;

	// data.transfers; // []
	// data.iteration_token;
	// data.result_count;
	// data = {};
	// AW4 = {
	//   iteration_token: '',
	//   result_count: 5,
	//   transfers: [],
	//   setup: () => {}
	//   ConnectInstaller: {
	//     showLaunching: () => {},
	//     showDownload: () => {},
	//   }
	// }
	// json: javascript object notation: ??????????????????
	// data[0], data[1]
	// data['iteration_token']
	// data["transfers"]
	// data.iteration_token
	// data.transfers

	// main logic
	var nowStatus;
	nowStatus = data.transfers[0].status;

	if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.INITIATING
	) {
		console.log("Transfer INITIATING!!!!");
		transferUUID = data.transfers[0].uuid;
		//?????? ????????? ??????
		// setAsperaPopup();
	}
	else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.RUNNING
	) {
		console.log("Transfer RUNNING!!!!!");
		transferUUID = data.transfers[0].uuid;
		//asperaWeb.getTransfer(transferUUID, {
		//	success: function(transferInfo){console.log(transferInfo)},
		//	error: function(error) {console.log(error)}
		//})
		// asperaWeb.getTransfer(transferUUID, function(transferInfo){
		// 	console.log(transferInfo);
		// })
		//?????? ????????? ??????
		setAsperaPopup();
		////////////////////////////
		setTransferPopupData(data);
		////////////////////////////
	} else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.COMPLETED
	) {
		console.log("Transfer COMPLETED");
		//delAsperaPopup();
		//?????? ????????? ??????
		setAsperaPopup();
		document.getElementById('cancelOrCloseBtn').value = '??????';
		////////////////////////////
		setTransferPopupData(data);
		////////////////////////////
		// progress bar 100%
		transferUUID = ""
		// grid : transferring => complete.
		// COMPLETED event.
		// for (var i = 0; i < transferItem.length; i++) {
		//   DUM.dataSource.add(transferItem[i]);
		// }

		// ???????????? refresh; !!!!!!!
		// filesPost("browse", '/', ["", "type_a"]);

	} else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.CANCELLED
	) {
		console.log("Transfer CANCELLED");
	} else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.FAILED
	) {
		console.log("Transfer FAILED");
	} else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.QUEUED
	) {
		console.log("Transfer QUEUED");
	} else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.REMOVED
	) {
		console.log("Transfer REMOVED");
	} else if (
			eventType === AW4.Connect.EVENT.TRANSFER &&
			nowStatus == AW4.Connect.TRANSFER_STATUS.WILLRETRY
	) {
		console.log("Transfer WILLRETRY");
	}
}

//files api
function filesPost(api, current, target){
	var fo = document.createElement("form");
	fo.setAttribute("method", "POST");
	fo.setAttribute("charset", "UTF-8")
	//fo.setAttribute("action", "/aspera/");
	fo.setAttribute("action", '<%=request.getContextPath() %>'+"/");

	var objs = document.createElement("input");
	objs.setAttribute("type", "hidden");
	objs.setAttribute("name", "api");
	objs.setAttribute("value", api);
	fo.appendChild(objs);

	objs = document.createElement("input");
	objs.setAttribute("type", "hidden");
	objs.setAttribute("name", "current");
	objs.setAttribute("value", current);
	fo.appendChild(objs);

	objs = document.createElement("input");
	objs.setAttribute("type", "hidden");
	objs.setAttribute("name", "target");
	objs.setAttribute("value", target);
	fo.appendChild(objs);

	document.body.appendChild(fo);
	fo.submit();
}
</script>