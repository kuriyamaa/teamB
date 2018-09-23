class Butterfly {
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

  Butterfly(PVector _location, float _lifeSpan, float _theta) {
    theta=_theta;
    location=_location.get();
    lifeSpan=_lifeSpan;
    velocity=new PVector();
    acceleration=new PVector(0, 0);
    bfimg=loadImage("butterfly.png");
  }


  void update(PVector _target) {
    target=_target;
    println(target);
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
    widthNoise+=0.1;
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    image(bfimg, 0, 0, map(noise(widthNoise), 0, 1, 0, 60), 40);
    image(bfimg, 0, 0, map(noise(widthNoise), 0, 1, 0, 60), 40);
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
