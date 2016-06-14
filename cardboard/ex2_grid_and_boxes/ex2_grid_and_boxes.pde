import processing.cardboard.*;

PShape grid;
PShape cubes;

void setup() {
  fullScreen(PCardboard.STEREO);
  
  grid = createShape();
  grid.beginShape(LINES);
  grid.stroke(255);
  for (int x = -10000; x < +10000; x += 250) {
    grid.vertex(x, -1000, +10000);
    grid.vertex(x, -1000, -10000);
  }
  for (int z = -10000; z < +10000; z += 250) {
    grid.vertex(+10000, -1000, z);
    grid.vertex(-10000, -1000, z);      
  }  
  grid.endShape();  
  
  cubes = createShape(GROUP);
  for (int i = 0; i < 100; i++) {
    float x = random(-1000, +1000); 
    float y = random(-1000, +1000);
    float z = random(-1000, +1000);
    
    float r = random(50, 150);
    PShape cube = createShape(BOX, r, r, r);
    cube.setStroke(false);
    cube.setFill(color(180));
    cube.translate(x, y, z);
    cubes.addChild(cube);
  }
}

void draw() {
  background(0);
  ambientLight(150, 150, 150);
  pointLight(255, 255, 255, 0, 0, 0);
  translate(width/2 - 1000, height/2, 500);
  shape(cubes);
  shape(grid);
}