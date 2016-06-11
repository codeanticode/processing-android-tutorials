// Android Mode tutorials
// http://android.processing.org/tutorials/
// Sensors - Boxes example

// Rectangles trapped inside the screen, and moving by gravity
// Based on Box2DProcessing from The Nature of Code

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Context context;
SensorManager manager;
Sensor sensor;
AccelerometerListener listener;
float ax, ay, az;

Box2DProcessing box2d;
ArrayList<Box> boxes;
ArrayList<Wall> walls;

void setup() {
  fullScreen(P2D);
  orientation(PORTRAIT);
  
  context = getActivity();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  listener = new AccelerometerListener();
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  // A group of boxes
  boxes = new ArrayList<Box>();
  for (int i = 0; i < 20; i++) {
    Box p = new Box(random(200, width-200), random(200, height-200));
    boxes.add(p);
  }
  
  // Invisible walls
  walls = new ArrayList<Wall>();
  walls.add(new Wall(width/2, -25, width, 50));
  walls.add(new Wall(width/2, height+25, width, 50));
  walls.add(new Wall(-25, height/2, 50, height));
  walls.add(new Wall(width+25, height/2, 50, height));
}

void draw() {
  background(255);  
  
  // update gravity from accelerometer data.
  box2d.setGravity(-ax, -ay);
  
  box2d.step();
  
  for (Box b: boxes) {
    b.display();
  }
}

void mousePressed() {
  for (Box b: boxes) {
    b.shake();
  }   
}

public void onResume() {
  super.onResume();
  if (manager != null) {
    manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_GAME);
  }
}

public void onPause() {
  super.onPause();
  if (manager != null) {
    manager.unregisterListener(listener);
  }
}

class AccelerometerListener implements SensorEventListener {
  public void onSensorChanged(SensorEvent event) {
    ax = event.values[0];
    ay = event.values[1];
    az = event.values[2];    
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) {
  }
}