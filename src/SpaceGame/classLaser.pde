class Laser {
  float s;
  PVector pos;
  Laser(float ts, PVector tpos) {
    s = ts;
    pos = tpos;
  }
  
  void display() {
    push();
    stroke(255, 0, 0, 127);
    strokeWeight(2);
    fill(255, 0, 0);
    rect(pos.x-2.5, pos.y-6, 5, 12);
    pop();
  }
  
  void move() {
    pos.y -= s;
  }
}
