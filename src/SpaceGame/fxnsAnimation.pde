//STARTUP animations
float startupAnim_ShipPosition(float startSeconds, float animTime) {
  float timeElapsed = sec-startSeconds;
  if (timeElapsed > animTime) return height-100; //Animation should be over
  return (100*(timeElapsed-1.5)*(timeElapsed-2.5)) - 75 + height;
}
float startupAnim_TextAndButtonAlpha(float startSeconds, float animTime) {
  float percentElapsed = (sec-startSeconds)/animTime; //how far into the animation
  //e.g. if this is 0.5 then the animation is halway done
  if (percentElapsed > 1) return 255; //Animation should be over
  return percentElapsed*255;
}


//STARTGAME animations
float startGameAnim_ShipPosition(float startSeconds, float animTime) {
  float timeElapsed = sec-startSeconds;
  if (sec > startSeconds+animTime) return -150; //Animation should be over
  return height - 100*((5*pow(timeElapsed, 2))-(2*timeElapsed)+1);
}
float startGameAnim_TextAndButtonAlpha(float startSeconds, float animTime) {
  float percentElapsed = (sec-startSeconds)/animTime; //how far into the animation
  if (percentElapsed > 1) return 0; //Animation should be over
  return (1-percentElapsed)*255;
}


//DEATHANIM animations
float deathAnim_ShipPosition(float startSeconds, float animTime) {
  float percentElapsed = (sec-startSeconds)/animTime; //how far into the animation
  if (sec > startSeconds+animTime) return -150; //Animation should be over
  return height - 100 + 150*(percentElapsed);
}
float deathAnim_infoPanelAlpha(float startSeconds, float animTime) {
  float percentElapsed = (sec-startSeconds)/animTime; //how far into the animation
  if (percentElapsed > 1) return 0; //Animation should be over
  return (1-percentElapsed)*255;
}
int deathAnim_scoreDisplay(float startSeconds, float animTime) {
  float percentElapsed = (sec-startSeconds)/animTime; //how far into the animation
  if (percentElapsed > 1) return 0; //Animation should be over
  return int(score*(1-pow(percentElapsed-1, 4)));
}

//STARTNEWGAME animations
float startNewGameAnim_ShipPosition(float startSeconds, float animTime) {
  float timeElapsed = sec-startSeconds;
  if (sec > startSeconds+animTime) return -150; //Animation should be over
  return height - 100*((5*pow(timeElapsed, 2))-(2*timeElapsed)+1);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

//STARTUP general
void startupAnimation() {
  s.y = startupAnim_ShipPosition(0, 2);
  textAlign(CENTER);
  
  //Write title text
  fill(255, startupAnim_TextAndButtonAlpha(1, 1));
  textSize(75);
  text("Bad space", width/2, 100);
  text("invaders", width/2, 160);
  
  //Draw button borders
  noFill();
  stroke(startupAnim_TextAndButtonAlpha(2, 0.2));
  rect((width/2)-60, 190, 120, 40);
  rect((width/2)-50, 240, 100, 40);
  
  //Write button texts
  fill(startupAnim_TextAndButtonAlpha(2, 0.2));
  textSize(32);
  text("Endless", width/2, 220);
  text("Waves", width/2, 270);
  
  //Boot out of startup once the animations are done
  if (sec > 3) gameState = 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

//MENU general
void menuAnimation() {
  textAlign(CENTER);
  
  //Write title text
  fill(255);
  textSize(75);
  textAlign(CENTER);
  text("Bad space", width/2, 100);
  text("invaders", width/2, 160);
  
  //Draw button borders
  noFill();
  stroke(255);
  rect((width/2)-60, 190, 120, 40); //button coordinates, determine the logic for void mouseReleased(){}
  rect((width/2)-50, 240, 100, 40); 
  
  //Write button texts
  fill(255);
  textSize(32);
  text("Endless", width/2, 220);
  text("Waves", width/2, 270);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

//STARTGAME general
void startgameAnimation() {
  textAlign(CENTER);
  
  //Fade out the following:
    //Write title text
    fill(255, startGameAnim_TextAndButtonAlpha(animStartTime, 0.3));
    textSize(75);
    text("Bad space", width/2, 100);
    text("invaders", width/2, 160);
    
    //Draw button border
    noFill();
    stroke(255, startGameAnim_TextAndButtonAlpha(animStartTime, 0.3));
    rect((width/2)-60, 190, 120, 40);
    rect((width/2)-50, 240, 100, 40);
    
    //Write button text
    fill(255, startGameAnim_TextAndButtonAlpha(animStartTime, 0.3));
    textSize(32);
    text("Endless", width/2, 220);
    text("Waves", width/2, 270);
  //Move the spaceship to the top of the screen
  s.y = startGameAnim_ShipPosition(animStartTime, 2);
  
  //Once the ship is gone, move it back to the bottom and do the same animation as startupAnim_ShipPosition
  if (sec-animStartTime > 2) s.y = startupAnim_ShipPosition(animStartTime+2, 2);
  
  //Boot out of startgame once the animations are done
  if (sec-animStartTime > 4) {
    gameState = 2;
    if (gameMode == 1) {
      loadWaveInfo(wave);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

//DEATHANIM general
void deathAnimAnimation() {
  for (int i=rocks.size()-1; i>=0; i--) {
    Rock r = rocks.get(i);
    if (r.y < 30) rocks.remove(i);
    else r.speed *= 1.02;
  }
  s.y = deathAnim_ShipPosition(animStartTime, 2);
  
  textAlign(CENTER);
  fill(255);
  textSize(100);
  if (sec-animStartTime > 3) text("Final Score", width/2, 100);
  if (sec-animStartTime > 4 && sec-animStartTime < 6) text(deathAnim_scoreDisplay(animStartTime+4, 2), width/2, 180);
  if (sec-animStartTime > 6) text(score, width/2, 180);
  if (sec-animStartTime > 5) {
    //Draw button border
    noFill();
    stroke(255);
    rectMode(CENTER);
    rect((width/2), 230, 140, 40);
    rectMode(CORNER);
    
    //Write button text
    fill(255);
    textSize(32);
    text("Play Again", width/2, 240);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

//STARTNEWGAME general
void startNewGameAnimation() {
  textAlign(CENTER);
  
  //Note: most of the fadeout rate is the same as in startGameAnim
  //Fade out the following:
    //Write title text
    fill(255, startGameAnim_TextAndButtonAlpha(animStartTime, 0.3));
    textSize(75);
    text("Final Score", width/2, 100);
    text(score, width/2, 180);
    
    //Draw button border
    noFill();
    stroke(255, startGameAnim_TextAndButtonAlpha(animStartTime, 0.3));
    rectMode(CENTER);
    rect((width/2), 230, 150, 40);
    rectMode(CORNER);
    
    //Write button text
    fill(255, startGameAnim_TextAndButtonAlpha(animStartTime, 0.3));
    textSize(32);
    text("Play Again", width/2, 240);
  if (sec-animStartTime > 2) s.y = startupAnim_ShipPosition(animStartTime+2, 2);
  
  //Boot out of startgame once the animations are done
  if (sec-animStartTime > 4) {
    score = 0;
    s.health = 5;
    difficulty = 3;
    gameState = 2;
  }
}
