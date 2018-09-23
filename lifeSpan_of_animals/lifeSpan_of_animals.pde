import netP5.*;
import oscP5.*;

//generate OSCP5 class of instance
OscP5 oscP5; 

ArrayList<Wave> wv=new ArrayList<Wave>();
ArrayList<Molfo> ml=new ArrayList<Molfo>();
ArrayList<Monshiro> ms=new ArrayList<Monshiro>();
ArrayList<Asagimadara>as=new ArrayList<Asagimadara>();
ArrayList<Oomurasaki>oo=new ArrayList<Oomurasaki>();
ArrayList<Ageha>ag=new ArrayList<Ageha>();

float mlSpan=30;
float msSpan=15;
float asSpan=120;
float ooSpan=60;
float agSpan=14;

PVector targetLoc;
PVector []body=new PVector[17];


void setup() {

  fullScreen(P2D);
  //size(1200, 1200, P2D);
  background(21);
  smooth();
  noCursor();
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
  for (int i=ml.size()-1; i>0; i--) {
    Molfo m=ml.get(i);
    //m.update(body[i%13]);
    m.update(body[12]);
    m.display();
    if (m.lifeSpan<0.0) {
      ml.remove(i);
    }
  }

  //モンシロチョウ
  for (int i=ms.size()-1; i>0; i--) {
    Monshiro m=ms.get(i);
    //m.update(body[i%13]);
    m.update(body[12]);
    m.display();
    if (m.lifeSpan<0.0) {
      ms.remove(i);
    }
  }

  //アサギマダラ
  for (int i=as.size()-1; i>0; i--) {
    Asagimadara a=as.get(i);
    //a.update(body[i%13]);
    a.update(body[12]);
    a.display();
    if (a.lifeSpan<0.0) {
      ms.remove(i);
    }
  }

  //オオムラサキ
  for (int i=oo.size()-1; i>0; i--) {
    Oomurasaki o=oo.get(i);
    //o.update(body[i%13]);
    o.update(body[12]);
    o.display();
    if (o.lifeSpan<0.0) {
      oo.remove(i);
    }
  }

  //アゲハ
  for (int i=ag.size()-1; i>0; i--) {
    Ageha a=ag.get(i);
    //a.update(body[i%13]);
    a.update(body[12]);
    a.display();
    if (a.lifeSpan<0.0) {
      ag.remove(i);
    }
  }

  //targetの可視化
  noStroke();
  fill(0, 100, 100, 100);
  ellipse(body[0].x,body[0].y,50,50);
  
}


void keyPressed() {

  if (key=='a'||key=='A') {
    PVector location=new PVector(random(width), random(height));
    ml.add(new Molfo(location, mlSpan, radians(random(-45, 45))));
    wv.add(new Wave(location));

    for (int i=0; i<ms.size()-1; i++) {
      ms.remove(i);
    }
    for (int i=0; i<as.size()-1; i++) {
      as.remove(i);
    }
    for (int i=0; i<oo.size()-1; i++) {
      oo.remove(i);
    }
    for (int i=0; i<ag.size()-1; i++) {
      ag.remove(i);
    }
  }
  if (key=='s'||key=='S') {
    for (int i=0; i<3; i++) {
      PVector location=new PVector(random(width), random(height));
      ms.add(new Monshiro(location, msSpan, radians(random(-45, 45))));
      wv.add(new Wave(location));
    }

    for (int i=0; i<as.size()-1; i++) {
      as.remove(i);
    }
    for (int i=0; i<ml.size()-1; i++) {
      ml.remove(i);
    }
    for (int i=0; i<oo.size()-1; i++) {
      oo.remove(i);
    }
    for (int i=0; i<ag.size()-1; i++) {
      ag.remove(i);
    }
  }
  if (key=='d'||key=='D') {
    for (int i=0; i<3; i++) {
      PVector location=new PVector(random(width), random(height));
      as.add(new Asagimadara(location, asSpan, radians(random(-45, 45))));
      wv.add(new Wave(location));
    }

    for (int i=0; i<ms.size()-1; i++) {
      ms.remove(i);
    }
    for (int i=0; i<ml.size()-1; i++) {
      ml.remove(i);
    }
    for (int i=0; i<oo.size()-1; i++) {
      oo.remove(i);
    }
    for (int i=0; i<ag.size()-1; i++) {
      ag.remove(i);
    }
  }
  if (key=='f'||key=='F') {
    for (int i=0; i<3; i++) {
      PVector location=new PVector(random(width), random(height));
      oo.add(new Oomurasaki(location, ooSpan, radians(random(-45, 45))));
      wv.add(new Wave(location));
    }
    for (int i=0; i<ms.size()-1; i++) {
      ms.remove(i);
    }
    for (int i=0; i<as.size()-1; i++) {
      as.remove(i);
    }
    for (int i=0; i<ml.size()-1; i++) {
      ml.remove(i);
    }
    for (int i=0; i<ag.size()-1; i++) {
      ag.remove(i);
    }
  }
  if (key=='g'||key=='G') {
    for (int i=0; i<3; i++) {
      PVector location=new PVector(random(width), random(height));
      ag.add(new Ageha(location, agSpan, radians(random(-45, 45))));
      wv.add(new Wave(location));
    }
    for (int i=0; i<ms.size()-1; i++) {
      ms.remove(i);
    }
    for (int i=0; i<as.size()-1; i++) {
      as.remove(i);
    }
    for (int i=0; i<ml.size()-1; i++) {
      ml.remove(i);
    }
    for (int i=0; i<oo.size()-1; i++) {
      oo.remove(i);
    }
  }
}

// OSCメッセージを受信した際に実行するイベント
void oscEvent(OscMessage theOscMessage) {
  // もしOSCメッセージが
  if (theOscMessage.checkAddrPattern("kinect")==true) {   

    for (int i=0; i<8; i++) {
      body[i].x=map(theOscMessage.get(2*i).floatValue(), 0, 640, 0, width);
      body[i].y=map(theOscMessage.get(2*i+1).floatValue(), 0, 640, 0, height);
    }
  }
}
