/*
  Create Enemies Lab:
  
  In the video tutorial, we only create one Enemy object. 
  In this lab, we will use the CSV file to create many enemies each with
  a different left/right boundary. 
    
  There are two versions of this lab:
  1) Friendly Version. More helper code is provided in lab template.
  2) More Challenging Version. Less helper code is provided.
  For more detail, see the tutorial: https://youtu.be/l7kKqx6puAo
   
  This is the friendly version.
  
  Complete the code as indicated by the comments.
  Do the following:
  1) Inspect the map.csv file. Note that we are now using different notation to 
  denote different tile images.
    "0": empty, no image
    "a": snow.png
    "b": brown_brick.png
    "c": crate.png
    numbers indicate the length between left and right boundaries
    of the spider measured in the number of tiles. For example
    "4" = spider will walk back and forth between 4 tiles.
  2) Finish the implementation of the Enemy class.  Only modify/override update(). 
  2) Initialize empty arraylist of Enemy objects in setup.
  3) In draw, use a loop to call diplay(), update AND updateAnimation() on each enemy.
  4) In createPlatforms. Add platforms tiles as indicated above from csv file.
     Do cases "a", "b", "c", "0"(for this case use continue keyword to continue looping 
     and do nothing). Some of this has been done for you. 
     For any other case(else): the numeric value specifies the length of the
     spider walk. See comments below for more details.
  
*/

final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;

final static int NEUTRAL_FACING = 0; 
final static int RIGHT_FACING = 1; 
final static int LEFT_FACING = 2; 

PImage snow, crate, brown_brick, spider;
ArrayList<Enemy> enemies; 
ArrayList<Sprite> platforms; 

void setup(){
  size(800, 600);
  imageMode(CENTER);
  spider = loadImage("spider_walk_right1.png");
  brown_brick = loadImage("brown_brick.png");
  crate = loadImage("crate.png");
  snow = loadImage("snow.png");

  // initialize enemies arraylist.
  enemies = new ArrayList<Enemy>();
  platforms = new ArrayList<Sprite>();
  createPlatforms("map.csv"); 
}

void draw(){
  background(255);

  // use for each loop to display, update and updateAnimation() enemies

  for(Enemy e : enemies)
  {
    e.display();
    e.update();
    e.updateAnimation();
  }
  
  // display platforms
  for(Sprite s: platforms){
    s.display();
  }
}


void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("a")){
        Sprite s = new Sprite(snow, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("b")){
        Sprite s = new Sprite(brown_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("c")){
        Sprite s = new Sprite(crate, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("0")){
        continue; // continue with for loop, i.e do nothing.
      }
      else{
        // use Processing int() method to convert a numeric string to an integer
        // representing the walk length of the spider.
        // for example int a = int("9"); means a = 9.
        int lengthGap = int(values[col]);
        float bLeft = col * SPRITE_SIZE;
        float bRight = bLeft + lengthGap * SPRITE_SIZE;
        Enemy enemy = new Enemy(loadImage("spider_walk_right1.png"), 1, bLeft, bRight);
        enemy.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        enemy.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        // add enemy to enemies arraylist.
        enemies.add(enemy);
    }
    }
  }
}
