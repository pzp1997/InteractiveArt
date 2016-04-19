PGraphics mask;

float e = 85;

void setup() {
  size(100, 100);
  
  ellipseMode(CORNER);
  
  background(0);
  fill(255);
  noStroke();
  
  ellipse((100-e)/2, 0, e, 100);
  save("mask.png");
}