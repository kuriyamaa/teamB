class Monshiro extends Molfo {
  
  PImage msimg;

  Monshiro(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    msimg=loadImage("monshiro.png");
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    tint(int(lifeSpan*255/50));
    image(msimg, 0, 0, map(noise(widthNoise),0,1,0,40), 40);
    image(msimg, 0, 0, map(noise(widthNoise),0,1,0,40), 40);
    popMatrix();
  }
}
