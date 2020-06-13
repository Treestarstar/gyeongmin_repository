/***** SETUP *****/
void setup() {
  
  size(800, 1000);
  
  B1 = loadImage("note_red.png"); B1.resize(blockWidth, blockHeight);
  B2 = loadImage("note_blue.png"); B2.resize(blockWidth, blockHeight);
  B3 = loadImage("note_green.png"); B3.resize(blockWidth, blockHeight);
  B4 = loadImage("note_yellow.png"); B4.resize(blockWidth, blockHeight);
  
  buildBlocks();
  
}

/***** DRAW *****/
void draw() {
  
  gameScreen();
  
}  


void gameScreen() {
  
  gameBackground();
  speed = 20;
  
  /** Blocks **/
  
  for(int i = 0; i < rBlocks.size(); i+=1){
    temp = rBlocks.get(i);
    image(B1, line1, temp);
    rBlocks.set(i, temp+speed);
  }

  for(int i = 0; i < bBlocks.size(); i+=1){
    temp = bBlocks.get(i);
    image(B2, line2, temp);
    bBlocks.set(i, temp+speed);
  }

  for(int i = 0; i < gBlocks.size(); i+=1){
    temp = gBlocks.get(i);
    image(B3, line3, temp);
    gBlocks.set(i, temp+speed);
  }

  for(int i = 0; i < yBlocks.size(); i+=1){
    temp = yBlocks.get(i);
    image(B4, line4, temp);
    yBlocks.set(i, temp+speed);
  }
  
}

void buildBlocks() {
  
  rBlocks = new ArrayList<Float>(); 
  bBlocks = new ArrayList<Float>(); 
  gBlocks = new ArrayList<Float>();  
  yBlocks = new ArrayList<Float>(); 
  
  lines = loadStrings("map.txt");


  for(int i = 0; i < lines.length; i+= 1) {
    
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
