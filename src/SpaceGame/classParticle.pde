class Particle {
  float xp, yp;
  float xv, yv;
  color c;
  Particle(float txp, float typ, float txv, float tyv, color tc) {
    xp = txp;
    yp = typ;
    xv = txv;
    yv = tyv;
    c = tc;
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(xp, yp, 6, 6);
  }
  
  void move() {
    xp += xv;
    yp += yv;
  }
}
