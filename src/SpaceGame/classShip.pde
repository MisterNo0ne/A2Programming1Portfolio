class Ship {
  float x, y;
  boolean epic;
  int health;
  Timer invulnTimer;
  int turrets;
  boolean hit;
  Ship(boolean tepic, float tx, float ty, Timer tinvulnTimer, int tturrets) {
    epic = tepic;
    x = tx;
    y = ty;
    health = 5;
    invulnTimer = tinvulnTimer;
    invulnTimer.savedTime = -(invulnTimer.totalTime+20);
    turrets = tturrets;
    hit = false;
  }
  
  void drawShip() {
    //if we're flashing from invulnerability, we should change opacity to 100
    //if not then opacity should stay at 255
    int flashingOpacity = 255;
    if (!invulnTimer.isFinished()) {
      float timePassed = (millis() - invulnTimer.savedTime);
      if (timePassed/invulnTimer.totalTime < 0.7) {
        if (timePassed%400 < 200) {
          flashingOpacity = 100;
        }
      } else {
        if (timePassed%150 < 75) {
          flashingOpacity = 100;
        }
      }
    }
    
    fill(230, 244, 255, flashingOpacity);
    stroke(0);
    beginShape();
    vertex(x+7, y-10);
    vertex(x+7, y-19);
    vertex(x+10, y-19);
    vertex(x+10, y-26);
    vertex(x+7, y-26);
    vertex(x+7, y-45);
    vertex(x+15, y-37);
    vertex(x+25, y-34);
    vertex(x+25, y-10);
    vertex(x+50, y+30);
    vertex(x+20, y+30);
    vertex(x+20, y+12);
    vertex(x-20, y+12);
    vertex(x-20, y+30);
    vertex(x-50, y+30);
    vertex(x-25, y-10);
    vertex(x-25, y-34);
    vertex(x-15, y-37);
    vertex(x-7, y-45);
    vertex(x-7, y-26);
    vertex(x-10, y-26);
    vertex(x-10, y-19);
    vertex(x-7, y-19);
    vertex(x-7, y-10);
    endShape(CLOSE);
    fill(178, 191, 182, flashingOpacity);
    noStroke();
    arc(x, y+36, 62, 62, PI+0.3, TWO_PI-0.3);
    beginShape();
    vertex(x-49, y+30);
    vertex(x-42, y+20);
    vertex(x-20, y+20);
    vertex(x-20, y+30);
    endShape(CLOSE);
    beginShape();
    vertex(x+49, y+30);
    vertex(x+43, y+20);
    vertex(x+20, y+20);
    vertex(x+20, y+30);
    endShape(CLOSE);
    stroke(0);
    arc(x, y+36, 62, 62, PI+0.54, TWO_PI-0.54);
    line(x-43, y+20, x-27, y+20);
    line(x+43, y+20, x+27, y+20);
    fill(0);                       //Change this based on the background, e.g. if background is black, set to 0
    arc(x, y+36, 42, 42, PI+0.25, TWO_PI-0.25);
    fill(255, flashingOpacity);
    ellipse(x, y+5, 12, 12);
    fill(0);
    ellipse(x, y+5, 4, 4);
    
    //Hitbox
    //fill(0, 255, 0, 100);
    //ellipse(x, y, 80, 80);
  }
  
  boolean hitRock(Rock rockCheck) {
    return (dist(x, y, rockCheck.x, rockCheck.y) < 40+(rockCheck.diam/2));
  }
  
  boolean hitPowerup(Powerup powerupCheck) {
    return (dist(x, y, powerupCheck.x, powerupCheck.y) < 48);
  }
  
  void invulnDamage() {
    //When hit, the ship should move a little for more game feel
    float timeSpentInvuln = millis() - invulnTimer.savedTime;
    float fractionOfInvulnSpent = timeSpentInvuln/invulnTimer.totalTime;
    y = (12.5/(fractionOfInvulnSpent+0.25))+790;
  }
}
