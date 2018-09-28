class Petal {

  PVector location;
  PVector vec;
  PVector accel;
  float mass;

  PImage ptImg;

  Petal(PVector loc, int n,float m) {
    mass=m;
    ptImg=loadImage("hanabira"+n+".png"); 
    location=loc.get();
    vec=new PVector();
    accel=new PVector(0, 0);
  }

  void update() {
    vec=new PVector(0, 0);
    vec.add(accel);
    location.add(vec);
    accel.mult(0);
  }

  void display() {
    blendMode(ADD);
    imageMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    image(ptImg, 0, 0, 25*mass, 25*mass);
    image(ptImg, 0, 0, 25*mass, 25*mass);
    popMatrix();
  }
  
  void addForce(PVector force) {
    //PVector f=force.getで値を持ってきてもいい
    PVector f=PVector.div(force, mass); 
    accel.add(f);
  }

  boolean isDead() {
    if (location.y>=height) {
      return true;
    } else {
      return false;
    }
  }
}
