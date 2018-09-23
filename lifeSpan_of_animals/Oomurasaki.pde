class Oomurasaki extends Molfo{
  
  PImage ooimg;

  Oomurasaki(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    ooimg=loadImage("oomurasaki.png");
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    tint(int(lifeSpan*255/50));
    image(ooimg, 0, 0, map(noise(widthNoise),0,1,0,50), 50);
    image(ooimg, 0, 0, map(noise(widthNoise),0,1,0,50), 50);
    popMatrix();
  }
  
}
