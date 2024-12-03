int doneButtonX, doneButtonY, clearButtonX, clearButtonY; // Button positioning
int doneButtonSize = 100; // Button image diameter
int clearButtonSize = 100; // Button image diameter
PImage doneButton, clearButton; // Load button image
int startTimer, stopTimer;

void setup() {
  size(1080, 1080);
  background(255);
  noCursor();
  
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
         println("Done Button pressed.");
         rect(doneButtonX, doneButtonY, 100, 100);
         rect(clearButtonX, clearButtonY, 150, 75);
         saveFrame("submissions/submission_" + random(1, 100) + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + millis() + ".png");
         reset();
       }
      
       // Check if pressing on the clear button
       if( clearButtonPressed() ) {
         println("Clear Button pressed.");
         background(255);
       }
      
       if( abs(pmouseX - mouseX) <= 70 && abs(pmouseY - mouseY) <= 70) {
           // If not pressing on the button, draw
           stroke(0);
           line(mouseX, mouseY, pmouseX, pmouseY);
           startTimer = millis();
       }
    }
    stopTimer = millis();
    println("Start timer: " + startTimer);
    println("Stop timer: " + stopTimer);
  
    if(stopTimer - startTimer >= 2000){
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

boolean doneButtonPressed() {
  return (mouseX >= doneButtonX && mouseX <= (doneButtonX + width) && mouseY >= doneButtonY && mouseY <= (doneButtonY + height));
}

boolean clearButtonPressed() {
  return (mouseX >= clearButtonX && mouseX <= 160 && mouseY >= clearButtonY && mouseY <= 100);
}

void reset() {
  for(int i = 0; i < 256; i++){
    background(i);
  }
}
