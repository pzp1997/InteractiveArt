import processing.video.Capture;

PImage eye;
Capture cam;

void setup() {
  // Eye image
  eye = loadImage("NoIris.png");
  
  // Select and initialize the webcam
  cam = new Capture(this, 640, 480, "Live! Cam Sync HD VF0770");
  try {
    cam.start();
  } catch (NullPointerException e) {
    cam = new Capture(this, 640, 480);
    cam.start();
  }
  
  // Set the size of the canvas according to the dimensions of `painting`
  surface.setSize(cam.width, cam.height);
}


void draw() {
  // Read image from webcam
  if (cam.available()) {
    cam.read();
  }

  // Display the painting
  image(cam, 0, 0, width, height);
  image(eye, 0, 0, width, height);
}