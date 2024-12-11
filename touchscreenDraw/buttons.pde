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
    
  void render(boolean strke) {
    fill(ColourButton);
    if(strke) {
      stroke(ColourText);
    } else {
      stroke(OMSI_COLORS[8]);
    }
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
  onyx = new Button(30, (BORDER_Y + 30), 150, 100, "", ONYX_COLOR, FLINT_COLOR, 40);
  carn = new Button(30, (BORDER_Y + 150), 150, 100, "", OMSI_COLORS[7], FLINT_COLOR, 40);
  jasp = new Button(30, (BORDER_Y + 270), 150, 100, "", OMSI_COLORS[5], FLINT_COLOR, 40);
  moss = new Button(30, (BORDER_Y + 390), 150, 100, "", OMSI_COLORS[0], FLINT_COLOR, 40);
  chrys = new Button(30, (BORDER_Y + 510), 150, 100, "", OMSI_COLORS[9], FLINT_COLOR, 40);
  if(eng) {
    english = new Button( (width - 340), (height - 200), 300, 75, "ENGLISH", OMSI_COLORS[5], ONYX_COLOR, 30);
    spanish = new Button( (width - 340), (height - 125), 300, 75, "ESPAÑOL", FLINT_COLOR, ONYX_COLOR, 30);
    clearButton = new Button( (width - 375), 150, 350, 200, "CLEAR\nSCREEN", FLINT_COLOR, OMSI_COLORS[9], 40);
    submitButton = new Button( (width - 375), 400, 350, 200, "SUBMIT", OMSI_COLORS[4], OMSI_COLORS[3], 40);
    colorSelect = new Button(0, (BORDER_Y + 630), (BORDER_X - 5), 250, "SELECT\nA\nCOLOR", OMSI_COLORS[8], ONYX_COLOR, 30);
  } else {
    english = new Button( (width - 340), (height - 200), 300, 75, "ENGLISH", FLINT_COLOR, ONYX_COLOR, 30);
    spanish = new Button( (width - 340), (height - 125), 300, 75, "ESPANOL", OMSI_COLORS[5], ONYX_COLOR, 30);
    clearButton = new Button((width - 375), 150, 350, 200, "BORRAR LA\nPANTALLA", FLINT_COLOR, OMSI_COLORS[9], 40);
    submitButton = new Button( (width - 375), 400, 350, 200, "ENVIAR", OMSI_COLORS[4], OMSI_COLORS[3], 40);
    colorSelect = new Button(0, (BORDER_Y + 630), (BORDER_X - 5), 250, "SELECCIONA\nUN\nCOLOR", OMSI_COLORS[8], ONYX_COLOR, 20);
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
  colorSelect.update();
}

// Render the buttons based on the language chosen
void renderButtons() {
  submitButton.render(true);
  clearButton.render(true);
  if(colorPicker == 9) {
    chrys.render(true);
    carn.render(false);
    jasp.render(false);
    moss.render(false);
    onyx.render(false);
  } else if(colorPicker == 7) {
    chrys.render(false);
    carn.render(true);
    jasp.render(false);
    moss.render(false);
    onyx.render(false);
  } else if(colorPicker == 5) {
    chrys.render(false);
    carn.render(false);
    jasp.render(true);
    moss.render(false);
    onyx.render(false);
  } else if(colorPicker == 0) {
    chrys.render(false);
    carn.render(false);
    jasp.render(false);
    moss.render(true);
    onyx.render(false);
  } else if(colorPicker == 10) {
    chrys.render(false);
    carn.render(false);
    jasp.render(false);
    moss.render(false);
    onyx.render(true);
  } else {
    chrys.render(false);
    carn.render(false);
    jasp.render(false);
    moss.render(false);
    onyx.render(false);
  }
  english.render(true);
  spanish.render(true);
  colorSelect.render(false);
  if(eng) {
    english.ColourButton = OMSI_COLORS[5];
    spanish.ColourButton = FLINT_COLOR;
    clearButton.Text = "CLEAR\nSCREEN";
    submitButton.Text = "SUBMIT";
    colorSelect.Text = "SELECT\nA\nCOLOR";
  } else if(!eng) {
    english.ColourButton = FLINT_COLOR;
    spanish.ColourButton = OMSI_COLORS[5];
    clearButton.Text = "BORRAR LA\nPANTALLA";
    submitButton.Text = "ENVIAR";
    colorSelect.Text = "SELECCIONA\nUN\nCOLOR";
  }
}

// White out the buttons "removing" them
void removeButtons() {
  fill(255);
  stroke(255);
  strokeWeight(5);
  resetHeader();
  line(BORDER_X, BORDER_Y, (BORDER_X + BORDER_WIDTH), BORDER_Y);
  line(BORDER_X, BORDER_Y, BORDER_X, (BORDER_Y + BORDER_HEIGHT));
  line(BORDER_X, (BORDER_Y + BORDER_HEIGHT), (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  line((BORDER_X + BORDER_WIDTH), BORDER_Y, (BORDER_X + BORDER_WIDTH), (BORDER_Y + BORDER_HEIGHT));
  rect(0, (BORDER_Y - 5), (BORDER_X - 5), height);
  rect(clearButton.Pos.x, clearButton.Pos.y, clearButton.Width + 10, clearButton.Height + 5);
  rect(submitButton.Pos.x, submitButton.Pos.y, submitButton.Width + 10, submitButton.Height + 5);
  rect(english.Pos.x, english.Pos.y, english.Width, english.Height);
  rect(spanish.Pos.x, spanish.Pos.y, spanish.Width, spanish.Height);
  rect(0, 0, width, BORDER_Y);
  rect(0, 0, BORDER_X, height);
  rect(0, (BORDER_Y + BORDER_HEIGHT), width, height);
  rect( (BORDER_X + BORDER_WIDTH), BORDER_Y, width, height);
}
