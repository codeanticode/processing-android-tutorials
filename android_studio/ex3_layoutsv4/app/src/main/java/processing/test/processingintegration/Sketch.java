package processing.test.processingintegration;

import processing.core.PApplet;

public class Sketch extends PApplet {
  public void settings() {
    layout(R.layout.content_main, P3D);
  }

  public void setup() {
    textFont(createFont("Serif", 80));
    textAlign(CENTER, CENTER);
    strokeWeight(5);
  }

  public void draw() {
    background(180);
    fill(0);
    line(0, 0, mouseX, mouseY);
    line(width, 0, mouseX, mouseY);
    line(0, height, mouseX, mouseY);
    line(width, height, mouseX, mouseY);
    fill(255, 0, 0);
    text(width + "x" + height, width/2, height/2);

    lights();
    translate(mouseX, mouseY);
    rotateX(frameCount * 0.01f);
    rotateY(frameCount * 0.01f);
    box(100);

  }
}
