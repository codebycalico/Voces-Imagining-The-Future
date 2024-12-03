// Created by Calico
// December 3, 2024
// For Voces at OMSI, Imagining the Future

int doneButtonX, doneButtonY, clearButtonX, clearButtonY; // Button positioning
int doneButtonSize = 100; // Button image diameter
int clearButtonSize = 100; // Button image diameter
PImage doneButton, clearButton; // Load button image

int startTimer, stopTimer; // Timer to check how long it's been since someone touched the screen
int WHITE = color(255);

void setup() {
  size(1080, 1080);
  background(255);
  noCursor();
  smooth();
  
  // Setup buttons dimensions and load images
  doneButtonX = width - 130;
  doneButtonY = 20;
  doneButton = loadImage("/data/panicButton.png");
  clearButtonX = 30;
  clearButtonY = 20;
  clearButton = loadImage("/data/clearButton.png");
}

void draw() {
    if(mousePressed) {
      // Check if pressing on the done button
       if( doneButtonPressed() ) {
         if( isScreenBlank() ) {
           println("Nothing has been drawn.");
           resetBackground();
         } else {
           println("Done Button pressed.");
           rect(doneButtonX, doneButtonY, 100, 100);
           rect(clearButtonX, clearButtonY, 150, 75);
           saveFrame("submissions/submission_" + random(1, 100) + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + millis() + ".png");
           fadeBackground();
           resetBackground();
         }
       }
      
       // Check if pressing on the clear button
       if( clearButtonPressed() ) {
         println("Clear Button pressed.");
         resetBackground();
       }
      
       if( abs(pmouseX - mouseX) <= 50 && abs(pmouseY - mouseY) <= 50) {
           // If not pressing on the button, draw
           stroke(0);
           line(mouseX, mouseY, pmouseX, pmouseY);
           startTimer = millis();
       }
    }
    stopTimer = millis();
  
    // Switching the buttons to show or not based on if the screen has been touched in the last 1.5 seconds.
    if(stopTimer - startTimer >= 1500){
      // Button images
      tint(255, 255);
      image(doneButton, doneButtonX, doneButtonY, 100, 100);
      image(clearButton, clearButtonX, clearButtonY, 150, 75);
    } else {
      // Make the button images transparent / disappear
      fill(255);
      noStroke();
      rect(doneButtonX, doneButtonY, 100, 100);
      rect(clearButtonX, clearButtonY, 150, 75);
    }
}

// Check to see if the done button was pressed
boolean doneButtonPressed() {
  return (mouseX >= doneButtonX && mouseX <= 1025 && mouseY >= doneButtonY && mouseY <= 100);
}

// Check to see if the clear button was pressed
boolean clearButtonPressed() {
  return (mouseX >= clearButtonX && mouseX <= 160 && mouseY >= clearButtonY && mouseY <= 100);
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
  if(whiteCount >= (pixels.length - 18000) ) {
    updatePixels();
    return true;
  }
  
  updatePixels();
  return false;
}

void fadeBackground() {
  float a = alpha(pixels[0]);
  loadPixels();
  for(int i = 0; i < pixels.length; i++){
    pixels[i] = color(255, 255, 255, a - 4);
  }
  updatePixels();
}
