import ddf.minim.*;

Minim minim;
AudioPlayer player;


/***** SETUP *****/
void settings() {
  size(800, 1000);
  minim = new Minim(this);
  player = minim.loadFile("music_sample.mp3");
  if ( millis() > 3000 ){
    player.play();
  }
  
  
}
void setup() {
  //backscreen
  backscreen = loadImage("backscreen.png");
  //game over
  gameover = loadImage("GameOver.png");
  //game clear
  gameclear = loadImage("GameClear.png");
  //Notes
  red = loadImage("note_red.png"); 
  red.resize(blockWidth, blockHeight);
  blue = loadImage("note_blue.png"); 
  blue.resize(blockWidth, blockHeight);
  green = loadImage("note_green.png"); 
  green.resize(blockWidth, blockHeight);
  yellow = loadImage("note_yellow.png"); 
  yellow.resize(blockWidth, blockHeight);

  buildBlocks();
}

/***** DRAW *****/
void draw() {
  if (gameState == 0) {
  } else if (gameState == 1) {
    player.play();
    gameScreen();
  } else if (gameState == 2) {
    player.pause(); 
    gameover();
  }
}  

void gameScreen() {
  gameBackground();
  if (health <= hit) {
    speed = 20;
  } else {
    speed = 15;
  }
  

  /** Blocks **/
  for (int i = 0; i < rBlocks.size(); i+=1) {
    temp = rBlocks.get(i);
    image(red, line1, temp);
    rBlocks.set(i, temp+speed);
  }

  for (int i = 0; i < bBlocks.size(); i+=1) {
    temp = bBlocks.get(i);
    image(blue, line2, temp);
    bBlocks.set(i, temp+speed);
  }

  for (int i = 0; i < gBlocks.size(); i+=1) {
    temp = gBlocks.get(i);
    image(green, line3, temp);
    gBlocks.set(i, temp+speed);
  }

  for (int i = 0; i < yBlocks.size(); i+=1) {
    temp = yBlocks.get(i);
    image(yellow, line4, temp);
    yBlocks.set(i, temp+speed);
  }
  /** CHECK MISS **/
  if (!rBlocks.isEmpty()) {
    if (rBlocks.get(0) > 1001) {
      rBlocks.remove(0);
      misskey += 1;
      judge = 4;
      if (maxcombo < combo) {
        maxcombo = combo;
      }
      combo = 0;
      health += 40;
  
      if (health >= 1001) {
        gameState = 2;
        gameover();
      }
    }
  } else {
    gameState = 3;
    player.pause();
    gameclear();
  }
  if (!gBlocks.isEmpty()) {
    if (gBlocks.get(0) > 1001) {
      gBlocks.remove(0);
      misskey += 1;
      judge = 4;
      if (maxcombo < combo) {
        maxcombo = combo;
      }
      combo = 0;
      health += 40;
      
      if (health >= 1001) {
        gameState = 2;
        gameover();
      }
    }
  } else {
    gameState = 3;
    player.pause();
    gameclear();
  }
  if (!bBlocks.isEmpty()) {
    if (bBlocks.get(0) > 1001) {
      bBlocks.remove(0);
      misskey += 1;
      judge = 4;
      if (maxcombo < combo) {
        maxcombo = combo;
      }
      combo = 0;
      health += 40;
      
      if (health >= 1001) {
        gameState = 2;
        gameover();
      }
    }
  } else {
    gameState = 3;
    player.pause();
    gameclear();
  }
  
  if (!yBlocks.isEmpty()) {
    if (yBlocks.get(0) > 1001) {
      yBlocks.remove(0);
      misskey += 1;
      judge = 4;
      if (maxcombo < combo) {
        maxcombo = combo;
      }
      combo = 0;
      health += 40;
      
      if (health >= 1001) {
        gameState = 2;
        gameover();
      }
    }
  } else {
    gameState = 3;
    player.pause();
    gameclear();
  }
}

