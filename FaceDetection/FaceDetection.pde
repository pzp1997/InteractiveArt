import gab.opencv.OpenCV;
import processing.video.Capture;
import java.awt.Rectangle;

Capture cam;
OpenCV faceCascade;
Rectangle[] faces;
Rectangle liveFace;

void setup() {
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
  
  // Setup the face detection object
  faceCascade = new OpenCV(this, cam.width, cam.height);
  faceCascade.loadCascade(OpenCV.CASCADE_FRONTALFACE); //<>//
  
  noFill();
  strokeWeight(5);
  ellipseMode(CORNER);
}

void draw() {
  // Read image from webcam
  if (cam.available()) {
    cam.read();
  }

  // Detect the faces in the live image
  faceCascade.loadImage(cam);
  faces = faceCascade.detect();
  liveFace = findLargestFace(faces);
  
  // Display the painting
  image(cam, 0, 0, width, height);
  
  //stroke(255, 0, 0);
  //for (Rectangle face : faces) {
  //  rect(face.x, face.y, face.width, face.height);
  //  ellipse(face.x, face.y, face.width, face.height);
  //}
  
  stroke(0, 255, 0);
  //rect(liveFace.x, liveFace.y, liveFace.width, liveFace.height);
  ellipse(liveFace.x + liveFace.width * 0.075, liveFace.y, liveFace.width * 0.85, liveFace.height);
}
  
Rectangle findLargestFace(Rectangle[] faces) {
  Rectangle largestFace = new Rectangle();
  float maxArea = -1;
  float area;

  for (Rectangle face : faces) {
    area = face.width * face.height;
    if (area > maxArea) {
      largestFace = face;
      maxArea = area;
    }
  }

  return largestFace;
}