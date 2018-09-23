class Asagimadara extends Molfo{
  
  PImage asimg;

  Asagimadara(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    asimg=loadImage("asagimadara.png");
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    tint(int(lifeSpan*255/50));
    image(asimg, 0, 0, map(noise(widthNoise),0,1,0,60), 60);
    image(asimg, 0, 0, map(noise(widthNoise),0,1,0,60), 60);
    popMatrix();
  }
  
}
