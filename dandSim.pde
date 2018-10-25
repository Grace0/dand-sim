import java.util.ArrayList;

boolean clicked = false; //true forever after clicking first time
float speedChange = 1.0;
float dx; 
float dy;
float theta;
int numParticles = 200;
int radius = 40;
int particleDia = 5;
int bottomRow;

ArrayList<Particle> parts = new ArrayList<Particle>();

public void setup() {
  frameRate(60);
  size(640, 360);
  bottomRow = height;

  for (int i = 0; i < numParticles; i++) { //make 200 particles within a circle

    //dx = random(-1.0, 1.0); //circlely part of a cos wave between -pi, pi
    //dy = cos(dx) * random(-1.0, 1.0);
    //parts.add(new Particle(width/2+dx*40, height/2+dy*40, 5, 0, 0)); //xPos, yPos, diameter, xVel, yVel

    dx = random(-radius, radius);
    dy = sqrt(radius*radius-dx*dx) * random(-1.0, 1.0);
    parts.add(new Particle(width/2+dx, height/2+dy, particleDia, 0, 0));
    
  }
}

public void draw() {
  
  background(195, 90, 49);
  fill(245);
  stroke(245);
  strokeWeight(3);
  line(width/2, height/2, width/2, bottomRow); //stem
  noStroke(); 
  ellipse(width/2, height/2, 25, 10); //bud
  fill(255);
  if (!clicked) {
    textSize(20);
    text("click for wind", width/2 - 70, height-300);
    noStroke();
  }

  for (int i=0; i<parts.size(); i++) {
    parts.get(i).move();
    parts.get(i).display();
  }
  for (int i=0; i<parts.size(); i++) { //slowing down
    if (abs(parts.get(i).xVel) > 0 || abs(parts.get(i).yVel) > 0) { 
      parts.get(i).yVel *= 0.98f;
      parts.get(i).xVel *= 0.98f;
    }
    if (!parts.get(i).fall && abs(parts.get(i).xVel) < 0.08) parts.get(i).xVel = 0; //if not falling yet and if speed way slow, stop
    if (!parts.get(i).fall && abs(parts.get(i).yVel) < 0.08) parts.get(i).yVel = 0;
  }
  text("sc"+speedChange, width/2 - 70, height-250);
}


public void mousePressed() {
  clicked = true;
  for (int i=0; i<parts.size(); i++) {
    theta = atan2((mouseY-parts.get(i).yPos), (mouseX-parts.get(i).xPos)); 
    parts.get(i).yVel = -sin(theta)*2.5f; //set velocity to opposite of mouse position (times 2.5)
    parts.get(i).xVel = -cos(theta)*2.5f;
  }
}

public void keyPressed() {
  if (key == CODED) {
    while (keyCode != UP && keyCode != DOWN) {
      textSize(20); //shows for split second
      text("press the arrows", width/2 - 70, height-200);
      noStroke();
    }
    if (keyCode == UP) {
      speedChange *= 1.1;
    } else if (keyCode == DOWN) {
      speedChange *= 0.9;
    }
  }
}