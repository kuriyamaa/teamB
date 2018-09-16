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


void setup() {
  
  //fullScreen(P2D);
  size(800,800,P2D);
  background(21);
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  frameRate(30);
  
  targetLoc=new PVector(width/2,height/2);
  
  // ポートを12000に設定して新規にOSCP5のインスタンスを生成する
  oscP5 = new OscP5(this, 773);
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
    b.run();
    if (b.lifeSpan<0.0) {
      bf.remove(i);
    }
  }

  //モンシロチョウ
  for (int i=ms.size()-1; i>0; i--) {
    Monshiro m=ms.get(i);
    m.run();
    if (m.lifeSpan<0.0) {
      ms.remove(i);
    }
  }

  //targetの可視化
  noStroke();
  fill(0, 100, 100, 100);
  ellipse(targetLoc.x, targetLoc.y, 30, 30);
}


void keyPressed() {

  if (key=='a'||key=='A') {
    PVector location=new PVector(random(width), random(height));
    bf.add(new Butterfly(location, bfSpan));
    wv.add(new Wave(location));
  }
  if (key=='s'||key=='S') {
    PVector location=new PVector(random(width), random(height));
    ms.add(new Monshiro(location, msSpan));
    wv.add(new Wave(location));
  }
}

// OSCメッセージを受信した際に実行するイベント
void oscEvent(OscMessage theOscMessage) {
  // もしOSCメッセージが /mouse/position だったら
  if (theOscMessage.checkAddrPattern("/kinect/location")==true) {   
    // 最初の値をint型としてX座標にする
    targetLoc.x = theOscMessage.get(0).intValue();
    // 次の値をint型としてY座標にする
    targetLoc.y = theOscMessage.get(1).intValue();
  }
}
