import netP5.*;
import oscP5.*;
import processing.serial.*;

//generate OSCP5 class of instance
OscP5 oscP5; 

Serial port;
//arduinoから受け取った値を格納する変数
int val;

int numFrames = 28;

ArrayList<Wave> wv=new ArrayList<Wave>();
ArrayList<Molfo> ml=new ArrayList<Molfo>();
ArrayList<Monshiro> ms=new ArrayList<Monshiro>();
ArrayList<Asagimadara>as=new ArrayList<Asagimadara>();
ArrayList<Oomurasaki>oo=new ArrayList<Oomurasaki>();
ArrayList<Ageha>ag=new ArrayList<Ageha>();
ArrayList<Petal>pt=new ArrayList<Petal>(); 


float mlSpan=30;
float msSpan=15;
float asSpan=120;
float ooSpan=60;
float agSpan=14;
float easing=0.05;
PVector []body=new PVector[17];
float[]flowerSize=new float[28];
PImage[]flowers=new PImage[7];
PImage img;
PVector[]flowerTarget=new PVector[28];
PVector[]flowerPos=new PVector[28];
PVector wind;
PVector gravity=new PVector(0, 5);
float windNoise=0.0;


void setup() {

  //fullScreen(P2D);
  size(1200, 1200, P2D);
  background(21);
  smooth();
  noCursor();
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  frameRate(30);
  imageMode(CENTER);

  //println(Serial.list());
  //port番号は適宜
  String arduinoPort=Serial.list()[3];
  port = new Serial(this, arduinoPort, 9600);


  // ポートを12000に設定して新規にOSCP5のインスタンスを生成する
  oscP5 = new OscP5(this, 12000);

  for (int i=0; i<body.length; i++) {
    body[i]=new PVector(random(width), random(height));
  }

  for (int i = 0; i < flowers.length; i++) {
    flowers[i] = loadImage(i+".png");
  }

  for (int i=0; i<flowerSize.length; i++) {
    flowerSize[i]=random(50, 100); 
    flowerPos[i]=new PVector(random(width), random(height));
  }
  flowerSize[0]=200;
  wind=new PVector(0, 0);
}

void draw() {

  background(21);

  //make wind
  wind=new PVector(map(noise(windNoise), 0, 1, -5, 5), 0);
  windNoise+=0.01;

  //ganerate wave
  for (int i=wv.size()-1; i>=0; i--) {
    Wave w=wv.get(i); 
    w.run();
    if (w.isDead()) {
      wv.remove(i);
    }
  }

  makeBody();
  drawBody();

  //=============draw Petal
  for (int i=pt.size()-1; i>=0; i--) {
    Petal p=pt.get(i);
    p.addForce(gravity);
    p.addForce(wind);
    p.update();
    p.display();
    if (p.isDead()) {
      pt.remove(i);
    }
  }

  //============create petal
  if (random(1)>0.9) {
    pt.add(new Petal(flowerPos[int(random(27))], int(random(3)), random(1, 3)));
  }

  //モルフォチョウ
  for (int i=ml.size()-1; i>=0; i--) {
    Molfo m=ml.get(i);
    m.update(flowerTarget[i%28]);
    //m.update(body[12]);
    m.display();
    if (m.lifeSpan<0.0) {
      ml.remove(i);
    }
  }

  //モンシロチョウ
  for (int i=ms.size()-1; i>=0; i--) {
    Monshiro m=ms.get(i);
    m.update(flowerTarget[i%28]);
    //m.update(body[12]);
    m.display();
    if (m.lifeSpan<0.0) {
      ms.remove(i);
    }
  }

  //アサギマダラ
  for (int i=as.size()-1; i>=0; i--) {
    Asagimadara a=as.get(i);
    a.update(flowerTarget[i%28]);
    a.display();
    if (a.lifeSpan<0.0) {
      ms.remove(i);
    }
  }

  //オオムラサキ
  for (int i=oo.size()-1; i>=0; i--) {
    Oomurasaki o=oo.get(i);
    o.update(flowerTarget[i%28]);
    //o.update(body[12]);
    o.display();
    if (o.lifeSpan<0.0) {
      oo.remove(i);
    }
  }

  //アゲハ
  for (int i=ag.size()-1; i>=0; i--) {
    Ageha a=ag.get(i);
    a.update(flowerTarget[i%28]);
    a.display();
    if (a.lifeSpan<0.0) {
      ag.remove(i);
    }
  }

  if (val==1||val==2||val==3||val==4||val==5) {
    if (val==1) {
      PVector location=new PVector(random(width), random(height));
      ml.add(new Molfo(location, mlSpan, radians(random(-90, 90))));
      wv.add(new Wave(location));
    }
    if (val==2) {
      for (int i=0; i<3; i++) {
        PVector location=new PVector(random(width), random(height));
        ms.add(new Monshiro(location, msSpan, radians(random(-90, 90))));
        wv.add(new Wave(location));
      }
    }
    if (val==3) {
      for (int i=0; i<3; i++) {
        PVector location=new PVector(random(width), random(height));
        as.add(new Asagimadara(location, asSpan, radians(random(-90, 90))));
        wv.add(new Wave(location));
      }
    }
    if (val==4) {
      for (int i=0; i<3; i++) {
        PVector location=new PVector(random(width), random(height));
        oo.add(new Oomurasaki(location, ooSpan, radians(random(-90, 90))));
        wv.add(new Wave(location));
      }
    }
    if (val==5) {
      for (int i=0; i<3; i++) {
        PVector location=new PVector(random(width), random(height));
        ag.add(new Ageha(location, agSpan, radians(random(-90, 90))));
        wv.add(new Wave(location));
      }
    }
  }
}
//シリアルイベント
void serialEvent(Serial p) {
  p=port;
  val=port.read();
}


