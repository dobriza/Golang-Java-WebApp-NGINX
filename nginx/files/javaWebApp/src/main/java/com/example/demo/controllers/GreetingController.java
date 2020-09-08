package com.example.demo.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

// Определяем контроллер, как сущность отслеживающую и управляющую доступом к страницам сайта 
@Controller
public class GreetingController {

	// Указываем, что обрабатываем URL адрес корневого каталога веб сервера
	@GetMapping("/")
	// Определяем функцию "home", которая вызывается при переходе на главную страницу сайта 
	// Шаблон html страницы лежит в каталоге demo\src\main\resources\templates\home.html
	// Функции "home" передаём параметр model
	public String home(Model model) {
		model.addAttribute("title", "Главная страница");
		return "home";
	}

}