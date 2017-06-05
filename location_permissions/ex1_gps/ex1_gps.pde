/*****************************************************************************************

 Android Processing GPS example
 
 Query the phone's GPS and display the data on the screen
 
 Rolf van Gelder - v 22/02/2011 - http://cage.nl :: http://cagewebdev.com :: info@cage.nl
 
 Check the ACCESS_FINE_LOCATION permission in Sketch Permissions!
 
 *****************************************************************************************/

// Import needed Android libs
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.Manifest;

// Set up the variables for the LocationManager and LocationListener
LocationManager locationManager;
MyLocationListener locationListener;

// Variables to hold the current GPS data
float currentLatitude  = 0;
float currentLongitude = 0;
float currentAccuracy  = 0;
String currentProvider = "";

boolean hasLocation = false;

void setup () {
  fullScreen();
  orientation(PORTRAIT);  
  textFont(createFont("SansSerif", 26 * displayDensity));
  textAlign(CENTER, CENTER);
  requestPermission("android.permission.ACCESS_FINE_LOCATION", "initLocation");
}

void draw() {
  background(0);
  if (hasPermission("android.permission.ACCESS_FINE_LOCATION")) {
    text("Latitude: " + currentLatitude + "\n" +
         "Longitude: " + currentLongitude + "\n" +
         "Accuracy: " + currentAccuracy + "\n" +
         "Provider: " + currentProvider, 0, 0, width, height);
  } else {
    text("No permissions to access location", 0, 0, width, height);
  }
}

void initLocation(boolean granted) {
  if (granted) {    
    Context context = getContext();
    locationListener = new MyLocationListener();
    locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);    
    // Register the listener with the Location Manager to receive location updates
    locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
    hasLocation = true;
  } else {
    hasLocation = false;
  }
}

// Class for capturing the GPS data
class MyLocationListener implements LocationListener {
  public void onLocationChanged(Location location) {
    currentLatitude  = (float)location.getLatitude();
    currentLongitude = (float)location.getLongitude();
    currentAccuracy  = (float)location.getAccuracy();
    currentProvider  = location.getProvider();
  }

  public void onProviderDisabled (String provider) { 
    currentProvider = "";
  }

  public void onProviderEnabled (String provider) { 
    currentProvider = provider;
  }

  public void onStatusChanged (String provider, int status, Bundle extras) {
  }
}