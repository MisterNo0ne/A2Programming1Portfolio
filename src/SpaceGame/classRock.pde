class Rock {
  float x, y;
  float diam;
  float speed;
  PImage img;
  Rock(float tx, float ty, float tdiam, float tspeed) {
    x = tx;
    y = ty;
    diam = tdiam;
    speed = tspeed;
    img = loadImage("SpaceshipGame_Rock.png");
  }
  
  void display() {
    //push();
    //stroke(66);
    //strokeWeight(3);
    //fill(94);
    //ellipse(x, y, diam, diam);
    //pop();
    image(img, x-(diam/2), y-(diam/2), diam, diam);
  }
  
  void move() {
    y += speed;
  }
  
  boolean reachedBottom() {
    return (y >= height+diam);
  }
}
