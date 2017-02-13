package processing.test.androidwatchexport;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AndroidWatchExport extends PApplet {

public void setup() {
  textFont(createFont("Serif", 36));
  textAlign(CENTER, CENTER);
  fill(255);
}

public void draw() {
  background(0);
  if (!ambientMode) {
    text(hour() + ":" + nfs(minute(), 2) + ":" + nfs(second(), 2), width/2, height/2);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AndroidWatchExport" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
