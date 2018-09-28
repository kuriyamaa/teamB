class Molfo {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifeSpan;
  float mass=1;
  PImage bfimg;
  PVector noise;
  float ynoise=0;
  float widthNoise=0;
  PVector target;
  float theta;

  Molfo(PVector _location, float _lifeSpan, float _theta) {
    theta=_theta;
    location=_location.get();
    lifeSpan=_lifeSpan;
    velocity=new PVector();
    acceleration=new PVector(0, 0);
    bfimg=loadImage("molfo.png");
  }


  void update(PVector _target) {
    target=_target;
    velocity=new PVector(target.x-location.x, target.y-location.y); 
    velocity.normalize();
    velocity.mult(3);
    velocity.add(acceleration);
    noise=new PVector(0, map(noise(ynoise), 0, 1, -5, 5));
    velocity.y+=noise.y;
    location.add(velocity);
    acceleration.mult(0);
    lifeSpan-=0.1;
    ynoise+=0.07;
    widthNoise+=0.5;
  }

  void display() {
    blendMode(ADD);
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    tint(int(lifeSpan*255/30));
    noStroke();
    fill(208,100,100,15*lifeSpan/60);
    for(int i=0;i<18;i++){
      ellipse(0,0,7*i,7*i);
    }
    image(bfimg, 0, 0, map(noise(widthNoise), 0, 1, 0, 150), 150);
    popMatrix();
  }

  boolean isDead() {
    if (lifeSpan<0.0) {
      return true;
    } else {
      return false;
    }
  }
}
