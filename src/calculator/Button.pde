class Button {
  float x, y;
  float w, h;
  char c;
  
  Button (float tx, float ty, float tw, float th, char tc) {
    x = tx;
    y = ty;
    w = tw;
    h = th;
    c = tc;
  }
  
  void display() {
    if (mouseIn(x, y, w, h)) {
      fill ((mousePressed) ? 40 : 120);
    } else {
      fill (80);
    }
    rect(x, y, w, h, 5);
    fill(255);
    String t = str(c);
    if (c == 's') {
      t = "sin";
    } else if (c == 'c') {
      t = "cos";
    } else if (c == 'd') {
      textSize(15);
      text("Degrees / Radians", x+(w/2), y+(h/2)+4);
      t = "";
    }
    text(t, x+(w/2), y+(h/2)+10);
  }
}
