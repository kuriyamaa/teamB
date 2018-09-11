class Butterfly {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifeSpan;
  float mass=1;
  PImage bfimg;

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
    velocity.mult(10);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifeSpan-=1;
  }

  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    tint(int(lifeSpan*255/40));
    image(bfimg, 0, 0, 30, 20);
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
