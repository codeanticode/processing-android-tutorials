import android.os.Vibrator;
import android.content.Context;
  
ArrayList<PVector> dots;
int totalMin = 24 * 60;
Vibrator vibrator;

void setup() {
  fullScreen();
  frameRate(1);
  dots = new ArrayList<PVector>();
  Context context = (Context) surface.getComponent();
  vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
}

void draw() {
  int time = hour() * 60 + minute();
  if (time == 0) dots.clear();
  float x = map(time, 0, totalMin, 0, width);
  if (ambientMode) {
    background(0);
    noFill();
    stroke(255);    
    line(x, 0, x, height);
    for (PVector d: dots) {
      ellipse(d.x, d.y, 10, 10);
    }    
  } else {
    background(255);
    fill(0);
    noStroke();
    rect(0, 0, x, height);
    for (PVector d: dots) {
      ellipse(d.x, d.y, 10, 10);
    }    
  }
  
  for (int i = dots.size()-1; i >= 0; i--) {
    PVector d = dots.get(i);
    if (d.x < x) {
      dots.remove(i);
      vibrator.vibrate(500);
    }
  }  
} 

void mousePressed() {
  dots.add(new PVector(mouseX, mouseY));
}