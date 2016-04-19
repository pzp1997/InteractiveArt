import java.awt.Rectangle;

void setup() {
}

void draw() {
  
}

float calcArea(Rectangle r) {
  return r.width * r.height;
}

Rectangle[] findLargestTwoRectangles(Rectangle[] rects) {
  Rectangle largest = new Rectangle();
  Rectangle secondLargest = new Rectangle();
  
  for (Rectangle r : rects) {
    if (calcArea(r) > calcArea(largest)) {
      secondLargest = largest;
      largest = r;
    } else if (calcArea(r) > calcArea(secondLargest)) {
      secondLargest = r;
    }
  }
  
  return new Rectangle[]{largest, secondLargest};
}

Rectangle[] findLargestRectangles(Rectangle[] rects, int n) {
  Rectangle[] largest = new Rectangle[n];
  Rectangle temp;
  
  for (Rectangle r : rects) {
    for (int i = 0; i < largest.length; i++) {
      if (calcArea(r) > calcArea(largest[i])) {
        
        
        temp = largest[i];
        largest[i] = r;
        largest[i+1] = temp;
        for (int j = i; j < largest.length - 1; j++) {
          temp = largest[j+1];
          largest[j+1] = largest[j];
          largest[j] = 
          
          
        
      }
    }
  }
  
  
  return largest;
}