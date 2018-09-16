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

  Butterfly(PVector _location, float _lifeSpan) {
    location=_location.get();
    lifeSpan=_lifeSpan;
    velocity=new PVector();
    acceleration=new PVector(0, 0);
    bfimg=loadImage("butterfly.png");
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity=new PVector(mouseX-location.x, mouseY-location.y); 
    velocity.normalize();
    velocity.mult(3);
    velocity.add(acceleration);
    noise=new PVector(0,map(noise(ynoise),0,1,-15,15));
    //velocity.add(noise);
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
    image(bfimg, 0, 0, map(noise(widthNoise),0,1,0,60), 40);
    popMatrix();
  }

  boolean isDead() {
    if (lifeSpan<0.0) {
      return true;
    } else {
      return false;
    }
  }

  void applyForce(PVector _force) {
    PVector force=_force.get();
    force.div(mass);
    acceleration.add(force);
  }
}
