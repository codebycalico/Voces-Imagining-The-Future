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
