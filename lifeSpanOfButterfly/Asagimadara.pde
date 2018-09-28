class Asagimadara extends Molfo{
  
  PImage asimg;

  Asagimadara(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    asimg=loadImage("asagimadara.png");
  }

  void display() {
    blendMode(ADD);
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    tint(int(lifeSpan*255/120));
    noStroke();
    fill(65,35,90,5*lifeSpan/60);
    for(int i=0;i<10;i++){
      ellipse(0,0,4*i,4*i);
    }
    image(asimg, 0, 0, map(noise(widthNoise),0,1,0,60), 60);
    popMatrix();
  }
  
}
