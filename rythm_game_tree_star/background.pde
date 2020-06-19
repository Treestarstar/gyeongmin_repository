int lineWidth = 100;
int lineThickness = 4;
int firstLineSpace = 100;
int hit_area = 100, hit_top = 700;
int hit_bottom = hit_top + hit_area;
String[] textname = {"score", "maxcombo", "perfect", "good", "miss"};
int[] colorlabel = {#fa0314, #fa0314, #e0e233, #e51c12, 123};
String[] result = new String[5];
int score = 0, combo = 0, maxcombo = 0, perfectkey = 0, goodkey = 0, misskey = 0;
int health = 0;
int hit = hit_top + (hit_area / 2);


void gameBackground() {
  background(backscreen);
  line(0, 675, width, 675);
  line(0, 740, width, 740);


  // block lines
  for (int i = 0; i < 5; i += 1) {
    stroke(#ffcc33);
    strokeWeight(lineThickness);

    line(firstLineSpace + lineWidth * i, 0, 
      firstLineSpace + lineWidth * i, height);
  }

  // health bar
  if (health <= hit) {
    fill(255);
    stroke(255);
    rect(firstLineSpace + lineWidth * 4, health, 30, height);
  } else {
    fill(255,0,0);
    stroke(255,0,0);
    rect(firstLineSpace + lineWidth * 4, health, 30, height);
  }
  

  // hit place
  fill(#e51c12, 150);
  noStroke();

  rect(firstLineSpace, hit, 
    lineWidth * 4, 10);
  
  //result
  int scoreboard = 300, allscore = 350;
  for (int i = 0; i<textname.length; i++) {
    if (i == textname.length-1) {
      fill(colorlabel[i]);
      textSize(32);
      text(textname[i], 615, scoreboard);
    } else {
      fill(colorlabel[i], 150);
      textSize(32);
      text(textname[i], 615, scoreboard);
      scoreboard += 100;
    }
  }
  
  //score
  result[0] = String.valueOf(score);
  fill(255);
  textSize(32);
  text(result[0], 665, allscore);
  allscore += 100;
  //maxcombo
  result[1] = String.valueOf(maxcombo);
  fill(255);
  textSize(32);
  text(result[1], 665, allscore);
  allscore += 100;
  //perfect
  result[2] = String.valueOf(perfectkey);
  fill(255);
  textSize(32);
  text(result[2], 665, allscore);
  allscore += 100;
  //good
  result[3] = String.valueOf(goodkey);
  fill(255);
  textSize(32);
  text(result[3], 665, allscore);
  allscore += 100;
  //miss
  result[4] = String.valueOf(misskey);
  fill(255);
  textSize(32);
  text(result[4], 665, allscore);
  allscore += 100;
}
