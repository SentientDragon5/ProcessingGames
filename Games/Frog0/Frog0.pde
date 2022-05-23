/*
  Logan Shehane
TODO
Add levels 
create levels
add file to hold enemy data and end location of level

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
final static float DASHVEL = 40;
final static int DASHLENGTH = 6;
int time;

// 0 = StartMenu
// 1 = Game
// 2 = Pause
// 3 = Win
int gameMode = 0;

// Menu
Sprite title;

// Game
PImage playerImage;
Player player;
PImage snow, crate, red_brick, brown_brick, coin;
PImage mask;

AnimatedSprite transition;

ArrayList<Enemy> enemies; 
ArrayList<Sprite> platforms;
ArrayList<Sprite> coins; 
ArrayList<Sprite> gems; 
TileMap back;
TileMap collide;

int score;
boolean isGameOver;
boolean lose;
boolean restart;

float view_x;
float view_y;

int level = -1;
float win_x;
float win_y;

void setup(){
  time = 0;
  size(800, 600);
  smooth(0);
  imageMode(CENTER);
  mask = loadImage("Menu/alpha.png");
  restart = false;
  if(gameMode == 1)
  {
    String[] dataTxt = loadStrings("Levels/Map_" + level + ".txt");
    // Game
    player = new Player();//new Player(playerImage, 0.8);
  player.center_x = SPRITE_SIZE/2 + int(split(dataTxt[0], " ")[1]) * SPRITE_SIZE;//width/2;
  player.center_y = SPRITE_SIZE/2 + int(split(dataTxt[0], " ")[2]) * SPRITE_SIZE;//height/2;
  
  win_x = SPRITE_SIZE/2 + int(split(dataTxt[1], " ")[1]) * SPRITE_SIZE;
  win_y = SPRITE_SIZE/2 + int(split(dataTxt[1], " ")[2]) * SPRITE_SIZE;
  
  transition = new AnimatedSprite(createAnim("Transition/Transition_",10,""),32);
  
  coins = new ArrayList<Sprite>();
  gems = new ArrayList<Sprite>();
  enemies = new ArrayList<Enemy>();
  platforms = new ArrayList<Sprite>();
  view_x = 0;
  view_y = 0;
  isGameOver = false;
  lose = true;
  score = 0;
  
  back = new TileMap("Levels/Map_" + level + "_back.csv", 0.2);
  collide = new TileMap("Levels/Map_" + level + ".csv");
  //platforms = collide.tiles;
  for(int i=0; i<collide.tiles.size(); i++)
  {
    platforms.add(collide.tiles.get(i));
  }
  
  //Add one enemy bc
  String[] values = split(lines[r], " ");
  int lengthGap = int(5);
        float bLeft = 20 * SPRITE_SIZE;
        float bRight = bLeft + lengthGap * SPRITE_SIZE;
        Enemy enemy = new Enemy(createAnim("bug/bug_",2,""), 4, 5, bLeft, bRight);
        enemy.center_x = SPRITE_SIZE/2 + 20 * SPRITE_SIZE;
        enemy.center_y = SPRITE_SIZE/2 + 5 * SPRITE_SIZE;
        // add enemy to enemies arraylist.
        enemies.add(enemy);
        
        
  //end game Setup
  }
  else
  {
    title = new Sprite(loadImage("Menu/Froglet.png"), .4);
  }
  
}

// ================================================ //
//                   Start Draw                     //
// ================================================ //
void draw(){
  fill(255);
  PFont mono;
  mono = createFont("Menu/Pixellari.ttf", 16);
  textFont(mono);
  textSize(32);
  
  if(gameMode == 1)
  {
  //background(255);
  background(33,38,63); // bg
  //background(29,32,48); // Bit darker
  scroll();
  displayAll();
  
  
  
  fill(255,0,0);
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
    collectCoins();
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
    if(!lose )
      gameMode = 3;
    setup();
  }
  }
  else
  {
    background(29,32,48);
    title.center_x = width/2;
    title.center_y = height/2 - 50;
    title.display();
    
    fill(255);
    //text("Lives: " + player.lives, view_x + 50, view_y +100);
    if(gameMode == 2)
    {
      text("Press Space to resume", width/2 - 50, height/2 + 50);
      text("Game Paused", width/2, height/2 -150);
    }
    if(gameMode == 3)
    {
      text("You Win!", width/2, height/2 - 150);
    }
    if(gameMode != 2)
    {
      //text("Press Space to start", width/2 - 50, height/2 + 50);
      text("Press the number of the level that you want", 60, height/2 + 100);
      textSize(16);
      text("0 - Tutorial", width/2 - 200, height/2 + 130);
      text("1 - The Depths", width/2 - 200, height/2 + 150);
      text("2 - Deeper Still", width/2 - 200, height/2 + 170);
      text("9 - Original testing world", width/2 - 200, height/2 + 190);
      
    }
    textSize(16);
    text("Code - Copywrite SentientDragon5 2022", width - 400, height - 75);
    text("Level Art - https://adamatomic.itch.io/cavernas", width - 400, height - 50);
    text("Character Art - https://lukaslundin.itch.io/froglet", width - 400, height - 25);
    
    text("May 2022 - v1.0", 10, height - 25);
  }
  time++;
}
// ================================================ //
//                    End Draw                      //
// ================================================ //

void checkDeath()
{
  collide.checkDeath();
  boolean collideEnemy = false;
  for(Enemy e : enemies)
  {
    collideEnemy = collideEnemy || checkCollision(player, e);
  }
  boolean fallOffCliff = player.getBottom() > GROUND_LEVEL;
  if(collideEnemy || fallOffCliff)
  {
    onDie();
    /*//player.lives--;
    if(player.lives ==0)
    { isGameOver = true; }
    else
    {
      //player.center_x = 100;
      //player.setBottom(GROUND_LEVEL);
      player.center_x = width/2;
      player.center_y = height/2;
    }*/
  }
  
}
void displayAll()
{
  back.display(view_x);
  
  
  for(Enemy e : enemies)
  {
    e.display();
  }
  
  for(Sprite coin : coins)
  {
    coin.display();
  }
  for(Sprite gem : gems)
  {
    gem.display();
  }
  //for(Sprite s: platforms)
    //s.display();
  collide.display();
  
  player.display();
  //front.display(view.x);
}
void updateAll()
{
  player.updateAnimation();
  player.selectCurrentImages();
  player.setXSpeed();
  if(player.dashing)
    player.dash();
  resolvePlatformCollisions(player, platforms);
  
  back.update();
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
  for(Sprite gem : gems)
  {
    ((AnimatedSprite)gem).updateAnimation();
  }
}
void collectCoins()
{
  ArrayList<Sprite> collision_list = checkCollisionList(player, coins);
  if(collision_list.size() > 0){
    for(Sprite coin: collision_list){
      if(coin instanceof Coin)
        score++;
      coins.remove(coin);
    }
  }
  collision_list = checkCollisionList(player, gems);
  if(collision_list.size() > 0){
    for(Sprite gem: collision_list){
      if(gem instanceof Gem)
      {
        ((Gem)gem).onCollide();
      }
    }
  }
  if(coins.size() <= 0)
  {
    lose = false;
    isGameOver = true;
  }
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
  player.grounded = false;
  if(col_list.size() > 0 && abs(s.change_y) > 0){// only collide if moving on that axis IMPORTANT
    Sprite collided = col_list.get(0);
    if(s.change_y > 0){
      s.setBottom(collided.getTop());
      player.grounded = true;
      player.dashes = 1;
    }
    else if(s.change_y < 0){
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
  }

  // move in x-direction by adding change_x to center_x to update x position.
  s.center_x += s.change_x;
    
  col_list = checkCollisionList(s, walls);
  if(col_list.size() > 0 && abs(s.change_x) > 0){
    Sprite collided = col_list.get(0);
    if(s.change_x > 0){
        s.setRight(collided.getLeft());
    }
    else if(s.change_x < 0){
        s.setLeft(collided.getRight());
    }
    
    s.change_x = 0;
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
  /*
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
*/
public void onDie()
{
  isGameOver = true;
  //still update animation
  //stop motion
  //show transition
  //frog die
  if(!restart && lose)
    player.setDeathAnim();
}


String getData(String filename, int r, int c){
  String[] lines = loadStrings(filename);
  String[] values = split(lines[r], " ");
  return values[c];
}


// ================================================ //
//                    keyPressed                    //
// ================================================ //

// called whenever a key is pressed.
void keyPressed(){
  
  if(gameMode == 1)
  {
  if(key == 'a')
    player.left = true;
  if(key == 'd')
    player.right = true;
  
  if(key == ' ' && isOnPlatforms(player, platforms)){
    player.change_y = -JUMP_SPEED;
      
  }
  
  player.setDashDirDown(key == 'w',key == 's',key == 'a', key == 'd');
  if(key == 'v')
    player.dashing = true;
  else
    player.dashing = false;
  if(isGameOver && key == ' ')
  {
    setup();
  }
  if(key == '1')
  {
    gameMode = 2;
  }
  if(key == 'r')
  {
    gameMode = 1;
    restart = true;
    isGameOver = true;
  }
  }
  else
  {
    if(key == ' ')
    {
      if(gameMode != 2)
      {
        level = 0;
        gameMode = 1;
        setup();
      }
      gameMode = 1;
    }
    
    if(key == '0')
    {
      if(gameMode != 2)
      {
        level = 0;
        gameMode = 1;
        setup();
      }
      gameMode = 1;
    }
    if(key == '1')
    {
      if(gameMode != 2)
      {
        level = 1;
        gameMode = 1;
        setup();
      }
      gameMode = 1;
    }
    if(key == '2')
    {
      if(gameMode != 2)
      {
        level = 2;
        gameMode = 1;
        setup();
      }
      gameMode = 1;
    }
    if(key == '9')
    {
      if(gameMode != 2)
      {
        level = -1;
        gameMode = 1;
        setup();
      }
      gameMode = 1;
    }
  }
}

// called whenever a key is released.
void keyReleased(){
  if(gameMode == 1)
  {
  if(key == 'a')
    player.left = false;
  if(key == 'd')
    player.right = false;
    player.setDashDirUp(key == 'w',key == 's',key == 'a', key == 'd');
  }
}
