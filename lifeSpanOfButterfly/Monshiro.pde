class Monshiro extends Molfo {
  
  PImage msimg;

  Monshiro(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    msimg=loadImage("monshiro.png");
  }

  void display() {
    blendMode(ADD);
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    tint(int(lifeSpan*255/15));
    noStroke();
    fill(60,20,100,10*lifeSpan/60);
    for(int i=0;i<8;i++){
      ellipse(0,0,8*i,8*i);
    }
    image(msimg, 0, 0, map(noise(widthNoise),0,1,0,40), 40);
    popMatrix();
  }
}
