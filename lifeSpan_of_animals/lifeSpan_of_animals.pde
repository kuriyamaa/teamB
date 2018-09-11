ArrayList<Wave> wv=new ArrayList<Wave>();
ArrayList<Butterfly> bf=new ArrayList<Butterfly>();
ArrayList<Mendako> md=new ArrayList<Mendako>();

int bfNum=10;
float bfSpan=40;
float mdSpan=50;


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

  //targetの可視化
  noStroke();
  fill(0, 100, 100, 100);
  ellipse(mouseX, mouseY, 30, 30);

  //波の部分
  for (int i=wv.size()-1; i>0; i--) {
    Wave w=wv.get(i); 
    w.run();
    if (w.isDead()) {
      wv.remove(i);
    }
  }

  //蝶の部分
  for (int i=bf.size()-1; i>0; i--) {
    Butterfly b=bf.get(i);
    b.run();
    if (b.lifeSpan<0.0) {
      bf.remove(i);
    }
  }

  //メンダコの部分
  for (int i=md.size()-1; i>0; i--) {
    Mendako m=md.get(i);
    m.run();
    if (m.lifeSpan<0.0) {
      md.remove(i);
    }
  }
}

void keyPressed() {
  PVector location=new PVector(random(width), random(height));
  wv.add(new Wave(location));
  if (key=='a'||key=='A') {
    bf.add(new Butterfly(location, bfSpan));
  }
  if (key=='s'||key=='S') {
    md.add(new Mendako(location, mdSpan));
  }
}
