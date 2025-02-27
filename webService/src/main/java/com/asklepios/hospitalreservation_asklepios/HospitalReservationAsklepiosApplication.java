package com.asklepios.hospitalreservation_asklepios;

import jakarta.annotation.PostConstruct;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.time.LocalTime;
import java.util.TimeZone;

@SpringBootApplication
public class HospitalReservationAsklepiosApplication {

    @PostConstruct
    public void init() {
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
    }

    public static void main(String[] args) {
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
        System.out.println("현재 시간은 : " + LocalTime.now());
        SpringApplication.run(HospitalReservationAsklepiosApplication.class, args);
    }
}
