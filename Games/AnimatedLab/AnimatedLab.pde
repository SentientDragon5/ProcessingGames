/*
  Animated Sprite Lab:
  
  This is similar to the Collect Coins lab except that we will 
  animate the coins. Coins are placed randomly on the screen. Player moves around and collect coins.
  The number of coins is updated and displayed on the screen.
  
  Most of the code is provided, particularly for the Collect Coins part of the lab.
  As always, make sure you understand the code that is provided to you.
  
  There are two versions of this lab:
  1) Friendly Version. More helper code is provided in lab template.
  2) More Challenging Version. Less helper code is provided.
  For more detail, see the tutorial: https://youtu.be/l7kKqx6puAo
   
  This is the friendly version.
  
  Complete the code as indicated by the comments.
  Do the following:
  1) Complete the AnimateSprite and Coin classes. 
  2) In draw, use a loop to call diplay() AND updateAnimation() on each coin. You
  may need to cast appropriately here since the arraylist contains Sprite but only
  AnimatedSprite class has the updateAnimation method.
  See the comments below for more details. 
 
*/

final static float MOVE_SPEED = 4;
final static float COIN_SCALE = 0.4;
final static float TANK_SCALE = 0.8;

final static int NEUTRAL_FACING = 0; 
final static int RIGHT_FACING = 1; 
final static int LEFT_FACING = 2; 


Sprite player;
PImage c;
ArrayList<Sprite> coins; 
int score;

void setup(){
  size(1024, 768);
  imageMode(CENTER);
  player = new Sprite("tank.png", TANK_SCALE, width/2, height/2);
  c = loadImage("gold1.png");
  // initialize score
  score = 0;
  // initialize the arrayList coins
  coins = new ArrayList<Sprite>();
  // for loop to create coin Sprite and add to coins arraylist
  // randomize their center_x and center_y(use MATH.random() and cast to float)
  for(int i = 0; i < 10; i++){
    Coin coin = new Coin(c, COIN_SCALE);
    coin.center_x = (float)(Math.random()*width);
    coin.center_y = (float)(Math.random()*height);
    coins.add(coin);
  }
  
}

void draw(){
  background(255);
  player.display();
  player.update();
  
  // use for each loop to display coins
  // You may need to cast appropriately here since the arraylist contains Sprite objects 
  // but only AnimatedSprite class has the updateAnimation method.

  for(Sprite coin : coins)
  {
    ((AnimatedSprite)coin).updateAnimation();
    coin.display();
  }
  
  
  
  // call checkCollisionList and 
  // store the returned collision list(arraylist) of coin Sprites that collide with player.
  // if collision list not empty
  //   for loop through collision list
  //     remove each coin, add 1 to score
  ArrayList<Sprite> collision_list = checkCollisionList(player, coins);
  if(collision_list.size() > 0){
    for(Sprite coin: collision_list){
       coins.remove(coin);
       score++;
    }
  }
  
  // call textSize(size), fill(r, g, b) and text(str, x, y) to display score. 
  textSize(32);
  fill(255, 0, 0);
  text("Coins:" + score, 50, 50);
}

// returns whether the two Sprites s1 and s2 collide.
public boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}

/**
   This method accepts a Sprite s and an ArrayList of Sprites and returns
   the collision list(ArrayList) which consists of the Sprites that collide with the given Sprite. 
   MUST CALL THE METHOD checkCollision ABOVE!
*/ 
public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}


  
void keyPressed(){
  if(keyCode == RIGHT)
    player.change_x = MOVE_SPEED;
  else if(keyCode == LEFT)
    player.change_x = -MOVE_SPEED;
  else if(keyCode == UP)
    player.change_y = -MOVE_SPEED;
  else if(keyCode == DOWN)
    player.change_y = MOVE_SPEED;
}

void keyReleased(){
  if(keyCode == RIGHT)
    player.change_x = 0;
  else if(keyCode == LEFT)
    player.change_x = 0;
  else if(keyCode == UP)
    player.change_y = 0;
  else if(keyCode == DOWN)
    player.change_y = 0;
    
}
