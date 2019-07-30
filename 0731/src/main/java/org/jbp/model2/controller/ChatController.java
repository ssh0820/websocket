package org.jbp.model2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChatController {
	
	
	@RequestMapping(value="/main",method=RequestMethod.GET)
	public void main() {
		
		
	}

}
