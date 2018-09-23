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

float[]bodyX=new float[17];
float[]bodyY=new float[17];

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
      OscMessage myMessage = new OscMessage("kinect");
      //send each born location
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_HEAD)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_HEAD)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_NECK)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_NECK));
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER));  
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_ELBOW)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_ELBOW));  
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_NECK)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_NECK));  
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_TORSO)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_TORSO)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HIP)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HIP)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_FOOT)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_FOOT)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_HIP)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_HIP));  
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_FOOT)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_FOOT));  
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_KNEE)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_KNEE)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HIP)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HIP)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_FOOT)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_FOOT)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_HAND)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_HAND)); 
      //myMessage.add(convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HAND)); 
      //myMessage.add(convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HAND)); 
      bodyX[0]=convertLocationX(userId, SimpleOpenNI.SKEL_HEAD);
      bodyY[0]=convertLocationY(userId, SimpleOpenNI.SKEL_HEAD);
      bodyX[1]=convertLocationX(userId, SimpleOpenNI.SKEL_NECK);
      bodyY[1]=convertLocationY(userId, SimpleOpenNI.SKEL_NECK);
      bodyX[2]=convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
      bodyY[2]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
      bodyX[3]=convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
      bodyY[3]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
      bodyX[4]=convertLocationX(userId, SimpleOpenNI.SKEL_NECK);
      bodyY[4]=convertLocationY(userId, SimpleOpenNI.SKEL_NECK);
      bodyX[5]=convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
      bodyY[5]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
      bodyX[6]=convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
      bodyY[6]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
      bodyX[7]=convertLocationX(userId, SimpleOpenNI.SKEL_TORSO);
      bodyY[7]=convertLocationY(userId, SimpleOpenNI.SKEL_TORSO);
      bodyX[8]=convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HIP);
      bodyY[8]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HIP);
      bodyX[9]=convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
      bodyY[9]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
      bodyX[10]=convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
      bodyY[10]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
      bodyX[11]=convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HIP);
      bodyY[11]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HIP);
      bodyX[12]=convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
      bodyY[12]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
      bodyX[13]=convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HAND);
      bodyY[13]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HAND);

      //myMessage.add(bodyX[0]);
      //myMessage.add(bodyY[0]);
      //myMessage.add(bodyX[1]);
      //myMessage.add(bodyY[1]);
      //myMessage.add(bodyX[2]);
      //myMessage.add(bodyY[2]);
      //myMessage.add(bodyX[3]);
      //myMessage.add(bodyY[3]);
      //myMessage.add(bodyX[4]);
      //myMessage.add(bodyY[4]);
      //myMessage.add(bodyX[5]);
      //myMessage.add(bodyY[5]);
      //myMessage.add(bodyX[6]);
      //myMessage.add(bodyY[6]);
      //myMessage.add(bodyX[7]);
      //myMessage.add(bodyY[7]);
      //myMessage.add(bodyX[8]);
      //myMessage.add(bodyY[8]);
      //myMessage.add(bodyX[9]);
      //myMessage.add(bodyY[9]);
      //myMessage.add(bodyX[10]);
      //myMessage.add(bodyY[10]);
      //myMessage.add(bodyX[11]);
      //myMessage.add(bodyY[11]);
      //myMessage.add(bodyX[12]);
      //myMessage.add(bodyY[12]);
      //myMessage.add(bodyX[13]);
      //myMessage.add(bodyY[13]);
    

      for (int i=0; i<bodyX.length; i++) {
        myMessage.add(bodyX[i]);
        myMessage.add(bodyY[i]);
      }
      //send OSC message
      oscP5.send(myMessage, myRemoteLocation);
    }
  }
  //OscMessage myMessage = new OscMessage("kinect");
  //myMessage.add(mouseX);
  //myMessage.add(mouseY); 
  ////send OSC message
  //oscP5.send(myMessage, myRemoteLocation);

  //fill(255, 0, 0);
  //ellipse(mouseX, mouseY, 30, 30);
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

float convertLocationX(int userId, int jointID) {

  //get location of three dimension at each place
  PVector joint = new PVector();
  kinect.getJointPositionSkeleton(userId, jointID, joint);

  //convert three dimension to two dimension
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
  return convertedJoint.x;
}

float convertLocationY(int userId, int jointID) {

  //get location of three dimension at each place
  PVector joint = new PVector();
  kinect.getJointPositionSkeleton(userId, jointID, joint);

  //convert three dimension to two dimension
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
  return convertedJoint.y;
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
