package com.example.CareEcho.Exchanges.Nasdaq;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class ControllerWs {

    @MessageMapping("/chat") // client sends to /app/chat
    @SendTo("/topic/book2") // broadcast to /topic/messages
    public Book send(Book book) {
        return book;
    }
}
