class Particle { 
  
    boolean left = false;
    float maxSpeed;
    int counter = 0;
    int interval;
    float sway;
    float xMovement;
    float xPos, yPos, diameter, xVel, yVel, gravity;
    boolean fall;
    
    Particle(float xp, float yp, float dia, float xv, float yv){ 
      xPos = xp;
      yPos = yp;
      diameter = dia;
      xVel = xv;
      yVel = yv;
      maxSpeed = 1;
      interval = round(random(10, 80));
      gravity = random(0.1f, 0.6f);
      sway = 0;
    }

    void display(){
      fill(255);
      ellipse(xPos, yPos, diameter, diameter);
    }

    void move(){
      if(clicked && yPos < bottomRow) {
        yPos += gravity;
        if(xVel <= 0.05 && yVel <= 0.05) {
          fall = true;
        }
        xPos += xVel * speedChange;
        yPos += yVel * speedChange;
       // xPos *= speedChange;
       // yPos *= speedChange;
        
        if(fall){
          counter++;
          gravity += 0.002f;
          //gravity *= speedChange;
          if(counter > interval) {
            left =! left;
            interval = round(random(10, 80));
            counter = 0;
          }
          if(left && xVel > -maxSpeed){
            xVel-= sway;
          }
          else if (!left && xVel < maxSpeed){
            xVel+= sway;
          }
          sway += 0.0001f;
        }
        
      }
    }
  }