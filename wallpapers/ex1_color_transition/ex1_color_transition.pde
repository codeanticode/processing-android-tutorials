float currH, currB;
float nextH, nextB;
float easing = 0.001;
int lastChange = 0;

void setup() {
  fullScreen();
  colorMode(HSB, 100);
  currH = nextH = 100;
  currB = nextH = 100;
}

void draw() {
  background(currH, currB, 100);
  updateCurrColor();
  if (5000 < millis() - lastChange) { 
    pickNextColor();
    lastChange = millis();
  }
}

void pickNextColor() {
  nextH = random(100);
  nextB = random(100);
}

void updateCurrColor() {
  // Easing between current and next colors
  currH += easing * (nextH - currH);
  currB += easing * (nextB - currB);
}