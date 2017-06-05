import processing.vr.*;

PShader toon;
boolean shaderEnabled = true;  

void setup() {
  fullScreen(STEREO);  
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
}

void draw() {
  if (shaderEnabled == true) shader(toon);
  translate(width/2, height/2);
  background(80); 
  directionalLight(204, 204, 204, 1, 1, -1);
  sphere(150);
}  

void mousePressed() {
  if (shaderEnabled) {
    shaderEnabled = false;
    resetShader();
  } else {
    shaderEnabled = true;
  }
}