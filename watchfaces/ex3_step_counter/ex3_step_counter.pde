import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

SensorManager manager;
Sensor sensor;
SensorListener listener;

int offset = -1;
int steps;

void setup() {
  fullScreen();
  frameRate(1);

  textFont(createFont("SansSerif", 30 * displayDensity));
  textAlign(CENTER, CENTER);
  fill(255);  
  
  Context context = getContext();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);  
  listener = new SensorListener();  
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_NORMAL);  
}

void draw() {
  background(0);
  translate(0, +wearInsets().bottom/2);
  if (!wearAmbient()) {
    String str = steps + " steps";
    float w = textWidth(str);
    text(str, 0, 0, width, height);     
  }
}

public void resume() {
  if (manager != null) {
    manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
  }
}

public void pause() {
  if (manager != null) {
    manager.unregisterListener(listener);
  }
}

class SensorListener implements SensorEventListener {
  public void onSensorChanged(SensorEvent event) {
    if (offset == -1) offset = (int)event.values[0]; 
    steps = (int)event.values[0] - offset;
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) { }
}