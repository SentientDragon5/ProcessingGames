public class Player extends AnimatedSprite{
  boolean inPlace;
  PImage[] standLeft;
  PImage[] standRight;
  PImage[] jumpLeft;
  PImage[] jumpRight;
  
  PImage[] idleL;
  PImage[] idleR;
  PImage[] walkL;
  PImage[] walkR;
  PImage[] jumpL;
  PImage[] jumpR;
  PImage[] dieL;
  PImage[] dieR;
  
  boolean onPlatform;
  int lives;
  boolean dead;
  public Player()
  {
    this(loadImage("Frog/frogIdle_0_v.png"),4.0);
  }
  public Player(PImage img, float scale){
    super(img, scale);
    direction = RIGHT_FACING;
    inPlace = true;
    onPlatform = true;
    
    idleL = createAnim("Frog/frogIdle1_",7,"_v");
    idleR = createAnim("Frog/frogIdle1_",7,"");
    
    walkL = createAnim("Frog/frogWalk_",7,"_v");
    walkR = createAnim("Frog/frogWalk_",7,"");
    
    jumpL = createAnim("Frog/frogJump_",4,5,"_v");
    jumpR = createAnim("Frog/frogJump_",4,5,"");
    
    dieL = createAnim("Frog/frogDie_",7,"_v");
    dieR = createAnim("Frog/frogDie_",7,"");
    
    standLeft = new PImage[1];
    standLeft[0] = loadImage("Frog/frogIdle_0_v.png");//loadImage("player_stand_left.png");
    standRight = new PImage[1];
    standRight[0] = loadImage("Frog/frogIdle_0.png");//loadImage("player_stand_right.png");
    
    jumpLeft = new PImage[1];
    jumpLeft[0] = loadImage("Frog/frogIdle_0.png");//loadImage("player_stand_left.png");
    jumpRight = new PImage[1];
    jumpRight[0] = loadImage("Frog/frogIdle_0.png");//loadImage("player_stand_right.png");
    
    moveLeft = new PImage[2];
    moveLeft[0] = loadImage("player_walk_left1.png");
    moveLeft[1] = loadImage("player_walk_left2.png");
    moveRight = new PImage[2];
    moveRight[0] = loadImage("player_walk_right1.png");
    moveRight[1] = loadImage("player_walk_right2.png"); 
    currentImages = standRight;
    
    lives = 3;
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
  
  @Override
  public void updateAnimation(){
    // TODO:
    // update inPlace variable: player is inPlace if it is not moving
    // in both direction.
    // call updateAnimation of parent class AnimatedSprite.
    onPlatform = isOnPlatforms(this, platforms);
    inPlace = change_x == 0 && change_y ==0;
    super.updateAnimation();
  }
  @Override
  public void selectDirection(){
    if(change_x > 0)
      direction = RIGHT_FACING;
    else if(change_x < 0)
      direction = LEFT_FACING;    
  }
  @Override
  public void selectCurrentImages(){
    // TODO: Some of the code is already given to you.
    // if direction is RIGHT_FACING
    //    if inPlace
    //       select standRight images
    //    else select moveRight images
    // else if direction is LEFT_FACING
    //    if inPlace
    //       select standLeft images
    //    else select moveLeft images
    if(direction == RIGHT_FACING){
      if(inPlace){
        currentImages = idleR;
      }
      else if(!onPlatform)
      {
        currentImages = jumpR;
      }
      else
        currentImages = walkR;
    }
    else if(direction == LEFT_FACING){
      if(inPlace){
        currentImages = idleL;
      }
      else if(!onPlatform)
      {
        currentImages = jumpL;
      }
      else
        currentImages = walkL;
    }
    
  }
}