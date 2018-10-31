class Particle { 

  ArrayList<FloatList> traj;

  boolean left;
  boolean fall;
  boolean isInit;

  float sway;
  float xPos, yPos, diameter, xVel, yVel, gravity;
  float maxSpeed;

  int swayCount;
  int swayInterval;
  int resetInc;

  Particle(float xp, float yp, float dia, float xv, float yv) { 
    xPos = xp;
    yPos = yp;
    diameter = dia;
    xVel = xv;
    yVel = yv;
    maxSpeed = 1.0;
    swayInterval = round(random(10, 80));
    gravity = random(0.1f, 0.6f);
    isInit = false;

    traj = new ArrayList<FloatList>();
  }

  void display() {
    fill(255);
    ellipse(xPos, yPos, diameter, diameter);
  }

  void move() {

    if (isInit) {
      FloatList point = new FloatList();
      point.append(xPos);
      point.append(yPos);
      traj.add(point);
      resetInc = traj.size()-1;
    }

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
        swayCount++;
        gravity += 0.002f * speedChange;
        if (swayCount > swayInterval) {
          left =! left;
          swayInterval = round(random(10, 80)); //reset it
          swayCount = 0;
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

    if (attract) {
      yVel = 1.0 * sin(theta)*2.5f;
      xVel = 1.0 * cos(theta)*2.5f;
    } else {
      yVel = -1.0 * sin(theta)*2.5f;
      xVel = -1.0 * cos(theta)*2.5f;
    }
  }

  void reset() {
    if (resetInc >= 0) {
      xPos = traj.get(resetInc).get(0);
      yPos = traj.get(resetInc).get(1);
    }
    resetInc--;
  }
}