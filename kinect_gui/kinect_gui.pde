import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import controlP5.*;
ControlP5 cp5;

Kinect kinect;

// Depth image
PImage depthImg;

// Which pixels do we care about?
int minDepth =  60;
int maxDepth = 860;

// What is the kinect's angle
float angle;

void setup() {
  size(1280, 480);

  cp5 = new ControlP5(this);
  kinect = new Kinect(this);
  kinect.initDepth();
  //これで高さ調節
  angle = kinect.getTilt();

  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);

  cp5.addSlider("angle")
    .setPosition(0, 0)
    .setRange(0, 30)
    ;

  cp5.addSlider("minDepth")
    .setPosition(0, 10)
    .setRange(0, maxDepth)
    ;

  cp5.addSlider("maxDepth")
    .setPosition(0, 20)
    .setRange(minDepth, 2047)
    ;
}

void draw() {
  // Draw the raw image
  image(kinect.getDepthImage(), 0, 0);

  kinect.setTilt(angle);

  // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(255);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }

  // Draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, kinect.width, 0);
}
