package processing.test.processingintegration;

import processing.core.PShape;
import processing.core.PImage;
import processing.core.PApplet;

public class Sketch extends PApplet {
  float angle = 0;
  PShape cube;

  public void settings() {
    fullScreen(P3D);
  }

  public void setup() {
    fullScreen(P3D);
    PImage tex = loadImage("mosaic.jpg");
    cube = createShape(BOX, 400);
    cube.setTexture(tex);
  }

  public void draw() {
    background(0x81B771);
    lights();
    translate(width/2, height/2);
    rotateY(angle);
    rotateX(angle*2);
    shape(cube);
    angle += 0.01;
  }
}
