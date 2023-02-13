class Powerup {
  float x, y;
  float yv;
  char type;
  Powerup (float tx, float ty, float tyv, char ttype) {
    x = tx;
    y = ty;
    yv = tyv;
    type = ttype;
  }
  
  void display() {
    stroke(255);
    strokeWeight(2);
    switch(type) { //Heart stolen from https://happycoding.io/tutorials/processing/calling-functions/heart
      case 'H':
        fill(255, 0, 0);
        beginShape();
        curveVertex(x+15, y+60);
        curveVertex(x+15, y+27);
        curveVertex(x+3, y+15);
        curveVertex(x+7.5, y+7.5);
        curveVertex(x+15, y+10);
        curveVertex(x+15, y+30);
        endShape();
        
        beginShape();
        curveVertex(x+15, y+30);
        curveVertex(x+15, y+10);
        curveVertex(x+22.5, y+7.5);
        curveVertex(x+27, y+15);
        curveVertex(x+15, y+27);
        curveVertex(x+15, y+60);
        endShape();
        break;
      case 'T':
        fill(200);
        beginShape();
        vertex(x-3, y+8);
        vertex(x-3, y-3);
        vertex(x-7, y-3);
        vertex(x, y-10);
        vertex(x+7, y-3);
        vertex(x+3, y-3);
        vertex(x+3, y+8);
        endShape();
        break;
      case 'I':
        noFill();
        beginShape();
        vertex(x, y-10);
        vertex(x+3, y-3);
        vertex(x+9, y-3);
        vertex(x+5, y+3);
        vertex(x+6, y+8);
        vertex(x, y+5);
        vertex(x-6, y+8);
        vertex(x-5, y+3);
        vertex(x-9, y-3);
        vertex(x-3, y-3);
        vertex(x, y-10);
        endShape();
        break;
      default:
        noFill();
        circle(x, y, 20);
        line(x-7, y, x+7, y);
        line(x, y-7, x, y+7);
        break;
    }
    strokeWeight(1);
  }
  
  void move() {
    y += yv;
  }
  
  boolean reachedBottom() {
    return (y >= height+8);
  }
}