void buildBlocks() {

  rBlocks = new ArrayList<Float>(); 
  bBlocks = new ArrayList<Float>(); 
  gBlocks = new ArrayList<Float>();  
  yBlocks = new ArrayList<Float>(); 

  lines = loadStrings("map1.txt");


  for (int i = 0; i < lines.length; i+= 1) {

    String parts[] = lines[i].split(" ");
    k = parts[0];
    v = Float.parseFloat(parts[1])*-11; // *-10.4

    if (k.equals("r")) {
      rBlocks.add(v);
    } else if (k.equals("b")) {
      bBlocks.add(v);
    } else if (k.equals("g")) {
      gBlocks.add(v);
    } else if (k.equals("y")) {
      yBlocks.add(v);
    }
  }
}

void judge(String a) {
  if (a.equals("red")) {
    if (!rBlocks.isEmpty()) {
      float x = rBlocks.get(0);
      //perfect++;
      if (hit_top + 20 <= x && x <= hit_bottom - 20) {
        rBlocks.remove(0);
        score += 50;
        combo++;
        perfectkey ++;
        judge = 1;
        health -= 10;
        if (health <= 0) {
          health = 0;
        }
      } else if (hit_top <= x && x <= hit_bottom) {
        rBlocks.remove(0);
        //good++;
        score += 25;
        goodkey ++;
        combo++;
        judge = 2;
        health -= 6;
        if (health <= 0) {
          health = 0;
        }
      } else if  (hit_top - 100 <= x && x <= hit_bottom + 200) {
        rBlocks.remove(0);
        //bad++;
        score += 0;
        misskey ++;
        if (maxcombo < combo) {
          maxcombo = combo;
        }
        combo = 0;
        judge = 3;
        health += 6;
        if (health >= 1001) {
          gameover();
        }
      }
    } else {
      gameState = 3;
      gameclear();
    }
  } else if (a.equals("green")) {
    if (!gBlocks.isEmpty()) {
      float x = gBlocks.get(0);
      if (hit_top + 20 <= x && x <= hit_bottom - 20) {
        gBlocks.remove(0);
        perfectkey++;
        score += 50;
        combo++;
        judge = 1;
        health -= 10;
        if (health <= 0) {
          health = 0;
        }
      } else if (hit_top <= x && x <= hit_bottom) {
        gBlocks.remove(0);
        goodkey++;
        score += 25;
        combo++;
        judge = 2;
        health -= 6;
        if (health <= 0) {
          health = 0;
        }
      } else if  (hit_top - 100 <= x && x <= hit_bottom + 200) {
        gBlocks.remove(0);
        misskey++;
        score += 0;
        if (maxcombo < combo) {
          maxcombo = combo;
        }
        combo = 0;
        judge = 3;
        health += 6;
        if (health >= 1001) {
          gameover();
        }
      }
    } else {
      gameState = 3;
      gameclear();
    }
  } else if (a.equals("blue")) {
    if (!bBlocks.isEmpty()) {
      float x = bBlocks.get(0);
      if (hit_top + 20 <= x && x <= hit_bottom - 20) {
        bBlocks.remove(0);
        perfectkey++;
        score += 50;
        combo++;
        judge = 1;
        health -= 10;
        if (health <= 0) {
          health = 0;
        }
      } else if (hit_top <= x && x <= hit_bottom) {
        bBlocks.remove(0);
        goodkey++;
        score += 25;
        combo++;
        judge = 2;
        health -= 6;
        if (health <= 0) {
          health = 0;
        }
      } else if (hit_top - 100 <= x && x <= hit_bottom + 200) {
        bBlocks.remove(0);
        misskey++;
        score += 0;
        if (maxcombo < combo) {
          maxcombo = combo;
        }
        combo = 0;
        judge = 3;
        health += 6;
        if (health >= 1001) {
          gameover();
        }
      }
    } else {
      gameState = 3;
      gameclear();
    }
  } else if (a.equals("yellow")) {
    if (!yBlocks.isEmpty()) {
      float x = yBlocks.get(0);
      if (hit_top + 20 <= x && x <= hit_bottom - 20) {
        yBlocks.remove(0);
        perfectkey++;
        score += 50;
        combo++;
        judge = 1;
        health -= 10;
        if (health <= 0) {
          health = 0;
        }
      } else if (hit_top <= x && x <= hit_bottom) {
        yBlocks.remove(0);
        goodkey++;
        score += 25;
        combo++;
        judge = 2;
        health -= 6;
        if (health <= 0) {
          health = 0;
        }
      } else if  (hit_top - 100 <= x && x <= hit_bottom + 200) {
        yBlocks.remove(0);
        misskey++;
        score += 0;
        if (maxcombo < combo) {
          maxcombo = combo;
        }
        combo = 0;
        judge = 3;
        health += 6;
        if (health >= 1001) {
          gameover();
        }
      }
    } else {
      gameState = 3;
      gameclear();
    }
  }
}

