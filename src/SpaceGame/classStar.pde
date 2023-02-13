class Star {
  int x, y;
  float invz;
  Star(int tx, int ty, float tinvz) {
    x = tx;
    y = ty;
    invz = tinvz; //the 'z' axis is how far away the star is in the background
    //a bigger 'z' value should mean lower size and lower speed
    //invz is the inverse of z, so invs, size, and speed are all proportional
    
    //The ratio of invz to size to speed is 1:5:3
  }
  
  void display() {
    fill(242, 201, 36);
    noStroke();
    circle(x, y, 3);
  }
  
  void move() {
    y += invz*3;
  }
  
  boolean reachedBottom() {
    return (y >= height+(invz*4));
  }
}
