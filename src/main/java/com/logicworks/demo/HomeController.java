
package com.logicworks.demo;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("environment", System.getenv().getOrDefault("ENVIRONMENT", "DEV"));
        model.addAttribute("region", System.getenv().getOrDefault("AWS_REGION", "local"));
        model.addAttribute("version", System.getenv().getOrDefault("APP_VERSION", "1.0.0"));
        return "index";
    }
}
