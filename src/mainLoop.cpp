/*
 * File:   main.cpp
 * Author: yourok
 *
 * Created on March 13, 2015, 6:39 PM
 */

#include <Arduino.h>

int ledPin = 13; // LED connected to digital pin 13

void setup() {
    pinMode(ledPin, OUTPUT); // sets the digital pin as output
}

void loop() {
    digitalWrite(ledPin, HIGH); // sets the LED on
    delay(500); // waits for a second
    digitalWrite(ledPin, LOW); // sets the LED off
    delay(500); // waits for a second
}