import netP5.*;
import oscP5.*;

import SimpleOpenNI.*;


//Generate a SimpleOpenNI object
SimpleOpenNI kinect;

//generate OSCP5 class of instance
OscP5 oscP5;

//net adderess to OSC
NetAddress myRemoteLocation;


//Vectors used to calculate the center of the mass
PVector com = new PVector();
PVector com2d = new PVector();

void setup() {
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  size(640, 480);
  fill(255, 0, 0);
  kinect.setMirror(true);

  //generate instance of OSCP5 and newly set the port 7740
  oscP5 = new OscP5(this, 12001);

  //specify the IP adderess and port of the demension OSC
  //127.0.0.1 is local host　
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}

void draw() {
  kinect.update();
  image(kinect.userImage(), 0, 0);
  IntVector userList = new IntVector();
  //get user's location
  kinect.getUsers(userList);
  if (userList.size() > 0) {
    int userId = userList.get(0);
    //If we detect one user we have to draw it
    if ( kinect.isTrackingSkeleton(userId)) {
      //DrawSkeleton
      drawSkeleton(userId);  
      //Draw the user Mass
      MassUser(userId);

      kinect.convertRealWorldToProjective(com, com2d);

      //send mass location by osc
      //OscMessage myMessage = new OscMessage("/kinect/location");
      //each born location
      //myMessage.add(SimpleOpenNI.SKEL_HEAD); 
      //myMessage.add(SimpleOpenNI.SKEL_NECK); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_SHOULDER); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_ELBOW); 
      //myMessage.add(SimpleOpenNI.SKEL_NECK); 
      //myMessage.add(SimpleOpenNI.SKEL_RIGHT_SHOULDER); 
      //myMessage.add(SimpleOpenNI.SKEL_RIGHT_ELBOW); 
      //myMessage.add(SimpleOpenNI.SKEL_TORSO); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_HIP); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_FOOT); 
      //myMessage.add(SimpleOpenNI.SKEL_RIGHT_HIP); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_FOOT); 
      //myMessage.add(SimpleOpenNI.SKEL_RIGHT_KNEE); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_HIP); 
      //myMessage.add(SimpleOpenNI.SKEL_RIGHT_FOOT); 
      //myMessage.add(SimpleOpenNI.SKEL_RIGHT_HAND); 
      //myMessage.add(SimpleOpenNI.SKEL_LEFT_HAND); 



      //send OSC message
      //oscP5.send(myMessage, myRemoteLocation);
    }
  }
  OscMessage myMessage = new OscMessage("kinect");
  myMessage.add(mouseX);
  myMessage.add(mouseY); 
  //send OSC message
  oscP5.send(myMessage, myRemoteLocation);
  //oscP5.plug(this,"getData","/pattern");
  println(myMessage);
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 30, 30);
}
//Draw the skeleton
void drawSkeleton(int userId) {
  stroke(0);
  strokeWeight(5);
  //connect each part
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);
  noStroke();
  fill(255, 0, 0);
  drawJoint(userId, SimpleOpenNI.SKEL_HEAD);
  drawJoint(userId, SimpleOpenNI.SKEL_NECK);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
  drawJoint(userId, SimpleOpenNI.SKEL_NECK);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
  drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
}

void drawJoint(int userId, int jointID) {

  //get location of three dimension at each place
  PVector joint = new PVector();
  kinect.getJointPositionSkeleton(userId, jointID, joint);

  //convert three dimension to two dimension
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
  ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
}

//Calibration not required

void onNewUser(SimpleOpenNI kinect, int userID) {
  println("Start skeleton tracking");
  kinect.startTrackingSkeleton(userID);
}

void onLostUser(SimpleOpenNI curContext, int userId) {
  println("onLostUser - userId: " + userId);
}


//display 
void MassUser(int userId) {
  if (kinect.getCoM(userId, com)) {
    kinect.convertRealWorldToProjective(com, com2d);
    stroke(100, 255, 240);
    strokeWeight(3);
    beginShape(LINES);
    vertex(com2d.x, com2d.y - 5);
    vertex(com2d.x, com2d.y + 5);
    vertex(com2d.x - 5, com2d.y);
    vertex(com2d.x + 5, com2d.y);
    endShape();
  }
}
