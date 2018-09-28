class Ageha extends Molfo {

  PImage agimg;

  Ageha(PVector _location, float _lifeSpan, float _theta) {
    super(_location, _lifeSpan, _theta);
    agimg=loadImage("ageha.png");
  }

  void display() {
    blendMode(ADD);
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    tint(int(lifeSpan*255/14));
    noStroke();
    fill(60,85,100,10*lifeSpan/60);
    for(int i=0;i<16;i++){
      ellipse(0,0,4*i,4*i);
    }
    image(agimg, 0, 0, map(noise(widthNoise), 0, 1, 0, 60), 60);
    popMatrix();
  }
}
