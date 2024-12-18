// Created by Calico
// December 3, 2024
// For Voces at OMSI, Imagining the Future

// Sending drawn images code from example:
// https://github.com/torb-no/processing-experiments/tree/master/CamNetClient

// Variables for saving and sending the drawing
import processing.net.*;
Client client;
JPGEncoder jpg;
String outputName;

// Create Buttons for colors, submit / clear, and english / spanish
Button clearButton, submitButton;
Button chrys, carn, jasp, moss, onyx;
Button english, spanish, colorSelect;

PFont font, buttonFont;

int startTimer;

private static final String submitStringEnglish = "Submitted!";
private static final String submitStringSpanish = "¡Envió!";
boolean eng = true;
boolean submitted = false;

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
// [10] sardonyx
final color[] OMSI_COLORS = { color(0, 144, 102), color(49, 52, 19), color(199, 162, 204), 
                              color(116, 68, 121), color(237, 139, 185), color(244, 230, 107),
                              color(246, 141, 61), color(239, 56, 39), color(149, 217, 240),
                              color(25, 125, 159), color(246, 141, 61) };
final color ONYX_COLOR = color(0, 0, 2);
final color FLINT_COLOR = color(255);
final color BACKGROUND = color(181, 251, 255);

int colorIndex = 0;
// Sets the drawing color
int colorPicker = 10;

// Variables for the border
final static int BORDER_X = 210;
final static int BORDER_Y = 150;
int BORDER_WIDTH, BORDER_HEIGHT;

void setup() {
  //fullScreen();
  size(1920, 1080);
  background(255);
  //noCursor();
  smooth();
  
  // Starting the sender
  jpg = new JPGEncoder();
  String server = "127.0.0.1";
  client = new Client(this, server, 5203);
  println("Starting sender...");
  
   // Load OMSI font
  font = createFont("/data/NotoSans-VariableFont_wdth,wght.ttf", 107);
  buttonFont = createFont("/data/NotoSans-VariableFont_wdth,wght.ttf", 48);
  
  // Setup buttons
  setupButtons();
  strokeWeight(4);
  textAlign(CENTER, CENTER);
  
  // Set the frame's borders
  BORDER_WIDTH = width - 600;
  BORDER_HEIGHT = height - 200;
}

