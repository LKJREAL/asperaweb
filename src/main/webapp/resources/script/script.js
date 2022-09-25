$(document).ready(function(){
    var asperaWeb = null;
    var connectInstaller = null;

    function setUp() {
        installType.unset();
        if (asperaWeb == null) {
            handleConnectReady();
          }
    }

    function localStorageSupported() {
        try {
          return "localStorage" in window && window["localStorage"] !== null;
        } catch (e) {
          return false;
        }
    }

    var installType = {
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

    var handleConnectReady = function () {
        // Called if Aspera Connect is installed and meets version requirements.
        fileControls.setup();
    };

    fileControls = {};
    fileControls.setup = function () {
        // Add the Connect Plugin.
        asperaWeb = new AW4.Connect();
        connectInstaller = new AW4.ConnectInstaller();
        var statusEventListener = function (eventType, data) {
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
        asperaWeb.addEventListener(AW4.Connect.EVENT.STATUS, statusEventListener);
        //asperaWeb.addEventListener(AW4.Connect.EVENT.TRANSFER, handleTransferEvents);
        asperaWeb.initSession();
    }

    //files api
    var filesPost = function(api, current, target){
        var fo = document.createElement("form");
        fo.setAttribute("method", "POST");
        fo.setAttribute("charset", "UTF-8")
        fo.setAttribute("action", "/aspera/");
        
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

    //browse parent directory
    $("#parentDirectory").click(function(){
        filesPost("browse", $(this).attr("name") + "/", [".."]);
    });

    //browse
    $(".move").click(function(){
        var current;
        if($(this).attr("name") === '/'){
          current =  $(this).attr("name");
        }else{
          current = $(this).attr("name") + "/";
        }

        filesPost("browse", current, [$(this).text()]);
    });

    //refresh
    $("#refresh").click(function(){
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

      var temp = {
        "direction": "receive",
        "remote_host": "115.71.42.22",
        "source_root": $(this).parent().attr("id")+"/",
        "paths": [
            {
              "destination": "",
                "source": $(this).attr("id")
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
    });
    
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
          for(var i=0; i<dataTransfer.dataTransfer.files.length; i++){
            var temp = {
              "direction": "send",
              "remote_host": "115.71.42.22",
              "destination_root": current,
              "paths": [
                  {
                    "destination": "",
                      "source": dataTransfer.dataTransfer.files[i].name
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
          }
          
        },
        error: function () {
          //throw new Error('An error occurred with the Aspera Connect file dialog.');
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

    $("#info").click(function(){
        var toggle = document.getElementById("infoPannel");
        if(toggle.style.display === "block"){
          toggle.style.display = "none";
        }else {
          toggle.style.display = "block";
        }
    });
    
    $("#sort").change(function(){
        var current;
        if($("#currentDirectory").text() === '/'){
          current =  $("#currentDirectory").text();
        }else{
          current = $("#currentDirectory").text() + "/";
        }
        filesPost("browse", current, ["", $(this).val()]);
    });

    setUp();    

});