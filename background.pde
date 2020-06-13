int lineWidth = 100;
int lineThickness = 4;
int firstLineSpace = 100;
int hit_elevation = 140;
int hit_area = 100;


void gameBackground() {
  background(0);
  stroke(255, 0, 0);
  line(0, 675, width, 675);
  line(0, 740, width, 740);
  
  // gradation_blue
  for (int i = height; i >= 0; i -= 10) {
    float col = map(i, height, 0, 100, 50); 
    fill(col);
    noStroke();
    rect(0, i, width, 10);
  }
  
  // block lines
  for (int i = 0; i < 5; i += 1) {
    stroke(#ffcc33);
    strokeWeight(lineThickness);
    
    line(firstLineSpace + lineWidth * i, 0, 
         firstLineSpace + lineWidth * i, height);    
  }
  
  // hit place
  fill(#62F3FF, 150);
  noStroke();
  rect(firstLineSpace, height - hit_elevation, 
       lineWidth * 4, -hit_area);
}
