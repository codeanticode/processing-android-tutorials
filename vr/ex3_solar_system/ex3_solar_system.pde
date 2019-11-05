import processing.vr.*;

VRCamera cam;

PShape stars;
PShape sol;
PShape planet1;
PShape planet2;

float orbitalAngle1;
float orbitalAngle2;
float rotationAngle1;
float rotationAngle2;

int followPlanet;
PMatrix3D mat = new PMatrix3D();
float cx, cy, cz;

void setup() {
  fullScreen(VR);
  cameraUp();
  
  cam = new VRCamera(this);
  cam.setNear(10);
  cam.setFar(1500);

  noStroke();
  sphereDetail(40);

  stars = createShape(SPHERE, 1000);
  stars.setTexture(loadImage("startfield.jpg"));

  sol = createShape(SPHERE, 100);
  sol.setTexture(loadImage("sol.jpg"));

  planet1 = createShape(SPHERE, 20);
  planet1.setTexture(loadImage("mercury.jpg"));

  planet2 = createShape(SPHERE, 50);
  planet2.setTexture(loadImage("earthlike.jpg"));
}

void calculate() {
  orbitalAngle1 += 0.002;
  orbitalAngle2 += 0.001;
  rotationAngle1 += 0.02;
  rotationAngle2 += 0.02;

  if (0 < followPlanet) {
    float d;
    float r;
    float oa;
    float ra;
    if (followPlanet == 1) {
      d = 300;
      r = 20;
      oa = orbitalAngle1;
      ra = rotationAngle1;
    } else {
      d = 600;
      r = 50;
      oa = orbitalAngle2;
      ra = rotationAngle2;
    }

    mat.reset();
    mat.rotateY(oa);
    mat.translate(d, 0, 0);
    mat.rotateY(ra);
    mat.translate(-2 * r, 0, 0);

    cx = mat.multX(0, 0, 0);
    cy = mat.multY(0, 0, 0);
    cz = mat.multZ(0, 0, 0);
  }
}

void draw() {
  background(0);
  shape(stars);

  if (0 < followPlanet) cam.setPosition(cx, cy, cz);

  shape(sol);
  if (intersectsSphere(100, 0, 0) && mousePressed) followPlanet = 0;

  pointLight(255, 255, 255, 0, 0, 0);

  pushMatrix();
  rotateY(orbitalAngle1);
  translate(300, 0, 0);
  rotateY(rotationAngle1);
  if (followPlanet != 1 && intersectsSphere(2 * 20, 0, 0)) {
    planet1.setTint(color(255, 0, 0));
    if (mousePressed) followPlanet = 1;
  } else {
    planet1.setTint(color(255));
  }
  shape(planet1);
  popMatrix();

  pushMatrix();
  rotateY(orbitalAngle2);
  translate(600, 0, 0);
  rotateY(rotationAngle2);
  if (followPlanet != 2 && intersectsSphere(2 * 50, 0, 0)) {
    planet2.setTint(color(255, 0, 0));
    if (mousePressed) followPlanet = 2;
  } else {
    planet2.setTint(color(255));
  }
  shape(planet2);
  popMatrix();
}
