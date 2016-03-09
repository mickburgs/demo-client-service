package com.maxxton.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by burgs.m on 7-3-2016.
 */
@RestController
public class DemoClientController
{
    @Autowired
    DemoServerClient demoServerClient;

    @RequestMapping(value="/hello",method= RequestMethod.GET)
    public String hello(@RequestParam String name) {
        return demoServerClient.greet(name);
    }
}