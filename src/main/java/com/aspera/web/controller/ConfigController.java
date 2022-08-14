package com.aspera.web.controller;

import com.aspera.web.vo.TestItemVO;
import com.aspera.web.vo.TransferSpec;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
public class ConfigController {

    @RequestMapping(value = "/gettransferspec", method = RequestMethod.GET)
    @ResponseBody
    public TransferSpec getTransferSpec(){
        TransferSpec transferSpec = new TransferSpec();
        return transferSpec;
    }

    @RequestMapping(value = "/apitestpost", method = RequestMethod.POST)
    @ResponseBody
    public TransferSpec apitestpost(@RequestBody TestItemVO testItemVO){
        log.warn("in apitestpost"+testItemVO.toString());
        TransferSpec transferSpec = new TransferSpec();
        return transferSpec;
    }
}
