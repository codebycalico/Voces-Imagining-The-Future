// Class to create rectangular buttons
class Button {
  PVector Pos = new PVector(0,0);
  float Width = 0;
  float Height = 0;
  color ColourButton;
  color ColourText;
  String Text;
  Boolean Pressed = false;
  Boolean Clicked = false;
  int FontSize;
  
  // Button constructor
  Button(int x, int y, int w, int h, String t, color colButton, color colText, int fontsz) {
    Pos.x = x;
    Pos.y = y;
    Width = w;
    Height = h;
    ColourButton = colButton;
    ColourText = colText;
    Text = t;
    FontSize = fontsz;
  }
  
  // Must be placed in draw() to work 
  void update() {
    if(mouseX >= Pos.x && mouseX <= Pos.x + Width && mouseY >= Pos.y && mouseY <= Pos.y + Height) {
      Pressed = true;
      Clicked = true;
      mouseX = width/2;
      mouseY = height/2;
    } else {
      Pressed = false;
      Clicked = false;
    }
  }
    
  void render() {
    fill(ColourButton);
    stroke(ColourText);
    rect(Pos.x, Pos.y, Width, Height);
    
    fill(ColourText);
    textFont(buttonFont, FontSize);
    text(Text, Pos.x + (Width/2), Pos.y + (Height/2));
  }
  
  boolean isPressed() {
    return Pressed;
  }
}

// Setup buttons based on the initial language
void setupButtons() {
  onyx = new Button(0, 2*(height/6) - 190, 200, 150, "", ONYX_COLOR, FLINT_COLOR, 40);
  carn = new Button(0, 3*(height/6) - 190, 200, 150, "", OMSI_COLORS[7], FLINT_COLOR, 40);
  jasp = new Button(0, 4*(height/6) - 190, 200, 150, "", OMSI_COLORS[5], FLINT_COLOR, 40);
  moss = new Button(0, 5*(height/6) - 190, 200, 150, "", OMSI_COLORS[0], FLINT_COLOR, 40);
  chrys = new Button(0, (height - 190), 200, 150, "", OMSI_COLORS[9], FLINT_COLOR, 40);
  if(eng) {
    english = new Button(width - 375, height - 275, 300, 75, "ENGLISH", OMSI_COLORS[5], ONYX_COLOR, 30);
    spanish = new Button(width - 374, height - 175, 300, 75, "ESPAÑOL", FLINT_COLOR, ONYX_COLOR, 30);
    clearButton = new Button((width - 375), 150, 350, 200, "CLEAR\nSCREEN", OMSI_COLORS[8], OMSI_COLORS[9], 40);
    submitButton = new Button( (width - 375), 400, 350, 200, "SUBMIT", OMSI_COLORS[4], OMSI_COLORS[3], 40);
  } else {
    english = new Button(width - 375, height - 275, 300, 75, "ENGLISH", FLINT_COLOR, ONYX_COLOR, 30);
    spanish = new Button(width - 374, height - 175, 300, 75, "ESPANOL", OMSI_COLORS[5], ONYX_COLOR, 30);
    clearButton = new Button((width - 375), 150, 350, 200, "BORRAR LA\nPANTALLA", OMSI_COLORS[8], OMSI_COLORS[9], 40);
    submitButton = new Button( (width - 375), 400, 350, 200, "ENVIAR", OMSI_COLORS[4], OMSI_COLORS[3], 40);
  }
}

// Update buttons to see if they are being pressed
void updateButtons() {
  clearButton.update();
  submitButton.update();
  chrys.update();
  carn.update();
  jasp.update();
  moss.update();
  onyx.update();
  english.update();
  spanish.update();
}

// Render the buttons based on the language chosen
void renderButtons() {
  submitButton.render();
  clearButton.render();
  chrys.render();
  carn.render();
  jasp.render();
  moss.render();
  onyx.render();
  english.render();
  spanish.render();
  if(eng) {
    english.ColourButton = OMSI_COLORS[5];
    spanish.ColourButton = FLINT_COLOR;
    clearButton.Text = "CLEAR\nSCREEN";
    submitButton.Text = "SUBMIT";
  } else if(!eng) {
    english.ColourButton = FLINT_COLOR;
    spanish.ColourButton = OMSI_COLORS[5];
    clearButton.Text = "BORRAR LA\nPANTALLA";
    submitButton.Text = "ENVIAR";
  }
}

// White out the buttons "removing" them
void removeButtons() {
  fill(255);
  stroke(255);
  strokeWeight(5);
  line(BORDER_X, BORDER_Y, (BORDER_X + BORDER_WIDTH), BORDER_Y);
  line(BORDER_X, BORDER_Y, BORDER_X, (BORDER_Y + BORDER_HEIGHT));
  line(BORDER_X, (BORDER_Y + BORDER_HEIGHT), (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  line((BORDER_X + BORDER_WIDTH), BORDER_Y, (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  rect(submitButton.Pos.x - 10, submitButton.Pos.y, submitButton.Width + 10, submitButton.Height + 5);
  rect(clearButton.Pos.x, clearButton.Pos.y, clearButton.Width + 10, clearButton.Height + 5);
  rect(english.Pos.x, english.Pos.y, english.Width, english.Height);
  rect(spanish.Pos.x, spanish.Pos.y, spanish.Width, spanish.Height);
  rect(chrys.Pos.x, chrys.Pos.y - 5, chrys.Width + 5, chrys.Height + 10);
  rect(carn.Pos.x, carn.Pos.y - 5, carn.Width + 5, carn.Height + 10);
  rect(jasp.Pos.x, jasp.Pos.y - 5, jasp.Width + 5, jasp.Height + 10);
  rect(moss.Pos.x, moss.Pos.y - 5, moss.Width + 5, moss.Height + 10);
  rect(onyx.Pos.x, onyx.Pos.y - 5, onyx.Width + 5, onyx.Height + 10);
}
