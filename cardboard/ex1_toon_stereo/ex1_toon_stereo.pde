import processing.cardboard.*;

PShader toon;
boolean shaderEnabled = true;  

void setup() {
  fullScreen(PCardboard.STEREO);  
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
}

void draw() {
  if (shaderEnabled == true) shader(toon);   
  background(80); 
  directionalLight(204, 204, 204, 0, 0, -1);
  translate(width/2, height/2);
  sphere(500);
}  

void mousePressed() {
  if (shaderEnabled) {
    shaderEnabled = false;
    resetShader();
  } 
  else {
    shaderEnabled = true;
  }
}