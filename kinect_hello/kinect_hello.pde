import netP5.*;
import oscP5.*;
import SimpleOpenNI.*;

import controlP5.*;
ControlP5 cp5;


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

// Which pixels do we care about?
int minDepth =  60;
int maxDepth = 860;

void setup() {
  cp5 = new ControlP5(this);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableUser();
  size(640, 480);
  fill(255, 0, 0);
  kinect.setMirror(false);

  //generate instance of OSCP5 and newly set the port 7740
  oscP5 = new OscP5(this, 12001);

  //specify the IP adderess and port of the demension OSC
  //127.0.0.1 is local host　
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
  //anzu's IP address
  //myRemoteLocation = new NetAddress("172.20.0.53", 12000);
  
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
  kinect.update();
  image(kinect.userImage(), 0, 0);
  IntVector userList = new IntVector();

  // 1000mm以下を赤くする処理
  int[] depthMap = kinect.depthMap();
  loadPixels();
  for (int y=0; y<kinect.depthHeight(); y++) {
    for (int x=0; x<kinect.depthWidth(); x++) {
      int d = depthMap[x + y*width];
      if (minDepth < d && d < maxDepth ) {
        //pixels[x + y*width] = color(255, 0, 0); // ピクセル値に赤色を設定
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
            bodyX[0]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_HEAD);
            bodyY[0]=convertLocationY(userId, SimpleOpenNI.SKEL_HEAD);
            bodyX[1]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
            bodyY[1]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
            bodyX[2]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
            bodyY[2]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
            bodyX[3]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_TORSO);
            bodyY[3]=convertLocationY(userId, SimpleOpenNI.SKEL_TORSO);
            bodyX[4]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
            bodyY[4]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
            bodyX[5]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
            bodyY[5]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
            bodyX[6]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
            bodyY[6]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
            bodyX[7]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HAND);
            bodyY[7]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HAND);
            bodyX[8]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
            bodyY[8]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
            bodyX[9]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_HIP);
            bodyY[9]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_HIP);
            bodyX[10]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
            bodyY[10]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
            bodyX[11]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
            bodyY[11]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
            bodyX[12]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
            bodyY[12]=convertLocationY(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
            bodyX[13]=-1*convertLocationX(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
            bodyY[13]=convertLocationY(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);

            for (int i=0; i<bodyX.length; i++) {
              myMessage.add(bodyX[i]);
              myMessage.add(bodyY[i]);
            }
            //send OSC message
            oscP5.send(myMessage, myRemoteLocation);
          }
        }
      }
    }
  }
  updatePixels();
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
