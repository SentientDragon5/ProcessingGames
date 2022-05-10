/*
  Resolving Platform Collisions Lab:
  
  Add gravity and resolve platform collisions. This is the most important
  algorithm for this game. 
  
  For more detail, see the tutorials: 
  Resolving Platform Collisions Part 1: https://youtu.be/nFOlo6F60FA
  Resolving Platform Collisions Part 2: https://youtu.be/kZYIuI7BLZY
    
  Complete the code as indicated by the comments.
  Do the following:
  1) Implement the resolvePlatformCollisions method below. You only need to implement
  this method. Make sure to understand the rest of the given code.
  See the comments below for more details. 
 
*/

final static float MOVE_SPEED = 4;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;
final static float GRAVITY = .6;
final static float JUMP_SPEED = 14; 

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;


//declare global variables
Sprite player;
PImage tile, crate, red_brick, brown_brick;
ArrayList<Sprite> platforms;

//initialize them in setup().
void setup(){
  size(800, 600);
  imageMode(CENTER);
  player = new Sprite("player.png", 0.8);
  player.center_x = 200;
  player.center_y = 50;
  platforms = new ArrayList<Sprite>();
 
 
  red_brick = loadImage("red_brick.png");
  brown_brick = loadImage("brown_brick.png");
  crate = loadImage("crate.png");
  tile = loadImage("tile.png");
  createPlatforms("map.csv");
}

// modify and update them in draw().
void draw(){
  background(255);
  
  player.display();
  resolvePlatformCollisions(player, platforms);
  for(Sprite s: platforms)
    s.display();

} 

// implement this method.
public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
  // add gravity to change_y of sprite
  
  
  // move in y-direction by adding change_y to center_y to update y position.

  
  // Now resolve any collision in the y-direction:
  // compute collision_list between sprite and walls(platforms).

  
  
  /* if collision list is nonempty:
       get the first platform from collision list
       if sprite is moving down(change_y > 0)
         set bottom of sprite to equal top of platform
       else if sprite is moving up
         set top of sprite to equal bottom of platform
       set sprite's change_y to 0
  */




  // move in x-direction by adding change_x to center_x to update x position.

  
  
  // Now resolve any collision in the x-direction:
  // compute collision_list between sprite and walls(platforms).   
  
  
  
  /* if collision list is nonempty:
       get the first platform from collision list
       if sprite is moving right
         set right side of sprite to equal left side of platform
       else if sprite is moving left
         set left side of sprite to equal right side of platform
  */

  
}


boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}

public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}


void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("1")){
        Sprite s = new Sprite(red_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("2")){
        Sprite s = new Sprite(tile, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("3")){
        Sprite s = new Sprite(brown_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("4")){
        Sprite s = new Sprite(crate, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
    }
  }
}
 

// called whenever a key is pressed.
void keyPressed(){
  if(keyCode == RIGHT){
    player.change_x = MOVE_SPEED;
  }
  else if(keyCode == LEFT){
    player.change_x = -MOVE_SPEED;
  }
}

// called whenever a key is released.
void keyReleased(){
  if(keyCode == RIGHT){
    player.change_x = 0;
  }
  else if(keyCode == LEFT){
    player.change_x = 0;
  }
}
