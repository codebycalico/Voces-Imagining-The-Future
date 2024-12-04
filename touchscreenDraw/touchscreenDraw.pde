// Created by Calico
// December 3, 2024
// For Voces at OMSI, Imagining the Future

int doneButtonX, doneButtonY, clearButtonX, clearButtonY; // Button positioning
int doneButtonSize = 100; // Button image diameter
int clearButtonSize = 100; // Button image diameter
//PImage doneButton, clearButton; // Load button image
Button clearButton;
Button submitButton;

PFont font;

int startTimer, stopTimer; // Timer to check how long it's been since someone touched the screen
int WHITE = color(255);

char[] submitText = {'S', 'u', 'b', 'm', 'i', 't', 't', 'i', 'n', 'g', '.', '.', '.'};
String nothingDrawnString = "Draw a little more!";
String submitString = "Submitting...";
// OMSI brand colors, in order: moss agate, heliotrope, holley, darker holley, rose quartz, jasper, sardonyx, carnelian, chrysocolla, and darker chrysocolla.
color[] OMSIcolors = { color(0, 144, 102), color(49, 52, 19), color(199, 162, 204), color(116, 68, 121),
                      color(237, 139, 185), color(244, 230, 107), color(246, 141, 61),
                      color(239, 56, 39), color(149, 217, 240), color(25, 125, 159) };
int colorIndex;

void setup() {
  size(1080, 1080);
  background(255);
  noCursor();
  smooth();
  
  // Setup buttons dimensions and load images
  clearButton = new Button(0, 0, 350, 100, "RESET", OMSIcolors[8], OMSIcolors[9]);
  submitButton = new Button( (width - 350), 0, 350, 100, "SUBMIT", OMSIcolors[3], OMSIcolors[4]);
  
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
        saveFrame("submissions/submission_" + random(1, 100) + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + millis() + ".png");
        submitNotification();
      }
    }
    
    if( abs(pmouseX - mouseX) <= 40 && abs(pmouseY - mouseY) <= 40) {
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
  rect(submitButton.Pos.x, submitButton.Pos.y, submitButton.Width + 10, submitButton.Height + 10);
  rect(clearButton.Pos.x, clearButton.Pos.y, clearButton.Width + 10, clearButton.Height + 10);
}
