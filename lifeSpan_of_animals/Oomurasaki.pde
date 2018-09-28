class Oomurasaki extends Molfo{
  
  PImage ooimg;

  Oomurasaki(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    ooimg=loadImage("oomurasaki.png");
  }

  void display() {
    blendMode(ADD);
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    tint(int(lifeSpan*255/60));
    noStroke();
    fill(275,95,75,5*lifeSpan/60);
    for(int i=0;i<16;i++){
      ellipse(0,0,4*i,4*i);
    }
    image(ooimg, 0, 0, map(noise(widthNoise),0,1,0,50), 50);
    popMatrix();
  }
  
}
