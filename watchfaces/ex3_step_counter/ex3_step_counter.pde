import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;

Context context;
SensorManager manager;
Sensor sensor;
SensorListener listener;

int offset = -1;
int steps;

void setup() {
  fullScreen();
  frameRate(1);
  Context context = (Context) surface.getComponent();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);  

  textFont(createFont("Roboto", 36));
  fill(255);  
}

void draw() {
  background(0);
  translate(0, +insetBottom/2);
  if (!ambientMode) {
    String str = steps + " steps";
    float w = textWidth(str);
    text(str, (width - w)/2, height/2 + 24);     
  }
}

public void onResume() {
  super.onResume();
  Context context = (Context) surface.getComponent();
  manager = (SensorManager)context.getSystemService(Context.SENSOR_SERVICE);
  sensor = manager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);  
  listener = new SensorListener();
  
  manager.registerListener(listener, sensor, SensorManager.SENSOR_DELAY_NORMAL);
}

public void onPause() {
  super.onPause();
  if (manager != null) manager.unregisterListener(listener);
}

class SensorListener implements SensorEventListener {
  public void onSensorChanged(SensorEvent event) {
    if (offset == -1) offset = (int)event.values[0]; 
    steps = (int)event.values[0] - offset;
  }
  public void onAccuracyChanged(Sensor sensor, int accuracy) { }
}