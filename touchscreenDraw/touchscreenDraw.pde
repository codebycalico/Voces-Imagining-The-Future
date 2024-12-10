// Created by Calico
// December 3, 2024
// For Voces at OMSI, Imagining the Future

// Sending drawn images code from example:
// https://github.com/torb-no/processing-experiments/tree/master/CamNetClient

import processing.net.*;

Client client;
JPGEncoder jpg;

Button clearButton, submitButton;
Button chrys, carn, jasp, moss, onyx;
Button english, spanish;

String outputName;
PFont font, buttonFont;

int startTimer, stopTimer; // Timer to check how long it's been since someone touched the screen
final int WHITE = color(255);
// Switches to choose the colors
int colorPicker = 10; // 10 = onyx, 0 = moss, 5 = jasp, 7 = carn, 8 = chrys

private static final String submitStringEnglish = "Submitted!";
private static final String submitStringSpanish = "Enviado!";
boolean eng = true;

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
final color[] OMSI_COLORS = { color(0, 144, 102), color(49, 52, 19), color(199, 162, 204), 
                              color(116, 68, 121), color(237, 139, 185), color(244, 230, 107),
                              color(246, 141, 61), color(239, 56, 39), color(149, 217, 240),
                              color(25, 125, 159) };
final color ONYX_COLOR = color(0, 0, 2);
final color FLINT_COLOR = color(255);

int colorIndex = 0;

final static int BORDER_X = 210;
final static int BORDER_Y = 150;
int BORDER_WIDTH, BORDER_HEIGHT;

void setup() {
  size(1800, 1000);
  background(255);
  noCursor();
  smooth();
  
  jpg = new JPGEncoder();
  String server = "127.0.0.1";
  client = new Client(this, server, 5203);
  println("Starting client...");
  
   // Load OMSI font
  font = createFont("/data/PlusJakartaSans-Bold.ttf", 107);
  buttonFont = createFont("/data/PlusJakartaSans-Regular.ttf", 48);
  
  // Setup buttons dimensions and load images
  setupButtons();
  strokeWeight(4);
  textAlign(CENTER, CENTER);
  
  BORDER_WIDTH = width - 600;
  BORDER_HEIGHT = height - 200;
}

void draw() {
  updateButtons();
  createBorder();
  if(eng) {
    headerTextEnglish();
  }
  if(!eng){
    headerTextSpanish();
  }
  
  // If the screen is touched, first check if a button was touched
  if(mousePressed) {
    // Language controller
    if(spanish.isPressed()) {
      resetHeader();
      eng = false;
    }
    if(english.isPressed()) {
      resetHeader();
      eng = true;
    }
    
    // Clear button was pressed, just clear the screen
    if(clearButton.isPressed()) {
      if(stopTimer - startTimer >= 1500){
        delay(100);
        println("Clear Button pressed.");
        resetBackground();
      }
    }
    
    // Submit button was pressed
    // Delay so it can't be spammed
    // Remove the buttons from the screen to take a screenshot
    // Save the drawing
    // Send the image to the projection
    if(submitButton.isPressed()) {
      if(stopTimer - startTimer >= 1500) {
        println("Submit Button pressed.");
        removeButtons(1);
        delay(200);
        outputName = "submissions/submission_" + random(1, 100) + month() + "_" 
                      + day() + "_" + hour() + "_" + minute() + "_" + millis() + ".jpg";
        saveFrame(outputName);
        if(eng) {
          submitNotificationEnglish();
        }
        if(!eng) {
          submitNotificationSpanish();
        }
        sendFrame();
      }
    }
    
    // Check if a color was pressed to change the drawing color
    if(chrys.isPressed()) {
      delay(200);
      println("Chrysocolla pressed.");
      colorPicker = 8;
    } else if(carn.isPressed()) {
      delay(200);
      println("Carnelian pressed");
      colorPicker = 7;
    } else if(jasp.isPressed()) {
      delay(200);
      println("Jasper pressed.");
      colorPicker = 5;
    } else if(moss.isPressed()) {
      delay(200);
      println("Moss pressed.");
      colorPicker = 0;
    } else if(onyx.isPressed()) {
      delay(200);
      println("Onyx pressed.");
      colorPicker = 10;
    }
    startTimer = millis();
    
    // If no button was pressed, it's time to draw!
    if( abs(pmouseX - mouseX) <= 30 && abs(pmouseY - mouseY) <= 30
         && mouseX > BORDER_X && mouseX < BORDER_WIDTH
         && mouseY > BORDER_Y && mouseY < BORDER_HEIGHT) {
      if(colorPicker == 10) {
        stroke(0, 0, 2);
      } else {
        stroke(OMSI_COLORS[colorPicker]);
      }
      line(mouseX, mouseY, pmouseX, pmouseY);
      startTimer = millis();
    }
  }
  stopTimer = millis();
  
  // Switching the buttons to show or not based on 
  // if the screen has been drawn on in the last 1.5 seconds.
  if(stopTimer - startTimer >= 1500){
    renderButtons();
  } else {
    removeButtons(colorPicker);
  }
}

// Create the border / frame
void createBorder() {
  stroke(ONYX_COLOR);
  line(BORDER_X, BORDER_Y, (BORDER_X + BORDER_WIDTH), BORDER_Y);
  line(BORDER_X, BORDER_Y, BORDER_X, (BORDER_Y + BORDER_HEIGHT));
  line(BORDER_X, (BORDER_Y + BORDER_HEIGHT), (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  line((BORDER_X + BORDER_WIDTH), BORDER_Y, (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
}

// Reset background to white
void resetBackground() {
  background(255);
}

void resetHeader() {
  stroke(255);
  fill(255);
  rect(0, 0, width, BORDER_X - 50);
}

void headerTextEnglish() {
  stroke(ONYX_COLOR);
  textFont(buttonFont, 70);
  text("What is your hope for the future of our planet?", width/2, 80);
}

void headerTextSpanish() {
  stroke(ONYX_COLOR);
  textFont(buttonFont, 70);
  text("Que es tu esperanzo para la futura del mundo de nosotros?", width/2, 80);
}

// Show text "Submitting..." with a little bounce
void submitNotificationEnglish() {
  background(255);
  textFont(font);
  int charX = 300;
  for(int i = 0; i < submitStringEnglish.length(); i++) {
    fill(OMSI_COLORS[colorIndex]);
    text(submitStringEnglish.charAt(i), charX, (height/2 + random(-30, 30)));
    colorIndex = (colorIndex + 1) % OMSI_COLORS.length;
    charX += (width / submitStringEnglish.length()) - 50;
  }
}

// Show text "Submitting..." with a little bounce
void submitNotificationSpanish() {
  background(255);
  textFont(font);
  int charX = 300;
  for(int i = 0; i < submitStringSpanish.length(); i++) {
    fill(OMSI_COLORS[colorIndex]);
    text(submitStringSpanish.charAt(i), charX, (height/2 + random(-30, 30)));
    colorIndex = (colorIndex + 1) % OMSI_COLORS.length;
    charX += (width / submitStringSpanish.length()) - 50;
  }
}

// Send the image to the other processing sketch
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
