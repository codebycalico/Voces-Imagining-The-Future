// Class to create rectangular buttons

PFont buttonFont;

class Button {
  PVector Pos = new PVector(0,0);
  float Width = 0;
  float Height = 0;
  color ColourButton;
  color ColourText;
  String Text;
  Boolean Pressed = false;
  
  // Button constructor
  Button(int x, int y, int w, int h, String t, color colButton, color colText) {
    Pos.x = x;
    Pos.y = y;
    Width = w;
    Height = h;
    ColourButton = colButton;
    ColourText = colText;
    Text = t;
  }
  
  // Must be placed in draw() to work 
  void update() {
    if(mousePressed == true && mouseX >= Pos.x && mouseX <= Pos.x + Width && mouseY >= Pos.y && mouseY <= Pos.y + Height) {
      Pressed = true;
    } else {
      Pressed = false;
    }
  }
    
  void render() {
      fill(ColourButton);
      stroke(ColourText);
      strokeWeight(4);
      rect(Pos.x, Pos.y, Width, Height);
      
      buttonFont = createFont("/data/PlusJakartaSans-Regular.ttf", 48);
      fill(ColourText);
      textFont(buttonFont);
      textAlign(CENTER, CENTER);
      text(Text, Pos.x + (Width/2), Pos.y + (Height/2));
  }
  boolean isPressed() {
    return Pressed;
  }
}

void setupButtons() {
  clearButton = new Button(0, 0, 350, 100, "RESET", OMSIcolors[8], OMSIcolors[9]);
  submitButton = new Button( (width - 350), 0, 350, 100, "SUBMIT", OMSIcolors[4], OMSIcolors[3]);
  chrys = new Button(0, 2*(height/6) - 150, 200, 100, "", OMSIcolors[8], OMSIcolors[8]);
  carn = new Button(0, 3*(height/6) - 150, 200, 100, "", OMSIcolors[7], OMSIcolors[7]);
  jasp = new Button(0, 4*(height/6) - 150, 200, 100, "", OMSIcolors[5], OMSIcolors[5]);
  moss = new Button(0, 5*(height/6) - 150, 200, 100, "", OMSIcolors[0], OMSIcolors[0]);
  onyx = new Button(0, (height - 150), 200, 100, "", OMSIcolors[10], OMSIcolors[10]);
}

void updateButtons() {
  clearButton.update();
  submitButton.update();
  chrys.update();
  carn.update();
  jasp.update();
  moss.update();
  onyx.update();
}

void renderButtons() {
  submitButton.render();
  clearButton.render();
  chrys.render();
  carn.render();
  jasp.render();
  moss.render();
  onyx.render();
}

// White out the buttons "removing" them
void removeButtons(int col) {
  fill(255);
  noStroke();
  rect(submitButton.Pos.x - 10, submitButton.Pos.y, submitButton.Width + 10, submitButton.Height + 5);
  rect(clearButton.Pos.x, clearButton.Pos.y, clearButton.Width + 10, clearButton.Height + 5);
  
  if(col == 1) { // Clearing the screen to submit image
    rect(chrys.Pos.x, chrys.Pos.y - 5, chrys.Width + 5, chrys.Height + 10);
    rect(carn.Pos.x, carn.Pos.y - 5, carn.Width + 5, carn.Height + 10);
    rect(jasp.Pos.x, jasp.Pos.y - 5, jasp.Width + 5, jasp.Height + 10);
    rect(moss.Pos.x, moss.Pos.y - 5, moss.Width + 5, moss.Height + 10);
    rect(onyx.Pos.x, onyx.Pos.y - 5, onyx.Width + 5, onyx.Height + 10);
  } else if(col == 0){ // Moss color is chosen
    rect(chrys.Pos.x, chrys.Pos.y - 5, chrys.Width + 5, chrys.Height + 10);
    rect(carn.Pos.x, carn.Pos.y - 5, carn.Width + 5, carn.Height + 10);
    rect(jasp.Pos.x, jasp.Pos.y - 5, jasp.Width + 5, jasp.Height + 10);
    rect(onyx.Pos.x, onyx.Pos.y - 5, onyx.Width + 5, onyx.Height + 10);
  } else if(col == 5) { // Jasper color is chosen
    rect(chrys.Pos.x, chrys.Pos.y - 5, chrys.Width + 5, chrys.Height + 10);
    rect(carn.Pos.x, carn.Pos.y - 5, carn.Width + 5, carn.Height + 10);
    rect(moss.Pos.x, moss.Pos.y - 5, moss.Width + 5, moss.Height + 10);
    rect(onyx.Pos.x, onyx.Pos.y - 5, onyx.Width + 5, onyx.Height + 10);
  } else if(col == 7) { // Carnelian color is chosen
    rect(chrys.Pos.x, chrys.Pos.y - 5, chrys.Width + 5, chrys.Height + 10);
    rect(jasp.Pos.x, jasp.Pos.y - 5, jasp.Width + 5, jasp.Height + 10);
    rect(moss.Pos.x, moss.Pos.y - 5, moss.Width + 5, moss.Height + 10);
    rect(onyx.Pos.x, onyx.Pos.y - 5, onyx.Width + 5, onyx.Height + 10);
  } else if(col == 8) { // Chrysocolla color is chosen
    rect(carn.Pos.x, carn.Pos.y - 5, carn.Width + 5, carn.Height + 10);
    rect(jasp.Pos.x, jasp.Pos.y - 5, jasp.Width + 5, jasp.Height + 10);
    rect(moss.Pos.x, moss.Pos.y - 5, moss.Width + 5, moss.Height + 10);
    rect(onyx.Pos.x, onyx.Pos.y - 5, onyx.Width + 5, onyx.Height + 10);
  } else if(col == 10) { // Onyx is chosen
    rect(chrys.Pos.x, chrys.Pos.y - 5, chrys.Width + 5, chrys.Height + 10);
    rect(carn.Pos.x, carn.Pos.y - 5, carn.Width + 5, carn.Height + 10);
    rect(jasp.Pos.x, jasp.Pos.y - 5, jasp.Width + 5, jasp.Height + 10);
    rect(moss.Pos.x, moss.Pos.y - 5, moss.Width + 5, moss.Height + 10);
  }
}
