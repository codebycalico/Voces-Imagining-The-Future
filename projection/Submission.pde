// Class to control "Submissions",
// the submitted, hand drawn images.

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

void updateSubmissions() {
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
}
