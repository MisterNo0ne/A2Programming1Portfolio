Star randStar() { //randomize star position for initialization and resetting
  return new Star(int(random(width)), int(random(-height, 0)), random(1, 2));
}

boolean mouseIn(float x, float y, float w, float h) {
  return (mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h);
}

void infoPanel(int yChange) {
  noStroke();
  fill(129, 128);
  rectMode(CENTER);
  rect(width/2, 25+yChange, width, 50+yChange);
  fill(255);
  textSize(35);
  textAlign(LEFT);
  if (gameMode == 0) {
    text("Score : " + score +
    " | Health : " + s.health +
    " | Difficulty : " + difficulty
    , 20, 40+yChange);
  } else if (gameMode == 1) {
    text( " Hit : " + rocksShot +
    " | Health : " + s.health +
    " | Wave : " + wave
    , 20, 40+yChange);
  }
}

//void setupRockWave() {
//  for (int i=0; i<rockMapped.length; i++) {
//    if (rockMapped[i]) rocks.add(new Rock(50*((i%rockmap.width)+1), (50)*((i/rockmap.width)-rockmap.height), 32, 5));
//  }
//}

void loadWaveInfo(int lvl) {
  rockTimer = new Timer(waveDatas[lvl].sendSpeed * 1000);
  rocksLeft = waveDatas[wave].rocks;
}
