//Solar System using Processing - Nikhila Isukapally

//Coordinates of the sun
float sunX, sunY;

//Coordinates of the planets
float[] planetX = new float[8];
float[] planetY = new float[8];

//Planet size
float size[] = {8.8, 13.75, 15.4, 13.75, 24.2, 20.9, 17.6, 17.6};

//Colors
color colors[]= {#95605B, #E5E2D6, #586367, #797053, #BFB7A1, #242E2F, #654935, #4A4940};

//Planet information
String[] planetNames = {"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"};
float[] gravity = {0.38, 0.9, 1, 0.38, 2.34, 0.93, 0.92, 1.12};
float[] orbitTime = {88, 224.7, 365.2, 687, 4333, 10759, 30685, 60190};
float[] orbitCircumference = {87.97, 108.2, 149.6, 227.9, 778.5, 1429, 2871, 4495};
float[] distanceFromEarth = {0.39, 0.72, 1, 1.52, 5.2, 9.58, 19.18, 30.07};
float angle[] = {0, PI/6, PI/2, 3*PI/12, PI, 5*PI/4, 3*PI/2, 7*PI/4};
float[] orbit = {80, 120, 160, 200, 240, 280, 320, 360};

// variables that track pause state and last planet touched
boolean paused = false;
boolean keyPause = false;
int startPause = 0;
int endPause = 0;
int ang = 0;

//New font
PFont poppins;

void setup() {
  size(1200, 1000);
  sunX = width/2;
  sunY = height/2;
  poppins = createFont("Poppins", 24);


  stroke(250);
  strokeWeight(2);
}

void draw() {
  background(#1A1A1A);

  //Hover functionality
  for (int i = 0; i < 8; i++) {
    float d = dist(mouseX, mouseY, planetX[i], planetY[i]);
    if (d < 20) {
      // check if mouse is over a planet
      for (int j = 0; j < 8; j++) {
        push();
        if (j == i) {// check if orbit belongs to the hovered planet
          strokeWeight(4); // increase stroke weight
          fill(colors[j]);
          rect(0, 0, width, height);
          noFill();
          fill(#ffffff);
          rect(740, 60, 400, 108, 10);
          textFont(poppins);
          textSize(24);
          noFill();
          fill(#1e1e1e);
          text(planetNames[i], 756, 90);
          textFont(poppins);
          textSize(16);
          text("Gravity: " + gravity[i], 756, 114);
          text("Orbit Time: " + orbitTime[i] + " Earth Days", 756, 136);
          text("Orbit Circumference: " + orbitCircumference[i] + " Million KM", 756, 160);
        } else {
          strokeWeight(1);
        }
        noFill();
        ellipse(width/2, height/2, orbit[j] * 2, orbit[j] * 2);
        pop();
      }
    }
  }

  // Rotation speed declaration
  float speed[]= new float [8];
  for (int s= 0; s<8; s++) {
    speed[s]= orbitCircumference[s]/orbitTime[s];
  }


  textFont(poppins);
  textSize(60);
  text("Solar System", 40, 100);

  //Drawing the sun
  stroke(#ffffff);
  ellipse(sunX, sunY, 50, 50);

  //Drawing the orbits
  for (int n = 0; n<8; n++) {
    noFill();
    strokeWeight(1);
    ellipse(width/2, height/2, orbit[n] * 2, orbit[n] * 2);
  }

  //Drawing the planets
  for (int j = 0; j<8; j++)
  {
    stroke(#ffffff);
    planetX[j] = sunX + cos(angle[j]) * (orbit[j]);
    planetY[j] = sunY + sin(angle[j]) * (orbit[j]);
    fill(#ffffff);
    ellipse(planetX[j], planetY[j], 20, 20);
    angle[j] += 0.01*speed[j];
  }
}
