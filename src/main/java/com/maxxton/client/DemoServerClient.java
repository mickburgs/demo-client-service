package com.maxxton.client;

import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by burgs.m on 7-3-2016.
 */
@FeignClient("demo-server-service")
public interface DemoServerClient
{
    @RequestMapping( method= RequestMethod.GET, value="/greet")
    public String greet(@RequestParam("name") String name);
}