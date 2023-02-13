// Micah Tien | Oct 12 2022 | ScreenSaver
// A program to create the 'pipes' screensaver.

float xpos, ypos, strokeW, pointCount;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  xpos = width/2;
  ypos = height/2;
}

void draw() {
  strokeW = random(2, 5);
  pointCount = random(10, 20);
  stroke(255, random(40, 230), random(40, 230));
  strokeWeight(strokeW);
  int dir = floor(random(0, 4));
  if (dir == 0) {
    moveUp(xpos, ypos, pointCount);
  } else if (dir == 1) {
    moveDown(xpos, ypos, pointCount);
  } else if (dir == 2) {
    moveRight(xpos, ypos, pointCount);
  } else {
    moveLeft(xpos, ypos, pointCount);
  }
  if (xpos < 0 || xpos > width || ypos < 0 || ypos > height) {
    xpos = random(width);
    ypos = random(height);
  }
}

void moveRight(float sx, float sy, float mc) {
  for (int i=0; i<mc; i++) {
    point(sx+i, sy);
    xpos = sx+i;
  }
}
void moveDown(float sx, float sy, float mc) {
  for (int i=0; i<mc; i++) {
    point(sx, sy+i);
    ypos = sy+i;
  }
}
void moveLeft(float sx, float sy, float mc) {
  for (int i=0; i<mc; i++) {
    point(sx-i, sy);
    xpos = sx-i;
  }
}
void moveUp(float sx, float sy, float mc) {
  for (int i=0; i<mc; i++) {
    point(sx, sy-i);
    ypos = sy-i;
  }
}
