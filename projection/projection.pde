// File for projecting the drawn images
// Created by Calico 
// For Voces: Imagining The Future
// Recieving images code from example https://github.com/torb-no/processing-experiments/tree/master/CamNetServer

import processing.net.*;

final int TIMEOUT_MILLI = 3000; // wait for image to arrive after a length receiption

Server server;
JPGEncoder jpg;
PImage img;
int permanentImagesNumber = 5;

PImage[] submissions = new PImage[permanentImagesNumber];

Submission sub0, sub1, sub2, sub3, sub4;

int startTimer, stopTimer;

float x, y, rot; // Variables for image locations and rotations

void setup() { 
 size(1080, 1080);
 background(255);
 
 jpg = new JPGEncoder();
 server = new Server(this, 5203);
 img = createImage(0, 0, RGB);
 println("Starting server...");
 
 // Load images
 for(int i = 0; i < submissions.length; i++) {
   submissions[i] = maskWhite(loadImage("/C:/Users/crandall/Documents/GitHub/Voces-Imagining-The-Future/touchscreenDraw/submissions/permanentSubmissions/permanent" + i + ".jpg"));
 }
 
 sub0 = new Submission(random(300, 500), submissions[0]);
 sub1 = new Submission(random(300, 500), submissions[1]);
 sub2 = new Submission(random(300, 500), submissions[2]);
 sub3 = new Submission(random(300, 500), submissions[3]);
 sub4 = new Submission(random(300, 500), submissions[4]);
}

void draw(){
  background(255);
 
  sub0.move();
  sub1.move();
  sub2.move();
  sub3.move();
  sub4.move();
  sub0.display();
  sub1.display();
  sub2.display();
  sub3.display();
  sub4.display();
  
  checkForIncomingImage();
  image(maskWhite(img), width/2, height/2);
  //if(stopTimer - startTimer < 3000) { 
  //  tint(255, 255);
  //  image(img, width/2, height/2);
  //  stopTimer = millis();
  //}  else {
  //  tint(0, 0);
  //  image(img, width/2, height/2);
  //}
  
  //translate(x, y);
  //rotate(rot);
  
  //imageMode(CENTER);
  //image(images[0], 0, 0);
  
  //x += 1.0;
  //rot += 0.02;
  //if( x > width + images[0].width) {
  //  x = -images[0].width;
  //}
}

void checkForIncomingImage() {
  Client nextClient = server.available();

  if (nextClient != null && nextClient.available() >= 2) {
    println("More than two bytes available. Trying to get length.");

    // Taken from: https://processing.org/discourse/beta/num_1192330628.html
    int imageByteLength = nextClient.read()*256 + nextClient.read();

    println("Length is " + imageByteLength + ". Waiting for whole image.");
    int startMilli = millis();
    while (true) {
      // Wait for the image...

      // Abort if timeout has run out
      if ((millis() - startMilli) > TIMEOUT_MILLI) {
        println("Timeout.");
        nextClient.clear();
        break;
      }

      // Load it if finished
      if (nextClient.available() >= imageByteLength) {
        println("Enough in buffer, reading in...");
        byte[] jpgBytes = new byte[imageByteLength];
        nextClient.readBytes(jpgBytes);
        nextClient.clear();
        startTimer = millis();
        try {
          img = jpg.decode(jpgBytes);
        } 
        catch (IOException e) {
          println("IOException in reading jpgbytes");
        } 
        catch (NullPointerException e) {
          println("NullPointerException in reading jpgbytes");
        } 
        catch (ArrayIndexOutOfBoundsException e) {
          println("ArrayIndexOutOfBoundsException in reading jpgbytes");
        }
      }
    }
  }
}

PImage maskWhite(PImage keyLayer) {
  PImage mask = keyLayer.copy(); //copy the image
  mask.filter(BLUR, 2); //just throw a blur on to make it look nicer
  mask.filter(THRESHOLD, 0.8); //anything darker than 80% white turns black, everything lighter turns white.
  mask.filter(INVERT); //flip white/black
  PImage result = keyLayer.copy(); //build a result
  result.mask(mask); //apply the mask image as a mask, making the background transparent
  return result;
}
