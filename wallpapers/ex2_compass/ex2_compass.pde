// Based on the compass example from Rolf van Gelder.
// http://cagewebdev.com/index.php/android-processing-examples/

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

Context context;
SensorManager manager;
SensorListener listener;
Sensor accelerometer;
Sensor magnetometer;

float easing = 0.05;

float azimuth;
float pitch;
float roll;

void setup() {
  fullScreen(P2D);
  orientation(PORTRAIT);
}

void draw() {
  background(255);
  
  float cx = width * 0.5;
  float cy = height * 0.4;
  float radius = 0.8 * cx;
  
  translate(cx, cy);
  
  noFill();
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, radius*2, radius*2);
  line(0, -cy, 0, -radius);
  
  fill(192, 0, 0);
  noStroke();    
  rotate(-azimuth);
  beginShape();
  vertex(-30, 40);
  vertex(0, 0);
  vertex(30, 40);
  vertex(0, -radius);
  endShape();
}

public void onResume() {
  super.onResume();  

  context = surface.getContext();
  
  listener = new SensorListener();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  accelerometer = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  magnetometer  = manager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);

  manager.registerListener(listener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL);
  manager.registerListener(listener, magnetometer, SensorManager.SENSOR_DELAY_NORMAL);
}

public void onPause() {
  super.onPause();
  if (manager != null) manager.unregisterListener(listener);
}

class SensorListener implements SensorEventListener {
  float[] gravity = new float[3];
  float[] geomagnetic = new float[3];
  float[] I = new float[16];
  float[] R = new float[16];
  float orientation[] = new float[3]; 
  
  public void onSensorChanged(SensorEvent event) {
    if (event.accuracy == SensorManager.SENSOR_STATUS_ACCURACY_LOW) return;
    
    if (event.sensor.getType() ==  Sensor.TYPE_MAGNETIC_FIELD) {
      arrayCopy(event.values, geomagnetic);
    }
    if (event.sensor.getType() ==  Sensor.TYPE_ACCELEROMETER) {
      arrayCopy(event.values, gravity);
    }
    if (SensorManager.getRotationMatrix(R, I, gravity, geomagnetic)) {
      SensorManager.getOrientation(R, orientation);
      azimuth += easing * (orientation[0] - azimuth);
      pitch += easing * (orientation[1] - pitch);
      roll += easing * (orientation[2] - roll);
    }    
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) { }
}