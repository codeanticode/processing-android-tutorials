void setup() {
  fullScreen();
  frameRate(1);
  textFont(createFont("SansSerif", 30 * displayDensity));
  fill(255);
}

void draw() {
  background(0);
  translate(0, +wearInsets().bottom/2);
  if (!wearAmbient()) {
    String str = hour() + ":" + minute() + ":" + second();
    float w = textWidth(str);
    text(str, (width - w)/2, height/2 + 24);     
  }
}