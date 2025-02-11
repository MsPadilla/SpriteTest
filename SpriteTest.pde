/**
 * Animated Sprite Test
 * by Tania Padilla. 
 * 
 * 
 * Demonstrates loading, displaying, and animating PNG images.
 *  
 */

Animation animation1;

float xpos;
float ypos;
float drag = 30.0;

void setup() {
  size(640, 360);
  frameRate(24);
  animation1 = new Animation("rabbit", 7);
 
  ypos = height * 0.25;
}

void draw() { 
  float dx = mouseX - xpos;
  xpos = xpos + dx/drag;
  ypos = mouseY;

    background(0);
    animation1.display(xpos-animation1.getWidth()/2, ypos);

}

// Class for animating a sequence of GIFs

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
}
