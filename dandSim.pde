import java.util.ArrayList;

boolean clicked; 
float speedChange;
float dx, dy;
float theta;
int numParticles = 200;
int radius = 40;
int particleDia = 5;
int bottomRow;
boolean initReverse, initForward;
int state = 0;

int x2, y2;

final int INIT = 0;
final int REPEL = 1;
final int ATTRACT = 2;
final int RESET = 3;

ArrayList<Particle> parts = new ArrayList<Particle>();

public void setup() {
  frameRate(60);
  size(640, 360);
  bottomRow = height;

  for (int i = 0; i < numParticles; i++) { //make 200 particles within a circle
    dx = random(-radius, radius);
    dy = sqrt(radius*radius-dx*dx) * random(-1.0, 1.0);
    parts.add(new Particle(width/2+dx, height/2+dy, particleDia, 0, 0));
  }
}

public void draw() {
  background(0, 0, 0); 
  stroke(245);
  strokeWeight(3);
  line(width/2, height/2, width/2, bottomRow); //stem
  noStroke(); 
  ellipse(width/2, height/2, 25, 10); //bud


  if (initReverse) {
    state = 2;
  } else if (initForward) {
    state = 1;
  }

  switch (state) {
  case INIT:
    textSize(20);
    text("click for wind", width/2 - 70, height-300);
    noStroke();
    break;
    
  case REPEL:
    for (int i = 0; i < parts.size(); i++) {
      parts.get(i).move();
    }
    break;
    
  case ATTRACT:
  for (int i = 0; i < parts.size(); i++) {
      parts.get(i).move();
    }
    break;
    
  case RESET:
    for (int i = 0; i < parts.size(); i++) {
      parts.get(i).reset();
    }
    break;
  }

  for (int i = 0; i < parts.size(); i++) {
    parts.get(i).display();
  }
  
  if (x2 != 0) {
    stroke(255);
    noFill();
  //bezier(mouseX, mouseY, 410, 20, 440, 300, 640/2, 360/2);
   x2 = (int)lerp(640/2, mouseX, 1.0);
   y2 = (int)lerp(360/2, mouseY, 1.0);
  line(640/2, 360/2, x2, y2);
 
  }
}


public void mousePressed() {
  for (int i = 0; i < parts.size(); i++) {
    initForward = parts.get(i).init(false);
  }
  x2 = mouseX;
  y2 = mouseY;
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      speedChange *= 1.1;
    } else if (keyCode == DOWN) {
      speedChange *= 0.9;
    }
  }

  if (key == 32) { //space
    for (int i=0; i<parts.size(); i++) {
        initReverse = parts.get(i).init(true);
      }
  }
}