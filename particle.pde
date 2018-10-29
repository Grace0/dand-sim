class Particle { 

  boolean left = false;
  float maxSpeed;
  int counter = 0;
  int interval;
  float sway;
  float xMovement;
  float xPos, yPos, diameter, xVel, yVel, gravity;
  boolean fall;
  boolean isInit;
  float reverse;

  Particle(float xp, float yp, float dia, float xv, float yv) { 
    xPos = xp;
    yPos = yp;
    diameter = dia;
    xVel = xv;
    yVel = yv;
    maxSpeed = 1;
    interval = round(random(10, 80));
    gravity = random(0.1f, 0.6f);
    sway = 0;
    isInit = false;
  }

  void display() {
    fill(255);
    ellipse(xPos, yPos, diameter, diameter);
  }

  void move() {

    if (abs(xVel) > 0 || abs(yVel) > 0) { 
      yVel *= 0.98f;
      xVel *= 0.98f;
    }

    if (isInit && yPos < bottomRow) {
      yPos += gravity;
      if (abs(xVel) <= 0.05 && abs(yVel) <= 0.05) {
        fall = true;
      }
      xPos += xVel;
      yPos += yVel;

      if (fall) {
        counter++;
        gravity += 0.002f * speedChange;
        if (counter > interval) {
          left =! left;
          interval = round(random(10, 80)); //reset it
          counter = 0;
        }
        if (left && xVel > -maxSpeed) {
          xVel-= sway;
        } else if (!left && xVel < maxSpeed) {
          xVel+= sway;
        }
        sway += 0.0001f;
      }
    }
  }

  void init(boolean attract) { 
    isInit = true;
    theta = atan2((mouseY-yPos), (mouseX-xPos)); 
    if (attract) reverse = 1.0;
    else reverse = -1.0;
    yVel = reverse * sin(theta)*2.5f; //set velocity to opposite of mouse position (times 2.5)
    xVel = reverse * cos(theta)*2.5f;
  }

  void reset() {
  }

}