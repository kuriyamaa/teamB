class Mendako extends Butterfly {
  
  PImage mdimg;

  Mendako(PVector _location, float _lifeSpan) {
    super(_location, _lifeSpan);
    mdimg=loadImage("tako.jpg");
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    tint(int(lifeSpan*255/50));
    image(mdimg, 0, 0, 30, 30);
    popMatrix();
  }
}
