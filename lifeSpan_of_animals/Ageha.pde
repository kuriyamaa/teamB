class Ageha extends Molfo{
  
  PImage agimg;

  Ageha(PVector _location, float _lifeSpan,float _theta) {
    super(_location, _lifeSpan,_theta);
    agimg=loadImage("oomurasaki.png");
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    tint(int(lifeSpan*255/50));
    image(agimg, 0, 0, map(noise(widthNoise),0,1,0,60), 60);
    image(agimg, 0, 0, map(noise(widthNoise),0,1,0,60), 60);
    popMatrix();
  }
  
}
