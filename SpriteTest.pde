/**
 * Animated Sprite Test
 * by Tania Padilla. 
 * 
 * Demonstrates loading, displaying, and animating PNG images.
 * 
 * AP CSA Concepts Covered:
 * - Unit 1: Primitive types (float, int)
 * - Unit 2: Using objects (PImage, Animation class)
 * - Unit 3: Boolean expressions and `if` statements (flipping the sprite)
 * - Unit 4: Iteration (for loops for loading images)
 * - Unit 5: Writing classes (Animation class)
 * - Unit 6: Arrays and ArrayLists (storing animation frames)
 */

Animation animation1; // Declares a variable to hold the animation object

// Unit 1: Variables and Data Types
float xpos; // Stores the sprite's current x position
float ypos; // Stores the sprite's current y position
float drag = 30.0; // Controls the smoothness of movement (higher value = slower movement)

void setup() {
  size(640, 360); // Sets the window size (Unit 2: Calling a method)
  frameRate(12);  // Sets the animation speed (24 frames per second)
  
  // Instantiates an Animation object (Unit 2: Creating objects)
  animation1 = new Animation("rabbit", 7); // Loads a sprite with 7 frames
  
  ypos = height * 0.25; // Positions the sprite at 25% of the screen height
}

void draw() { 
  // Unit 3: Boolean Expressions and `if` Statements
  // Calculate movement using smooth dragging
  float dx = mouseX - xpos; // Difference between mouse position and sprite position
  xpos += dx / drag; // Moves the sprite toward the mouse with easing
  ypos = mouseY; // Allows vertical movement by tracking the mouse

  background(0); // Clears the screen with a black background
  
  // Calls the display method of the animation object (Unit 5: Calling instance methods)
  animation1.display(xpos, ypos); 
}

// Class for animating a sequence of PNGs
class Animation {
  // Unit 6: Arrays
  PImage[] images; // Stores the frames of the animation as an array of PImage objects
  int imageCount;  // Stores the total number of frames in the animation
  int frame;       // Tracks the current frame being displayed
  
  // Constructor for the Animation class (Unit 5: Writing constructors)
  Animation(String imagePrefix, int count) {
    imageCount = count; // Sets the number of images in the animation
    images = new PImage[imageCount]; // Initializes the array to store images

    // Unit 4: Iteration (Using a `for` loop to load multiple images)
    for (int i = 0; i < imageCount; i++) {
      // Generates filenames dynamically (e.g., rabbit0000.png, rabbit0001.png, ...)
      String filename = imagePrefix + nf(i, 4) + ".png"; // nf() function is used to add zeros to the left and/or right of a number. 
      //This is typically for aligning a list of numbers. 
      
      // Uses the loadImage method to load each image
      images[i] = loadImage(filename);
      
      // Debugging: Check if images load correctly
      //if (images[i] == null) {
       // println("Failed to load: " + filename); // Prints an error if the image fails to load
      //} else {
      //  println("Loaded: " + filename); // Confirms the image loaded successfully
      //}
    }
  }

  // Method to display the current frame of the animation (Unit 5: Methods)
  void display(float xpos, float ypos) {
    // Unit 3: Boolean Expressions and `if` Statements
    if (images.length > 0 && images[frame] != null) { // Ensures images exist before displaying
      pushMatrix();  // Saves the current transformation state
      
      // If the mouse is to the left of the sprite, flip the image (Unit 3: `if` statement)
      if (mouseX < xpos) {
        scale(-1, 1); // Flips the image horizontally
        image(images[frame], -xpos - images[frame].width, ypos); // Adjusts position for flip
      } else {
        image(images[frame], xpos, ypos); // Displays normally if the mouse is on the right
      }
      
      popMatrix();  // Restores the original transformation state
    }

    // Unit 4: Iteration (`%` operator ensures looping through frames)
    frame = (frame + 1) % imageCount; // Loops through frames to animate
  }
  
  // Method to get the width of the first image in the animation
  int getWidth() {
    // Unit 3: Boolean Expressions (`if` statement prevents null pointer errors)
    if (images.length > 0 && images[0] != null) {
      return images[0].width; // Returns the width of the first frame
    } else {
      return 0; // Returns 0 if no images are loaded (prevents crashes)
    }
  }
}
