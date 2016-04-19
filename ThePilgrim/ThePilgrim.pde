import gab.opencv.OpenCV;
import processing.video.Capture;
import java.awt.Rectangle;

PImage monaLisa;
Capture cam;
OpenCV faceCascade;
Rectangle[] faces;
Rectangle monaLisaFace, liveFace;

void setup() {
  // Load PImage of the Mona Lisa
  monaLisa = loadImage("ThePilgrim.jpg");
  
  // Set the size of the canvas according to the dimensions of `monaLisa`
  surface.setSize(monaLisa.width, monaLisa.height);
  
  // Select and initialize the webcam
  cam = new Capture(this, 640, 480, "Live! Cam Sync HD VF0770");
  try {
    cam.start();
  } catch (NullPointerException e) {
    cam = new Capture(this, 640, 480);
    cam.start();
  }
  
  // Detect the Mona Lisa's face and store Rectangle of it in `monaLisaFace`
  faceCascade = new OpenCV(this, monaLisa.width, monaLisa.height);
  faceCascade.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faceCascade.loadImage(monaLisa);
  monaLisaFace = findLargestFace(faceCascade.detect());
  
  // Setup the face detection object
  faceCascade = new OpenCV(this, cam.width, cam.height);
  faceCascade.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  // Set default drawing options
  noFill();
  strokeWeight(5);
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
  
  // Display the Mona Lisa
  image(monaLisa, 0, 0, width, height);
  
  // Insert *the* face on top of the Mona Lisa's face
  blend(cam, liveFace.x, liveFace.y, liveFace.width, liveFace.height,
        monaLisaFace.x, monaLisaFace.y, monaLisaFace.width, monaLisaFace.height, MULTIPLY);
}

// Save the outputted picture when the mouse is pressed
void mousePressed() {
  // Save current canvas to sketch folder
  saveFrame();
  // "Flash" animation 
  background(255);
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