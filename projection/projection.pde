// File for projecting the drawn images
// Created by Calico 
// For Voces: Imagining The Future

// Recieving images code from example:
// https://github.com/torb-no/processing-experiments/tree/master/CamNetServer

// NEEDS TO BE DONE BY A HUMAN AT THE END OF EACH DAY:
// Review the files in the submissions folder and choose appropriate ones
// Add appropriate ones to the permanentSubmissions folder, and rename the files,
// numbering them to match the format.

import java.util.Date;
import processing.net.*;
final int TIMEOUT_MILLI = 3000; // wait for image to arrive after a length receiption

// Variables for incoming images
Server server;
JPGEncoder jpg;
PImage img;

int startTimer, stopTimer;

float x, y, rot; // Variables for image locations and rotations

void setup() { 
  size(1080, 800);
  background(255);
 
  jpg = new JPGEncoder();
  server = new Server(this, 5203);
  img = createImage(0, 0, RGB);
  println("Starting server...");

  setupSubmissions();
}

void draw(){
  background(255);
  updateSubmissions();
  
  checkForIncomingImage();
  image(maskWhite(img), width/2, height/2);
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

// "Delete" the white background from the drawing screenshot
PImage maskWhite(PImage keyLayer) {
  // Copy the image
  PImage mask = keyLayer.copy();
  // Anything darker than purely white will show (1.0 = purely white)
  mask.filter(THRESHOLD, 1.0);
  // Invert
  mask.filter(INVERT);
  // Build a result
  PImage result = keyLayer.copy();
  // Apply the mask image as a mask, making the background transparent
  result.mask(mask);
  return result;
}
