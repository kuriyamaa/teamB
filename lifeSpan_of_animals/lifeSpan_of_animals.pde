import netP5.*;
import oscP5.*;

//generate OSCP5 class of instance
OscP5 oscP5; 

ArrayList<Wave> wv=new ArrayList<Wave>();
ArrayList<Butterfly> bf=new ArrayList<Butterfly>();
ArrayList<Monshiro> ms=new ArrayList<Monshiro>();

float bfSpan=30;
float msSpan=40;

PVector targetLoc;
PVector []body=new PVector[17];


void setup() {

  //fullScreen(P2D);
  size(1200, 1200, P2D);
  background(21);
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  frameRate(30);


  // ポートを12000に設定して新規にOSCP5のインスタンスを生成する
  oscP5 = new OscP5(this, 12000);

  targetLoc=new PVector(width/2, height/2);

  
  for (int i=0; i<body.length; i++) {
    body[i]=new PVector(width/2, height/2, radians(random(-45, 45)));
  }
}

void draw() {

  background(21);

  //ganerate wave
  for (int i=wv.size()-1; i>0; i--) {
    Wave w=wv.get(i); 
    w.run();
    if (w.isDead()) {
      wv.remove(i);
    }
  }

  //モルフォチョウ
  for (int i=bf.size()-1; i>0; i--) {
    Butterfly b=bf.get(i);
    b.update(body[i%13]);
    //b.update(body[12]);
    b.display();
    if (b.lifeSpan<0.0) {
      bf.remove(i);
    }
  }

  //モンシロチョウ
  for (int i=ms.size()-1; i>0; i--) {
    Monshiro m=ms.get(i);
    m.update(body[i%13]);
    m.display();
    if (m.lifeSpan<0.0) {
      ms.remove(i);
    }
  }

  //targetの可視化
  noStroke();
  fill(0, 100, 100, 100);
  for (int i=0; i<13; i++) {
    ellipse(body[i].x, body[i].y, 5, 5);
  }
}


void keyPressed() {

  if (key=='a'||key=='A') {
    PVector location=new PVector(random(width), random(height));
    bf.add(new Butterfly(location, bfSpan,radians(random(-45,45))));
    wv.add(new Wave(location));
    for(int i=0;i<ms.size();i++){
       ms.remove(i); 
    }
  }
  if (key=='s'||key=='S') {
    PVector location=new PVector(random(width), random(height));
    ms.add(new Monshiro(location, msSpan,radians(random(-45,45))));
    wv.add(new Wave(location));
    for(int i=0;i<bf.size();i++){
       bf.remove(i); 
    }
  }
}

// OSCメッセージを受信した際に実行するイベント
void oscEvent(OscMessage theOscMessage) {
  // もしOSCメッセージが
  if (theOscMessage.checkAddrPattern("kinect")==true) {   

    for (int i=0; i<13; i++) {
      body[i].x=map(theOscMessage.get(2*i).floatValue(), 0, 640, 0, width);
      body[i].y=map(theOscMessage.get(2*i+1).floatValue(), 0, 640, 0, height);
    }
  //println(body[12]);

    // 最初の値をint型としてX座標にする
    //targetLoc.x = map(theOscMessage.get(2).intValue(),0,640,0,width);
    // 次の値をint型としてY座標にする
    //targetLoc.y = map(theOscMessage.get(3).intValue(),0,480,0,height);
  }
}
