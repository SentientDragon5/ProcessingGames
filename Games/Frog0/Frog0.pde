/*
  Logan Shehane
*/

final static float MOVE_SPEED = 4;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 32;
final static float GRAVITY = .6;
final static float JUMP_SPEED = 14; 

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;

final static int NEUTRAL_FACING = 0; 
final static int RIGHT_FACING = 1; 
final static int LEFT_FACING = 2; 
final static int GROUND_LEVEL = 1200;//600; 
final static float DELTATIME = 1/60;

final static float XACCEL = 0.2;

PImage playerImage;
Player player;
PImage snow, crate, red_brick, brown_brick, coin;

AnimatedSprite transition;

ArrayList<Enemy> enemies; 
ArrayList<Sprite> platforms;
ArrayList<Sprite> coins; 
TileMap collide;

int score;
boolean isGameOver;

float view_x;
float view_y;

void setup(){
  size(800, 600);
  smooth(0);
  imageMode(CENTER);
  //playerImage = loadImage("player_stand_right.png");
  player = new Player();//new Player(playerImage, 0.8);
  player.center_x = width/2;
  player.center_y = height/2;
  
  transition = new AnimatedSprite(createAnim("Transition/Transition_",10,""),32);
  
  coins = new ArrayList<Sprite>();
  enemies = new ArrayList<Enemy>();
  platforms = new ArrayList<Sprite>();
  view_x = 0;
  view_y = 0;
  isGameOver = false;
  score =0;
  
  red_brick = loadImage("red_brick.png");
  brown_brick = loadImage("brown_brick.png");
  crate = loadImage("crate.png");
  snow = loadImage("snow.png");
  coin = loadImage("gold1.png");
  //createPlatforms("map.csv");
  
  collide = new TileMap("collide.csv");
  //platforms = collide.tiles;
  for(int i=0; i<collide.tiles.size(); i++)
  {
    platforms.add(collide.tiles.get(i));
  }
}

void draw(){
  //background(255);
  //background(33,38,63);
  background(29,32,48);
  scroll();
  displayAll();
  
  
  
  fill(255,0,0);
  textSize(32);
  //text("Coins: " + score, view_x + 50, view_y + 50);
  //text("Lives: " + player.lives, view_x + 50, view_y +100);
  
  if(isGameOver)
  {
    
  player.updateAnimation();
    /*
    fill(0,0,255);
    text("GAME OVER!", view_x + width/2 - 100, view_y + height/2);
    if(player.lives == 0)
      text("You lose!", view_x + width/2 - 100, view_y + height/2 + 50);
    else
      text("You Win!", view_x + width/2 - 100, view_y + height/2 + 50);
      text("Press SPACE to restart!",  view_x + width/2 - 100, view_y + height/2 + 100);
      */
      
  }
  else
  {
    updateAll();
    //collectCoins();
    checkDeath();
  }
  if(isGameOver && transition.index < transition.standNeutral.length-1)
  {
    transition.center_x = player.center_x;
    transition.center_y = player.center_y - 25;
    transition.updateAnimation();
    transition.display();
  }
  else if(isGameOver)
  {
    transition.index = transition.standNeutral.length-1;
    transition.display();
    setup();
  }
}


void checkDeath()
{
  collide.checkDeath();
  //println(collide.checkDeath());
  boolean collideEnemy = false;
  for(Enemy e : enemies)
  {
    collideEnemy = collideEnemy || checkCollision(player, e);
  }
  boolean fallOffCliff = player.getBottom() > GROUND_LEVEL;
  if(collideEnemy || fallOffCliff)
  {
    player.lives--;
    if(player.lives ==0)
    {
      isGameOver = true;
    }
    else
    {
      //player.center_x = 100;
      //player.setBottom(GROUND_LEVEL);
      player.center_x = width/2;
      player.center_y = height/2;
    }
  }
  
}
void displayAll()
{
  player.display();
  
  for(Enemy e : enemies)
  {
    e.display();
  }
  
  for(Sprite coin : coins)
  {
    coin.display();
  }
  
  //for(Sprite s: platforms)
    //s.display();
  collide.display();
  
}
void updateAll()
{
  player.updateAnimation();
  player.selectCurrentImages();
  player.setXSpeed();
  resolvePlatformCollisions(player, platforms);
  collide.update();
  
  for(Enemy e : enemies)
  {
    e.update();
    e.updateAnimation();
  }
  
  for(Sprite coin : coins)
  {
    ((AnimatedSprite)coin).updateAnimation();
  }
  
}
void collectCoins()
{
  ArrayList<Sprite> collision_list = checkCollisionList(player, coins);
  if(collision_list.size() > 0){
    for(Sprite coin: collision_list){
       coins.remove(coin);
       score++;
    }
  }
  if(coins.size() <= 0)
  isGameOver = true;
}

