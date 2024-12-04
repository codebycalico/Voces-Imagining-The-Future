// File for projecting the drawn images
// Created by Calico 
// For Voces: Imagining The Future

String[] imageNames = { "permanent1.png", "permanent2.png" };
PImage[] images = new PImage[imageNames.length];

float x, y, rot; // Variables for image locations and rotations

void setup() { 
 size(1080, 1080);
 background(255);
 
 // Load images
 for(int i = 0; i < imageNames.length; i++) {
   String imageName = imageNames[i];
   images[i] = loadImage("/C:/Users/crandall/Documents/GitHub/Voces-Imagining-The-Future/touchscreenDraw/submissions/permanentSubmissions/" + imageName);
 }
}

void draw(){
  translate(x, y);
  rotate(rot);
  
  imageMode(CENTER);
  image(images[0], 0, 0);
  
  x += 1.0;
  rot += 0.02;
  if( x > width + images[0].width) {
    x = -images[0].width;
  }
}
