// Class to control "Submissions",
// the submitted, hand drawn images.

// Variables for loading the permanent images
// Looks in designated folder to find the number of files

// IF NOT FINDING PERMAMENT SUBMISSIONS !
// Check path first
String path = "/C:/Users/crandall/Documents/GitHub/Voces-Imagining-The-Future/touchscreenDraw/submissions/permanentSubmissions/";
String[] filenames = listFileNames(path);
int IMG_NUM = filenames.length;
PImage[] submissions = new PImage[IMG_NUM];
Submission[] permSubs = new Submission[IMG_NUM];

class Submission {
  float r;   // radius
  float x, y; // location
  float xspeed, yspeed; // speed
  PImage img; // image used

    // Constructor
  Submission(float tempR, PImage image) {
    r = tempR;
    x = random(width);
    y = random(height);
    xspeed = random( - 5, 5);
    yspeed = random( - 5, 5);
    img = image;
  }

  void move() {
    x += xspeed; // Increment x
    y += yspeed; // Increment y

    // Check horizontal edges
    if (x > width || x < 0) {
      xspeed *= -1;
    }
    //Check vertical edges
    if (y > height || y < 0) {
      yspeed *= -1;
    }
  }

  // Draw the ball
  void display() {
    imageMode(CENTER);
    image(img, x, y, r, r);
  }
}

void setupSubmissions() {
  // Load the array of images
  for(int i = 0; i < submissions.length; i++) {
    submissions[i] = maskWhite(loadImage(path + filenames[i]));
  }
  
  // Load the array of Submission objects
  for(int i = 0; i < permSubs.length; i++) {
    permSubs[i] = new Submission(random(200, 400), submissions[i]);
  }
}

void updateSubmissions() {
  for(int i = 0; i < permSubs.length; i++) {
   permSubs[i].move();
   permSubs[i].display();
  }
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
