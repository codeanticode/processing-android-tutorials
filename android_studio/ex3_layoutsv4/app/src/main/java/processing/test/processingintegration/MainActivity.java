package processing.test.processingintegration;

import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.ViewTreeObserver;
import android.view.Menu;
import android.view.MenuItem;
import android.os.Build;

import processing.android.PFragment;

public class MainActivity extends AppCompatActivity {
  Sketch sketch;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
    setSupportActionBar(toolbar);

    sketch = new Sketch();
    PFragment fragment = new PFragment();
    fragment.setSketch(sketch);
    fragment.init(R.id.content_main, getSupportFragmentManager());

//    FragmentManager fragmentManager = getSupportFragmentManager();
//    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
//    fragmentTransaction.add(R.id.content_main, fragment);
//    fragmentTransaction.commit();



//    final View parent = findViewById(R.id.content_main);
//    parent.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
//        @Override
//        public void onGlobalLayout() {
//            int availableWidth = parent.getMeasuredWidth();
//            int availableHeight = parent.getMeasuredHeight();
//            if (availableHeight > 0 && availableWidth > 0) {
//              System.err.println(availableWidth + " " + availableHeight);
//              if (Build.VERSION.SDK_INT < Build.VERSION_CODES.JELLY_BEAN) {
//                parent.getViewTreeObserver().removeGlobalOnLayoutListener(this);
//              } else {
//                parent.getViewTreeObserver().removeOnGlobalLayoutListener(this);
//              }
//
//            }
//        }
//
//
//    });
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    // Inflate the menu; this adds items to the action bar if it is present.
    getMenuInflater().inflate(R.menu.menu_main, menu);
    return true;
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    // Handle action bar item clicks here. The action bar will
    // automatically handle clicks on the Home/Up button, so long
    // as you specify a parent activity in AndroidManifest.xml.
    int id = item.getItemId();

    //noinspection SimplifiableIfStatement
    if (id == R.id.action_settings) {
      return true;
    }

    return super.onOptionsItemSelected(item);
  }
}
