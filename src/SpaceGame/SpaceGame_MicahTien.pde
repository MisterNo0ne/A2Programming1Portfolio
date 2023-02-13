//Micah Tien | Nov 28 2022 | Space Game
//A fun game set in space

import processing.sound.*;

SoundFile pew;
SoundFile wahwah;
SoundFile wham;
Ship s;
Star[] stars;
ArrayList<Laser> lasers;
ArrayList<Rock> rocks;
ArrayList<Powerup> powerups;
Timer rockTimer;
int score, wave;
int gameState;
int gameMode;
int rocksLeft;
int rocksShot;
float sec;
float animStartTime;
float difficulty; //only for endless
WaveData[] waveDatas;

void setup() {
  size(600, 900);

  //initialize sounds
  pew = new SoundFile(this, "converted_B28LJAU-laser-blast.wav");
  wahwah = new SoundFile(this, "mixkit-spinning-electric-machine-2646.wav");
  wham = new SoundFile(this, "converted_wham_SpaceGame.wav");

  //initialize gamestate values
  score = 0;
  wave = 0;
  gameState = 3; //0 is the menu, 1 is startNewgame, 2 is playing, 3 is startup, 4 is startgame, 5 is deathanim
  gameMode = 0;  //0 is endless, 1 is waves
  difficulty = 3;

  sec = 0;
  animStartTime = 0;
  waveDatas = new WaveData[8];
  waveDatas[0] = new WaveData(10, 2, 200, 95, 105);   //10b, 2mph - 2rps
  waveDatas[1] = new WaveData(15, 1.8, 300, 95, 105); //15b, 3mph - 1.8rps
  waveDatas[2] = new WaveData(25, 1.5, 350, 95, 105);
  waveDatas[3] = new WaveData(15, 1.5, 300, 75, 85);
  waveDatas[4] = new WaveData(50, 5, 150, 95, 105);
  waveDatas[5] = new WaveData(15, 1, 200, 45, 55);
  waveDatas[6] = new WaveData(25, 1, 200, 45, 55);
  waveDatas[7] = new WaveData(100, 3, 400, 95, 105);
  rocksLeft = waveDatas[wave].rocks;
  rocksShot = 0;

  //initialize ship, lasers, stars, rocks, and rockTimer
  s = new Ship(true, width/2, 800, new Timer(2500), 1);
  lasers = new ArrayList<Laser>();
  rocks = new ArrayList<Rock>();
  powerups = new ArrayList<Powerup>();
  stars = new Star[50];
  for (int i=0; i<stars.length; i++) {
    stars[i] = randStar();
  }
  rockTimer = new Timer(1000);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
  background(0);
  //Loop over stars
  for (int i=0; i<stars.length; i++) {
    stars[i].display();
    stars[i].move();
    if (stars[i].reachedBottom()) stars[i] = randStar();
  }

  //Loop over lasers
  for (int i=lasers.size()-1; i>=0; i--) {
    Laser l1 = lasers.get(i);
    l1.display();
    l1.move();
    if (l1.pos.y<-10) lasers.remove(i);
  }

  //Add rocks
  if (gameState == 2 && rockTimer.isFinished()) {
    if (gameMode == 0) {
      float rockMomentum = 50 * difficulty;
      float rockSize = random(30, 60);
      float rockSpeed = rockMomentum / rockSize;
      rocks.add(new Rock(random(width-rockSize), random(-200, -50), rockSize, rockSpeed));
      rockTimer.start();
    } else if (gameMode == 1) {
      if (rocksLeft >= 0) {
        float rockMomentum = waveDatas[wave].momentum;
        float rockSize = random(waveDatas[wave].sizeLowerBound, waveDatas[wave].sizeHigherBound);
        float rockSpeed = rockMomentum / rockSize;
        rocks.add(new Rock(random(width-rockSize), random(-200, -50), rockSize, rockSpeed));
        rockTimer.start();
        rocksLeft--;
      }
    }
  }
  //Loop over rocks
  boolean[] rocksToDelete = new boolean[rocks.size()];
  for (int j=0; j<rocksToDelete.length; j++) {
    rocksToDelete[j] = false;
  }
  for (int i=rocks.size()-1; i>=0; i--) {
    Rock r1 = rocks.get(i);

    //Perform rock functions
    r1.display();
    if (gameState == 2 || gameState == 5) r1.move();
    if (r1.reachedBottom()) {
      //The rock has hit the bottom
      //send it back to the top with even more speed, unless we died
      if (gameState != 5) {
        r1.y -= 2*height;
        if (r1.speed < 10) r1.speed *= 1.2;
        else r1.speed = 10;
      } else {
        rocksToDelete[i] = true;
      }
    }

    //Check for collision with lasers
    for (int j=lasers.size()-1; j>=0; j--) {
      Laser l1 = lasers.get(j);
      if (dist(r1.x, r1.y, l1.pos.x, l1.pos.y) < r1.diam/2) {
        //This rock has hit a laser!
        rocksToDelete[i] = true;
        lasers.remove(j);
        score++;
        if (gameMode == 0) difficulty *= 1.03;
        if (difficulty > 15) difficulty = 15;
        if (gameMode == 1) rocksShot++;
        if (rocksShot >= waveDatas[wave].rocks) {
          rocksShot = 0;
          wave++;
          loadWaveInfo(wave);
        }
        rockTimer.totalTime = 1000*(0.5 + (0.5/difficulty));
        if (int(random(5)) == 0) { //only give a powerup 1/5 of the time
          float randomPowerupVal;              //determines what type of powerup is given
          float turretChance = 1/s.turrets;      //chance of turret powerup, goes down with more turrets
          float healthChance = 1 + (1/s.health); //chance of health powerup, goes down with more health
          float invulnChance = 1;                //chance of invulnerability powerup
          float scoreChance = 2;                 //chance of score powerup
          randomPowerupVal = random(turretChance+healthChance+invulnChance+scoreChance);
          if (randomPowerupVal < turretChance) powerups.add(new Powerup(r1.x, r1.y, r1.speed/2, 'T'));
          else if (randomPowerupVal < turretChance+healthChance) powerups.add(new Powerup(r1.x, r1.y, r1.speed/2, 'H'));
          else if (randomPowerupVal < turretChance+healthChance+invulnChance) powerups.add(new Powerup(r1.x, r1.y, r1.speed/2, 'I'));
          else powerups.add(new Powerup(r1.x, r1.y, r1.speed/2, 'S'));
        }
      }
    }

    //Check for collision with ship
    if (s.hitRock(r1) && s.invulnTimer.isFinished()) {
      //The ship has his this rock!
      s.health--;
      s.invulnTimer.start();
      s.hit = true;
      rocksToDelete[i] = true;
      if (s.health == 0) { //Spaceship is dead!
        animStartTime = sec;
        gameState = 5;
        wahwah.play();
        wahwah.amp(0.01);
      } else {
        wham.play();
        wham.amp(0.01); //wayy too loud normally
      }
    }
  }
  for (int i=rocksToDelete.length-1; i>=0; i--) {
    if (rocksToDelete[i]) rocks.remove(i);
  }

  //Loop over powerups
  for (int i=powerups.size()-1; i>=0; i--) {
    Powerup pu = powerups.get(i);
    pu.display();
    pu.move();
    if (s.hitPowerup(pu)) {
      //Spaceship has picked up a powerup!
      if (pu.type == 'H') s.health++;
      if (pu.type == 'T') s.turrets++;
      if (pu.type == 'I') s.invulnTimer.start();
      if (pu.type == 'S') score += 2;
      powerups.remove(i);
    }
    if (pu.reachedBottom()) powerups.remove(i);
  }

  if (gameState == 2) {
    s.x = mouseX;
    if (s.hit) {
      if (s.invulnTimer.isFinished()) s.hit = false; //not hit anymore
      else s.invulnDamage(); //move the ship
    }
    infoPanel(0);
  }
  s.drawShip();

  sec = float(millis())/1000;

  if (gameState == 0) menuAnimation();
  if (gameState == 1) startNewGameAnimation();
  if (gameState == 3) startupAnimation();
  if (gameState == 4) startgameAnimation();
  if (gameState == 5) deathAnimAnimation();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void mouseReleased() {
  if (gameState == 2) {
    for (int i=0; i<s.turrets; i++) {
      lasers.add(new Laser(10, new PVector(s.x-((s.turrets-1)*10)+(i*20), s.y-23)));
    }
    pew.play();
  }
  if (gameState == 0 || gameState == 3) { //Menu buttons
    if (mouseIn((width/2)-60, 190, 120, 40)) {
      gameState = 4;
      animStartTime = sec;
      gameMode = 0;
      rect((width/2)-60, 190, 120, 40);
    } else if (mouseIn((width/2)-50, 240, 100, 40)) {
      gameState = 4;
      animStartTime = sec;
      gameMode = 1;
      rect((width/2)-50, 240, 100, 40);
    }
  } else if (gameState == 5) {
    if (mouseIn((width/2)-75, 210, 150, 40)) {
      gameState = 1;
      animStartTime = sec;
      rect((width/2), 230, 140, 40);
    }
  }
}

void keyReleased() {
  if (gameState == 2) {
    lasers.add(new Laser(10, new PVector(s.x, s.y-23)));
    pew.play();
  }
}
