package com.aspera.web.vo;

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

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//@Getter
//@Setter
//@ToString
@Data
public class TransferSpec {
    private String direction;
    private String remote_host;
    private String source_root;
    private String paths;
    private String remote_user;
    private String remote_password;
    private String cipher;
    private String http_fallback;
    private int http_fallback_port;
    private String rate_policy;
    private int fasp_port;
    private int ssh_port;
    private String lock_min_rate;
    private String lock_policy;
    private String lock_target_rate;
    private int min_rate_kbps;
    private int target_rate_kbps;

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

    public TransferSpec() {
        this.remote_host = "115.71.42.22";
        this.remote_user = "asperatest";
        this.remote_password = "rootroot";
        this.cipher = "none";
        this.http_fallback = "true";
        this.http_fallback_port = 8080;
        this.rate_policy = "fair";
        this.fasp_port = 33001;
        this.ssh_port = 33001;
        this.lock_min_rate = "false";
        this.lock_policy = "false";
        this.lock_target_rate = "false";
        this.min_rate_kbps = 0;
        this.target_rate_kbps = 1000000;
    }
}
