// Created by Calico
// December 3, 2024
// For Voces at OMSI, Imagining the Future

import processing.net.*;

Client client;
JPGEncoder jpg;

Button clearButton;
Button submitButton;

String outputName;
PFont font;

int startTimer, stopTimer; // Timer to check how long it's been since someone touched the screen
int WHITE = color(255);

char[] submitText = {'S', 'u', 'b', 'm', 'i', 't', 't', 'i', 'n', 'g', '.', '.', '.'};
String nothingDrawnString = "Draw a little more!";
String submitString = "Submitting...";
// OMSI brand colors: 
// [0] moss agate
// [1] heliotrope
// [2] holley
// [3] darker holley
// [4] rose quartz
// [5] jasper
// [6] sardonyx
// [7] carnelian
// [8] chrysocolla
// [9] darker chrysocolla
color[] OMSIcolors = { color(0, 144, 102), color(49, 52, 19), color(199, 162, 204), color(116, 68, 121),
                      color(237, 139, 185), color(244, 230, 107), color(246, 141, 61),
                      color(239, 56, 39), color(149, 217, 240), color(25, 125, 159) };
int colorIndex;

void setup() {
  size(1080, 1080);
  background(255);
  noCursor();
  smooth();
  
  jpg = new JPGEncoder();
  String server = "127.0.0.1";
  client = new Client(this, server, 5203);
  println("Starting client...");
  
  // Setup buttons dimensions and load images
  clearButton = new Button(0, 0, 350, 100, "RESET", OMSIcolors[8], OMSIcolors[9]);
  submitButton = new Button( (width - 350), 0, 350, 100, "SUBMIT", OMSIcolors[4], OMSIcolors[3]);
  
  // Load OMSI font
  font = createFont("/data/PlusJakartaSans-Bold.ttf", 107);
}

void draw() {
  clearButton.update();
  submitButton.update();
  
  if(mousePressed) {
    if(clearButton.isPressed()) {
      println("Clear Button pressed.");
      resetBackground();
    }
    
    if(submitButton.isPressed()) {
      if( isScreenBlank() ) {
        println("Nothing has been drawn.");
        nothingDrawnNotification();
        //resetBackground();
      } else {
        println("Submit Button pressed.");
        removeButtons();
        outputName = "submissions/submission_" + random(1, 100) + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + millis() + ".jpg";
        saveFrame(outputName);
        sendFrame();
        submitNotification();
      }
    }
    
    if( abs(pmouseX - mouseX) <= 20 && abs(pmouseY - mouseY) <= 20) {
      // If not pressing on the button, draw
      stroke(0);
      line(mouseX, mouseY, pmouseX, pmouseY);
      startTimer = millis();
    }
  }
  stopTimer = millis();
  
  // Switching the buttons to show or not based on if the screen has been touched in the last 1.5 seconds.
  if(stopTimer - startTimer >= 1500){
    submitButton.render();
    clearButton.render();
  } else {
    removeButtons();
  }
}

// Reset background to white
void resetBackground() {
  background(255);
}

// Check if the screen has anything on it.
boolean isScreenBlank() {
  int whiteCount = 0;
  loadPixels();
  
  for(int i = 0; i < pixels.length; i++){
    if(pixels[i] == WHITE){
      whiteCount++;
    }
  }
  
  //println("White count is: " + whiteCount);
  //println("Pixel length is: " + pixels.length);
  if(whiteCount >= (pixels.length - 73000) ) {
    updatePixels();
    return true;
  }
  
  updatePixels();
  return false;
}

void nothingDrawnNotification() {
  background(255);
  textFont(font);
  int charX = 50;
  for(int i = 0; i < nothingDrawnString.length(); i++) {
    fill(OMSIcolors[colorIndex]);
    textAlign(CENTER);
    text(nothingDrawnString.charAt(i), charX, height/2);
    colorIndex = (colorIndex + 1) % OMSIcolors.length;
    charX += width / nothingDrawnString.length();
  }
}

void submitNotification() {
  background(255);
  textFont(font);
  int charX = 50;
  for(int i = 0; i < submitString.length(); i++) {
    fill(OMSIcolors[colorIndex]);
    textAlign(CENTER);
    text(submitString.charAt(i), charX, height/2);
    colorIndex = (colorIndex + 1) % OMSIcolors.length;
    charX += width / submitString.length();
  }
}

void removeButtons() {
  fill(255);
  noStroke();
  rect(submitButton.Pos.x - 10, submitButton.Pos.y, submitButton.Width + 10, submitButton.Height + 5);
  rect(clearButton.Pos.x, clearButton.Pos.y, clearButton.Width + 10, clearButton.Height + 5);
}

void sendFrame() {
  try {
    PImage img = loadImage(outputName);
    img.resize(500, 0);
  
    println("Encoding...");
    byte[] jpgBytes = jpg.encode(img, 0.1F);

    println("Writing file length to server: " + jpgBytes.length);
    // Taken from: https://processing.org/discourse/beta/num_1192330628.html
    client.write(jpgBytes.length / 256);
    client.write(jpgBytes.length % 256);

    println("Writing jpg bytes to server...");
    client.write(jpgBytes);
  } catch (IOException e) {
    println("IOException!");
  }
}
