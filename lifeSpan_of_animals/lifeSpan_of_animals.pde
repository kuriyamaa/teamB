ArrayList<Wave> wv=new ArrayList<Wave>();
ArrayList<Butterfly> bf=new ArrayList<Butterfly>();
ArrayList<Monshiro> ms=new ArrayList<Monshiro>();

int bfNum=3;
float bfSpan=30;
float msSpan=40;


void setup() {
  fullScreen(P2D);
  background(21);
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  frameRate(30);
}

void draw() {
  background(21);

  //波の部分
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
  ellipse(mouseX, mouseY, 30, 30);
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