void draw() {
  updateButtons();
  createBorder();
  renderButtons();
  
  // Check the language
  if(spanish.isPressed()) {
     resetHeader();
     eng = false;
  }
  if(english.isPressed()) {
    resetHeader();
    eng = true;
  }
  
  if(eng) {
    headerTextEnglish();
  } else if(!eng){
    headerTextSpanish();
  }
  
  // Clear button was pressed, just clear the drawing screen
  if(clearButton.isPressed()) {
    println("Clear Button pressed.");
    stroke(0);
    fill(255);
    rect(BORDER_X, BORDER_Y, BORDER_WIDTH, BORDER_HEIGHT);
  }
  
  // Save the drawing as a file, send the file to the other sketch, and play the little submit animation
  if(submitButton.isPressed()) {
    println("Submit Button pressed.");
    // Reset mouseX and mouseY so it doesn't submit multiples
    mouseX = width/2;
    mouseY = height/2;
    removeButtons();
    //delay(150);
    outputName = "submissions/submission_" + random(1, 100) + month() + "_" 
                  + day() + "_" + hour() + "_" + minute() + "_" + millis() + ".jpg";
    saveFrame(outputName);
    sendFrame();
    startTimer = millis();
    submitted = true;
  }
  
  // Play the submitted animation for three seconds after the submit button was pressed
  // Then clear the screen
  if(submitted) {
      if(eng) {
        submitNotificationEnglish();
        delay(100);
      }
      if(!eng) {
        submitNotificationSpanish();
        delay(100);
      }
      
      if(millis() - startTimer > 3000) {
        submitted = false;
        background(255);
      }
   }
  
  // Check if a color is pressed, change the drawing color
  if(chrys.isPressed()) {
    println("Chrysocolla pressed.");
    colorPicker = 9;
  } else if(carn.isPressed()) {
    println("Carnelian pressed");
    colorPicker = 7;
  } else if(jasp.isPressed()) {
    println("Jasper pressed.");
    colorPicker = 5;
  } else if(moss.isPressed()) {
    println("Moss pressed.");
    colorPicker = 0;
  } else if(onyx.isPressed()) {
    println("Onyx pressed.");
    colorPicker = 10;
  }
  
  // Draw on the given drawing area
  if(mousePressed) {
    if( abs(pmouseX - mouseX) <= 40 && abs(pmouseY - mouseY) <= 40
         && mouseX > BORDER_X && mouseX < BORDER_X + BORDER_WIDTH
         && mouseY > BORDER_Y && mouseY < BORDER_Y + BORDER_HEIGHT
         && pmouseX > BORDER_X && pmouseX < BORDER_X + BORDER_WIDTH
         && pmouseY > BORDER_Y && pmouseY < BORDER_Y + BORDER_HEIGHT) {
      if(colorPicker == 10) {
        stroke(0, 0, 2);
      } else {
        stroke(OMSI_COLORS[colorPicker]);
      }
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
  }
}

// Create the border / frame
void createBorder() {
  stroke(ONYX_COLOR);
  line(BORDER_X, BORDER_Y, (BORDER_X + BORDER_WIDTH), BORDER_Y);
  line(BORDER_X, BORDER_Y, BORDER_X, (BORDER_Y + BORDER_HEIGHT));
  line(BORDER_X, (BORDER_Y + BORDER_HEIGHT), (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  line((BORDER_X + BORDER_WIDTH), BORDER_Y, (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  noStroke();
  fill(BACKGROUND);
  rect(0, 0, width, BORDER_Y);
  rect(0, 0, BORDER_X, height);
  rect(0, (BORDER_Y + BORDER_HEIGHT), width, height);
  rect( (BORDER_X + BORDER_WIDTH), BORDER_Y, width, height);
}

// White out the header for when the language is changed
void resetHeader() {
  stroke(255);
  fill(255);
  rect(0, 0, width, BORDER_X - 50);
}

void headerTextEnglish() {
  stroke(ONYX_COLOR);
  textFont(buttonFont, 70);
  text("What is your hope for the future of our planet?", (BORDER_X + (BORDER_WIDTH/2)), 50);
  textFont(buttonFont, 27);
  text("Write or draw your message here. Then press SUBMIT to add it to the animated mural projection!", (width/2 - 150), (BORDER_Y - 30) );
}

void headerTextSpanish() {
  stroke(ONYX_COLOR);
  textFont(buttonFont, 70);
  text("¿Cuál es tu esperanza para el futuro de nuestro planeta?", width/2, 50);
  textFont(buttonFont, 27);
  text("Escribe o dibuja tu mensaje en la pantalla táctil. Luego presiona ENVIAR para agregarlo a la proyección del mural animado.", (width/2 + 17), (BORDER_Y - 30) );
}

// Show text "Submitted!" with a little bounce
void submitNotificationEnglish() {
  background(255);
  textFont(font);
  int charX = 300;
  for(int i = 0; i < submitStringEnglish.length(); i++) {
    fill(OMSI_COLORS[colorIndex]);
    text(submitStringEnglish.charAt(i), charX, (height/2 + random(-30, 30)));
    colorIndex = (colorIndex + 1) % OMSI_COLORS.length;
    charX += (width / submitStringEnglish.length()) - 60;
  }
}

// Show text "¡Envió!" with a little bounce
void submitNotificationSpanish() {
  background(255);
  textFont(font);
  int charX = 300;
  for(int i = 0; i < submitStringSpanish.length(); i++) {
    fill(OMSI_COLORS[colorIndex]);
    text(submitStringSpanish.charAt(i), charX, (height/2 + random(-30, 30)));
    colorIndex = (colorIndex + 1) % OMSI_COLORS.length;
    charX += (width / submitStringSpanish.length()) - 70;
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
    println("Sent.");
  } catch (IOException e) {
    println("IOException!");
  }
}
