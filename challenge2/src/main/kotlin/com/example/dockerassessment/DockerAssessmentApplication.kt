package com.example.dockerassessment

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@SpringBootApplication
class DockerAssessmentApplication

fun main(args: Array<String>) {
    runApplication<DockerAssessmentApplication>(*args)
}

@RestController
@RequestMapping("/api")
class PingPongController() {

    @GetMapping("ping")
    fun getPing(): String {
        return "Pong"
    }
}
