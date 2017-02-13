package processing.test.androidwatchexport;

import android.app.Activity;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import processing.android.PFragment;

// Make sure Debugging over Bluetooth is enabled (both host and target must appear connected
// in the Setting of the wear app), and the wearable device listed by adb:
// https://developer.android.com/training/wearables/apps/bt-debugging.html

// How to build app from command line with gradle
// https://developer.android.com/studio/build/building-cmdline.html

// Packaging wear apps with Android Studio and manually:
// https://developer.android.com/training/wearables/apps/packaging.html#PackageManually

// Mobile and wear apks build with Android Studio need to be installed separately.
// But uninstalling the mobile app will automatically uninstall the wear app.

public class HandheldActivity extends AppCompatActivity {
  Sketch sketch;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_handheld);
    sketch = new Sketch();
    PFragment fragment = new PFragment();
    fragment.setSketch(sketch);
    fragment.init(R.id.content_main, getSupportFragmentManager());
  }
} 