/** game clear **/
void gameclear() {
  image(gameclear, 0, 0, width, height);
  //score
  result[0] = String.valueOf(score);
  fill(255);
  textSize(70);
  text(result[0], 120, 420);
  //maxcombo
  result[1] = String.valueOf(maxcombo);
  fill(255);
  textSize(70);
  text(result[1], 140, 650);
  //perfect
  result[2] = String.valueOf(perfectkey);
  fill(255);
  textSize(50);
  text(result[2], 220, 880);
  //good
  result[3] = String.valueOf(goodkey);
  fill(255);
  textSize(50);
  text(result[3], 390, 880);
  //miss
  result[4] = String.valueOf(misskey);
  fill(255);
  textSize(50);
  //grade
  text(result[4], 560, 880);
  if (score >= 4500) {
    fill(251, 236, 0);
    textSize(250);
    text('S', 530, 630);
  } else if (score >= 4000) {
    fill(249, 6, 132);
    textSize(250);
    text('A', 530, 630);
  } else if (score >= 3500) {
    fill(7, 202, 251);
    textSize(250);
    text('B', 530, 630);
  } else if (score >= 3000) {
    fill(10, 249, 32);
    textSize(250);
    text('C', 530, 630);
  }
}
/** game over **/
void gameover() {
  image(gameover, 0, 0, width, height);
}

/** game reset **/
void reset() {
  player.pause();
  player.rewind();
  perfectkey = 0;
  goodkey = 0;
  misskey = 0;
  misskey = 0;
  maxcombo = 0;
  combo = 0;
  score = 0;
  health = 0;
}

void keyPressed() {
  /** RED **/
  if (key == 'j' && !rPressed) {
    //beatpress.trigger();
    //r_press = true;
    r_time = 7;
    judge("red");
    rPressed = true;
  }
  /** GREEN **/
  if (key == 'l' && !gPressed) {
    //beatpress.trigger();
    //g_press = true;
    g_time = 7;
    judge("green");
    gPressed = true;
  }
  /** BLUE **/
  if (key == 'k' && !bPressed) {
    //beatpress.trigger();
    //b_press = true;
    b_time = 7;
    judge("blue");
    bPressed = true;
  }
  /** YELLOW **/
  if (key == ';' && !yPressed) {
    //beatpress.trigger();
    //y_press = true;
    y_time = 7;
    judge("yellow");
    yPressed = true;
  }
  /** CLEAR **/
  if (gameState == 3) {
    if (key == ' ') {
      gameState = 0;
    }
  }
  /** RESTART **/
  if (gameState == 2) {
    if (key == 'r') {
      reset();
      gameState = 1;
      buildBlocks();
      gameScreen();
    } else if (key == ' ') {
      gameState = 0;
    }
  }
}
void keyReleased() {
  /** GAME SCREEN **/
  /** RED **/
  if (key == 'j' && rPressed) {
    rPressed = false;
  }
  /** GREEN **/
  if (key == 'l' && gPressed) {
    gPressed = false;
  }
  /** BLUE **/
  if (key == 'k' && bPressed) {
    bPressed = false;
  }
  /** YELLOW **/
  if (key == ';' && yPressed) {
    yPressed = false;
  }
}

/** GameScreen
 public void GetGameScreen(int status) {
 exitCode = status;
 }**/