void makeBody() {
  for (int i=0; i<body.length; i++) {
    flowerTarget[i]=body[i];
  }

  //Midpoint of head and torso
  flowerTarget[27]=new PVector((body[0].x+body[3].x)/2, (body[0].y+body[3].y)/2);
  //Midpoint of torso, left shoulder and left hand
  flowerTarget[26]=new PVector((body[1].x+body[7].x+body[3].x)/3, (body[1].y+body[7].y+body[3].y)/3);
  //Midpoint of torso, right shoulder and right hand
  flowerTarget[14]=new PVector((body[2].x+body[8].x+body[3].x)/3, (body[2].y+body[8].y+body[3].y)/3);
  //Midpoint of left shoulder and left hand
  flowerTarget[15]=new PVector((body[1].x+body[7].x)/2, (body[1].y+body[7].y)/2);
  //Midpoint of right shoulder and right hand
  flowerTarget[16]=new PVector((body[2].x+body[8].x)/2, (body[2].y+body[8].y)/2);
  //Midpoint of torso, left knee and left knee
  flowerTarget[17]=new PVector((body[11].x+body[10].x+body[3].x)/3, (body[11].y+body[10].y+body[3].y)/3);
  //Midpoint of left knee, left knee, left hip and right hip
  flowerTarget[18]=new PVector((body[11].x+body[10].x+body[8].x+body[9].x)/4, (body[11].y+body[10].y+body[8].y+body[9].y)/4);
  //Midpoint of right knee and left knee
  flowerTarget[19]=new PVector((body[11].x+body[10].x)/2, (body[11].y+body[10].y)/2);
  //Midpoint of right hip and left hip
  flowerTarget[20]=new PVector((body[9].x+body[8].x)/2, (body[9].y+body[8].y)/2);
  //Midpoint of left knee and left hip
  flowerTarget[21]=new PVector((body[11].x+body[9].x)/2, (body[11].y+body[9].y)/2);
  //Midpoint of right knee and right hip
  flowerTarget[22]=new PVector((body[10].x+body[8].x)/2, (body[10].y+body[8].y)/2);
  //Midpoint of left foot and left hip
  flowerTarget[23]=new PVector((body[4].x+body[9].x)/2, (body[4].y+body[9].y)/2);
  //Midpoint of right foot and right hip
  flowerTarget[24]=new PVector((body[5].x+body[8].x)/2, (body[5].y+body[8].y)/2);

  //ここから適当
  flowerTarget[25]=new PVector((flowerTarget[1].x+flowerTarget[3].x+flowerTarget[13].x)/3, (flowerTarget[1].y+flowerTarget[3].y+flowerTarget[13].y)/3);
  //=====================add easing function to flower
  for (int i=0; i<flowerTarget.length; i++) {
    float dx = flowerTarget[i].x - flowerPos[i].x;
    flowerPos[i].x += dx * easing;
    float dy = flowerTarget[i].y - flowerPos[i].y;
    flowerPos[i].y += dy * easing;
  }
}


void drawBody() {

  noTint();
  for (int i=0; i<flowerPos.length; i++) {
    image(flowers[i%7], flowerPos[i].x, flowerPos[i].y, flowerSize[i], flowerSize[i]);
  }
}


// OSCメッセージを受信した際に実行するイベント
void oscEvent(OscMessage theOscMessage) {
  // もしOSCメッセージが
  if (theOscMessage.checkAddrPattern("kinect")==true) {   

    for (int i=0; i<14; i++) {
      body[i].x=map(theOscMessage.get(2*i).floatValue(), -640, 0, 0, width);
      body[i].y=map(theOscMessage.get(2*i+1).floatValue(), 0, 480, 0, height);
    }
  }
}
