import netP5.*;
import oscP5.*;

//generate OSCP5 class of instance
OscP5 oscP5; 
NetAddress myRemoteLocation;

ArrayList<Wave> wv=new ArrayList<Wave>();
ArrayList<Butterfly> bf=new ArrayList<Butterfly>();
ArrayList<Monshiro> ms=new ArrayList<Monshiro>();

float bfSpan=30;
float msSpan=40;

PVector targetLoc;


void setup() {

  //fullScreen(P2D);
  size(800, 800, P2D);
  background(21);
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  frameRate(30);


  // ポートを12000に設定して新規にOSCP5のインスタンスを生成する
  oscP5 = new OscP5(this, 7400);
  myRemoteLocation = new NetAddress("127.0.01", 7400);

  /* 受信用の変数。右の数字はポート番号。送信側のポート番号とあわせる。 */
  oscP5.plug(this, "onRecieve", "/trigger");

  targetLoc=new PVector(width/2, height/2);
}

void draw() {

  //targetLoc=new PVector(mouseX, mouseY);

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
  }

  //モンシロチョウ
  for (int i=ms.size()-1; i>0; i--) {
    Monshiro m=ms.get(i);
    m.run();
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

//function receive message from kinect
//〜.plugで指定したtestという名前を持つ関数 
public void onRecieve(float x, float y) {// int theAにデータの値を受ける
  println("### plug event method. received a message /trigger");
  //println("received: "+num);//theAを画面に出力する
  targetLoc.x=x;
  targetLoc.y=y;
  println(targetLoc);
}
