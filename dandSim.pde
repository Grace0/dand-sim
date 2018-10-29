import java.util.ArrayList;

boolean clicked = false; //true forever after clicking first time
float speedChange = 1.0;
float dx = 0.0; 
float dy = 0.0;
float theta = 0.0;
int numParticles = 200;
int radius = 40;
int particleDia = 5;
int bottomRow = 0;

ArrayList<Particle> parts = new ArrayList<Particle>();

public void setup() {
  frameRate(60);
  size(640, 360);
  bottomRow = height;

  for (int i = 0; i < numParticles; i++) { //make 200 particles within a circle

    //dx = random(-1.0, 1.0); //circle part of a cos wave between -pi, pi
    //dy = cos(dx) * random(-1.0, 1.0);
    //parts.add(new Particle(width/2+dx*40, height/2+dy*40, 5, 0, 0)); //xPos, yPos, diameter, xVel, yVel

    dx = random(-radius, radius);
    dy = sqrt(radius*radius-dx*dx) * random(-1.0, 1.0);
    parts.add(new Particle(width/2+dx, height/2+dy, particleDia, 0, 0));
  }
}

public void draw() {

  background(195, 90, 49);
  stroke(245);
  strokeWeight(3);
  line(width/2, height/2, width/2, bottomRow); //stem
  noStroke(); 
  ellipse(width/2, height/2, 25, 10); //bud
  if (!parts.get(0).isInit) {
    textSize(20);
    text("click for wind", width/2 - 70, height-300);
    noStroke();
  }

  for (int i=0; i<parts.size(); i++) {
    parts.get(i).move();
    parts.get(i).display();
  }
}


public void mousePressed() {
  for (int i=0; i<parts.size(); i++) {
    parts.get(i).init(false);
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      speedChange *= 1.1;
    } else if (keyCode == DOWN) {
      speedChange *= 0.9;
    }
  }

  if (key == TAB) {
    for (int i=0; i<parts.size(); i++) {
      parts.get(i).init(true);
    }
  }
}