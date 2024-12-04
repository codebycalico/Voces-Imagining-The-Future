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
