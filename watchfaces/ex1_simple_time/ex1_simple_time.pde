void setup() {
  fullScreen();
  frameRate(1);
  textFont(createFont("Roboto", 48));
  fill(255);
}

void draw() {
  background(0);
  translate(0, +insetBottom/2);
  if (!ambientMode) {
    String str = hour() + ":" + minute() + ":" + second();
    float w = textWidth(str);
    text(str, (width - w)/2, height/2 + 24);     
  }
}