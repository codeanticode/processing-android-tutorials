import processing.ar.*;

ARTracker tracker;
ARAnchor touchAnchor;
ArrayList<ARAnchor> trackAnchors = new ArrayList<ARAnchor>();
PShape obj;

void setup() {
  fullScreen(AR);
  obj = loadShape("model.obj");

  tracker = new ARTracker(this);
  tracker.start();
  noStroke();
}

void draw() {
  lights();

  drawObject(touchAnchor);
  for (ARAnchor anchor : trackAnchors) {
    if (anchor.isTracking()) drawSphere(anchor);
    if (anchor.isStopped()) anchor.dispose();
  }
  tracker.clearAnchors(trackAnchors);
  
  drawTrackables();
}

void mousePressed() {
  if (touchAnchor != null) touchAnchor.dispose();
  ARTrackable hit = tracker.get(mouseX, mouseY);
  if (hit != null) touchAnchor = new ARAnchor(hit);
  else touchAnchor = null;
}

void trackableEvent(ARTrackable t) {
  if (trackAnchors.size() < 10 && t.isFloorPlane()) {
    trackAnchors.add(new ARAnchor(t, 0, 0, 0));
  }
}

void drawObject(ARAnchor anchor) {
  if (anchor != null) {
    anchor.attach();
    shape(obj);
    anchor.detach();
  }
}

void drawSphere(ARAnchor anchor) {
  anchor.attach();
  fill(#CF79F5);
  sphere(0.05);
  anchor.detach();
}

void drawTrackables() {
  for (int i = 0; i < tracker.count(); i++) {
    ARTrackable trackable = tracker.get(i);
    if (!trackable.isTracking()) continue;

    pushMatrix();
    trackable.transform();
    if (mousePressed && trackable.isSelected(mouseX, mouseY)) {
      fill(255, 0, 0, 100);
    } else {
      fill(255, 100);
    }

    beginShape(QUADS);
    float lx = trackable.lengthX();
    float lz = trackable.lengthZ();
    vertex(-lx/2, 0, -lz/2);
    vertex(-lx/2, 0, +lz/2);
    vertex(+lx/2, 0, +lz/2);
    vertex(+lx/2, 0, -lz/2);
    endShape();
    popMatrix();
  }  
}
