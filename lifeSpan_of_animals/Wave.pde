class Wave {
  float diam;
  PVector center;
  float lifeSpan=225;

  Wave(PVector _center) {
    diam=0;
    center=_center.get();
  }

  void run() {
    update();
    display();
  }

  void update() {
    diam+=2; 
    lifeSpan-=1;
  }

  void display() {
    noFill();
    stroke(0, 0, 100, lifeSpan);
    ellipse(center.x, center.y, diam, diam);
  }

  boolean isDead() {
    if (lifeSpan<0.0) {
      return true;
    } else {
      return false;
    }
  }
}