void scroll(){
  float right_boundary = view_x + width - RIGHT_MARGIN;
  
  if(player.getRight() > right_boundary)
  {
    view_x += player.getRight() - right_boundary;
  }
  
  float left_boundary = view_x + LEFT_MARGIN;
  if(player.getLeft() < left_boundary)
  {
    view_x -= left_boundary - player.getLeft();
  }
  
  float bottom_boundary = view_y + height - VERTICAL_MARGIN;
  if(player.getBottom() > bottom_boundary)
  {
    view_y -= player.getTop() - bottom_boundary;
  }
  
  float top_boundary = view_y + VERTICAL_MARGIN;
  if(player.getTop() < top_boundary)
  {
    view_y -= top_boundary - player.getTop();
  }
  translate(-view_x, -view_y);


}


// returns true if sprite is one a platform.
public boolean isOnPlatforms(Sprite s, ArrayList<Sprite> walls){
  // move down say 5 pixels
  s.center_y += 5;

  // check to see if sprite collide with any walls by calling checkCollisionList
  ArrayList<Sprite> collision_list = checkCollisionList(s, walls);
  
  // move back up 5 pixels to restore sprite to original position.
  s.center_y -= 5;
  
  // if sprite did collide with walls, it must have been on a platform: return true
  // otherwise return false.
  return collision_list.size() > 0; 
}
public boolean isTouching(Sprite a, Sprite b)
{
  int dist = 1;
  boolean touching = false;
  a.center_x += dist * a.change_x;
  touching = touching || checkCollision(a,b);
  a.center_x -= dist * 2 * a.change_x;
  touching = touching || checkCollision(a,b);
  a.center_x += dist * a.change_x;
  
  a.center_y += dist * a.change_y;
  touching = touching || checkCollision(a,b);
  a.center_y -= dist * 2 * a.change_y;
  touching = touching || checkCollision(a,b);
  a.center_y += dist * a.change_y;
  return touching;
}


// Use your previous solutions from the previous lab.

public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
  // add gravity to change_y of sprite
  s.change_y += GRAVITY;
  
  // move in y-direction by adding change_y to center_y to update y position.
  s.center_y += s.change_y;
  
  // Now resolve any collision in the y-direction:
  // compute collision_list between sprite and walls(platforms).
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  
  /* if collision list is nonempty:
       get the first platform from collision list
       if sprite is moving down(change_y > 0)
         set bottom of sprite to equal top of platform
       else if sprite is moving up
         set top of sprite to equal bottom of platform
       set sprite's change_y to 0
  */
  if(col_list.size() > 0){
    Sprite collided = col_list.get(0);
    if(s.change_y > 0){
      s.setBottom(collided.getTop());
    }
    else if(s.change_y < 0){
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
  }

  // move in x-direction by adding change_x to center_x to update x position.
  s.center_x += s.change_x;
  
  // Now resolve any collision in the x-direction:
  // compute collision_list between sprite and walls(platforms).   
  col_list = checkCollisionList(s, walls);

  /* if collision list is nonempty:
       get the first platform from collision list
       if sprite is moving right
         set right side of sprite to equal left side of platform
       else if sprite is moving left
         set left side of sprite to equal right side of platform
  */

  if(col_list.size() > 0){
    Sprite collided = col_list.get(0);
    if(s.change_x > 0){
        s.setRight(collided.getLeft());
    }
    else if(s.change_x < 0){
        s.setLeft(collided.getRight());
    }
  }}

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

public PImage[] createAnim(String path, int len, String flip)
  {
    PImage[] anim = new PImage[len];
    for(int i=0; i<len; i++)
    {
      anim[i] = loadImage(path + i + flip + ".png");
    }
    return anim;
  }
  public PImage[] createAnim(String path, int start, int end, String flip)
  {
    PImage[] anim = new PImage[end-start];
    for(int i=start; i<end; i++)
    {
      anim[i-start] = loadImage(path + i + flip + ".png");
    }
    return anim;
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
      else if(values[col].equals("p")){
        Coin s = new Coin(crate, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        coins.add(s);
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

public void onDie()
{
  isGameOver = true;
  //still update animation
  //stop motion
  //show transition
  //frog die
  player.setDeathAnim();
}

// called whenever a key is pressed.
void keyPressed(){
  if(key == 'a')
    player.left = true;
  if(key == 'd')
    player.right = true;
  /*
  if(key == 'd'){
    player.change_x = MOVE_SPEED;
  }
  else if(key == 'a'){
    player.change_x = -MOVE_SPEED;
  }*/
  // add an else if and check if key pressed is 'a' and if sprite is on platforms
  // if true then give the sprite a negative change_y speed(use JUMP_SPEED)
  // defined above
  if(key == ' ' && isOnPlatforms(player, platforms)){
    player.change_y = -JUMP_SPEED;
      
  }
  if(isGameOver && key == ' ')
  {
    setup();
  }

}

// called whenever a key is released.
void keyReleased(){
  if(key == 'a')
    player.left = false;
  if(key == 'd')
    player.right = false;
  
  /*if(key == 'd'){
    player.change_x = 0;
  }
  else if(key == 'a'){
    player.change_x = 0;
  }*/
}
