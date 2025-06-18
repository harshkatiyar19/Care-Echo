package com.example.ExchangeA_Nasdaq;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class CareEchoApplication {

	public static void main(String[] args) {
		SpringApplication.run(CareEchoApplication.class, args);
	}

}
