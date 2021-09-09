import controlP5.*;


//defining global variables
Table data;
PShape map, map2, pkey, keybg, sky;
PImage map_texture, key_texture, sky_texture;
color bg = color(4,22,59);

int keybgHeight = 0;

float camX = 1500;
float camY = 1500;
float zoom = 1;

int chosenYear = 2011;

PFont regular;
PFont bold;

//this array will contain each city's data as their own "City" object
ArrayList<City> cities = new ArrayList<City>();
 
// booleans for each directional key input status
boolean keys[] = new boolean [4];
int pressed;
boolean isLeft, isRight, isUp, isDown; 

void setup(){
  size(1920, 1020, P3D);
  
  data();
  minMax();

  regular = createFont("Arial", 100);
  bold = createFont("Arial Bold", 100);
  
  noStroke();
  smooth();  
  
  
  // creating map foundations
  rectMode(LEFT);
  map = createShape(RECT, 0, 0, 2448,2802);
  map.setTexture(map_texture);
  
  rectMode(LEFT);
  map2 = createShape(RECT, -24500, -28000, 49000, 56000);
  map2.setFill(bg);

  
  // creating sky background
  rectMode(LEFT);
  sky = createShape(RECT, 0, 0, 25600, 16000);
  sky.setTexture(sky_texture);
  sky.rotateX(90);

  
  // adding all the different GUI options in the gui class
  addGUI();
  
}

void draw(){
  background(bg);     
  lights();
  //ortho(); 
  
  //title for the visualisation, changing depending on the selected year. 
  pushMatrix();
  translate(width/2-100,0);
  stroke(7);
  shape(titlebg);
  fill(255);
  textSize(25);
  text("Population Map "+chosenYear, 20, 35); 
  popMatrix();
  
  
  //key graphic for population indicator 
  rectMode(CORNER);  
  keybg = createShape(RECT, 0, 0, 1920, keybgHeight);
  keybg.setFill(color(20,20,20));
  shape(keybg);
  
  pushMatrix();
  translate(20,450);
  shape(pkey);
  popMatrix();
    
  float eyeX = camX;
  float eyeY = camY + (height*0.5)/tan(PI/6);
  float eyeZ = (height*0.5)/tan(PI/6)*zoom;
  
  // camera to use for moving around the scene
  camera(eyeX, eyeY, eyeZ, camX, camY, 0, 0, 1, 0);
  
  shape(map);
  
  // for all cities in the array, if they have valid coordinates and are set to visible, draw the visualisation shape
  for(City c : cities){
    if(c.getX() != 0 && c.getY() != 0 && c.visible() && c.getPop() > 0){
      if(c.visible() && c.getPop() > 0) c.drawBox();
    }
  }
    
  // move camera based on what direction(s) are actively being pushed
  if (isLeft) camX -= 10;
  if (isRight) camX += 10;
  if (isDown) camY += 10;
  if (isUp) camY -= 10;
  
  
  pushMatrix();
  translate(0,0,-10);
  shape(map2);
  popMatrix();
  
  pushMatrix();
  translate(-12000,-4000,sky.height/2);
  shape(sky);
  popMatrix();
  
  //resetting camera at the end of draw to fix issues with 2d GUI ontop of 3d canvas. 
  camera();
}

// add or subtract the amount the scroll wheel is moved to the zoom of the camera
void mouseWheel(MouseEvent event) {
  zoom += event.getCount()*0.1;
  println(zoom);
}

// when a given movement key is pressed, pass along the direction to the setPressed method
void keyPressed() {
  if (key == 'w' || key == 'W' || keyCode == UP) setPressed(UP, true);
  if (key == 's' || key == 'S' || keyCode == DOWN) setPressed(DOWN, true);
  if (key == 'a' || key == 'A' || keyCode == LEFT)  setPressed(LEFT, true);
  if (key == 'd' || key == 'D' || keyCode == RIGHT)  setPressed(RIGHT, true);
}

// given a movement key is released, pass along the direction
void keyReleased() {
  if (key == 'w' || key == 'W' || keyCode == UP)  setPressed(UP, false);
  if (key == 's' || key == 'S' || keyCode == DOWN)  setPressed(DOWN, false);
  if (key == 'a' || key == 'A' || keyCode == LEFT) setPressed(LEFT, false);
  if (key == 'd' || key == 'D' || keyCode == RIGHT)  setPressed(RIGHT, false);
}

//set the movement direction to true/false
boolean setPressed(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
  case DOWN:
    return isDown = b;
  case LEFT:
    return isLeft = b;
  case RIGHT:
    return isRight = b;
  default:
    return b;
  }
}
