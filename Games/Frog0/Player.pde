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
  boolean stopAnimating;
  
  int margin;
  
  float dash_x;
  float dash_y;
  boolean grounded;
  
  public Player()
  {
    this(loadImage("Frog/frogIdle_0_v.png"),4.0);
  }
  public Player(PImage img, float scale){
    super(img, scale);
    direction = RIGHT_FACING;
    inPlace = true;
    onPlatform = true;
    stopAnimating = false;
    
    idleL = createAnim("Frog/frogIdle1_",7,"_v");
    idleR = createAnim("Frog/frogIdle1_",7,"");
    
    walkL = createAnim("Frog/frogWalk_",7,"_v");
    walkR = createAnim("Frog/frogWalk_",7,"");
    
    jumpL = createAnim("Frog/frogJump_",4,5,"_v");
    jumpR = createAnim("Frog/frogJump_",4,5,"");
    
    dieL = createAnim("Frog/frogDie_",7,"_v");
    dieR = createAnim("Frog/frogDie_",7,"");
    /*
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
    moveRight[1] = loadImage("player_walk_right2.png"); */
    currentImages = standRight;
    
    lives = 3;
    left = false;
    right = false;
     margin = 16;
     
     dash_x = 1.0;
     dash_y = 0.0;
     dashing = false;
     dashTime = -100;
     dashes = 1;
     grounded = true;
  }
  
  
  @Override
  public void updateAnimation(){
    // TODO:
    // update inPlace variable: player is inPlace if it is not moving
    // in both direction.
    // call updateAnimation of parent class AnimatedSprite.
    onPlatform = isOnPlatforms(this, platforms);
    inPlace = change_x == 0 && change_y ==0;
    if(!isGameOver || (isGameOver && index < dieR.length-1))
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
      if(isGameOver && lose && !restart){
        currentImages = dieR;
      }
      else if(inPlace){
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
      if(isGameOver && lose && !restart){
        currentImages = dieL;
      }
      else if(inPlace){
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
  boolean left;
  boolean right;
  // Accelerate and decelerate 
  public void setXSpeed()
  {
    if(DASHLENGTH + dashTime >= time)
      return;
    
    float sign = 0;
    if(change_x > 0)
      sign = 1;
    else if(change_x < 0)
      sign = -1;
      
      
    if(left && right)
    {
      
    }
    else if(left)
    {
      if(sign == -1)
        change_x -= XACCEL;// * DELTATIME;
      else
        change_x -= XACCEL * 2;
    }
    else if(right)
    {
      if(sign == 1)
        change_x += XACCEL;// * DELTATIME;
      else
        change_x += XACCEL * 2;
    }
    else
    {
      change_x -= sign * XACCEL * 2;;// * DELTATIME;
    }
    if(abs(change_x) < 0.2)
      change_x = 0;
    //sign =0;
    if(change_x > 0)
      sign = 1;
    else if(change_x < 0)
      sign = -1;
    if(abs(change_x) >= MOVE_SPEED)
    {
      change_x = sign * MOVE_SPEED;
    }
  }
  
  public void setDeathAnim()
  {
    index=0;
    frame =0;
    if(direction == RIGHT_FACING){
      currentImages = dieR;
    }
    else if(direction == LEFT_FACING){
      currentImages = dieL;
    }
  }
  
  
  void setLeft(float left){
    center_x = left + w/2 - margin;
  }
  float getLeft(){
    return center_x - w/2 + margin;
  }
  void setRight(float right){
    center_x = right - w/2 + margin;
  }
  float getRight(){
    return center_x + w/2 - margin;
  }
  void setTop(float top){
    center_y = top + h/2;
  }
  float getTop(){
    return center_y - h/2;
  }
  void setBottom(float bottom){
    center_y = bottom - h/2;
  }
  float getBottom(){
    return center_y + h/2;
  }
  
  int dashes;
  boolean dashing;
  int dashTime;
  public void dash()
  {
    if(dashes < 1)
      return;
    dashes--;
    dashTime = time;
    dash_x = 0;
    dash_y = 0;
    
    if(u && d)
      dash_y = 0;
    else if(u)
      dash_y = -1;
    else if(d)
      dash_y = 1;
    
    if(l && r)
      dash_x = 0;
    else if(l)
      dash_x = -1;
    else if(r)
      dash_x = 1;
    
      
    // simple normalize
    if(abs(dash_y) > 0)
    {
      dash_x = dash_x * 0.70710678118;
    }
    if(abs(dash_x) > 0)
    {
      dash_y = dash_y * 0.70710678118;
    }
    
    change_x = DASHVEL * dash_x * 0.7;
    change_y = DASHVEL * dash_y * 0.5;
    dashing = false;
  }
  boolean u,d,l,r;
  
  public void setDashDirDown(boolean u, boolean d, boolean l, boolean r)
  {
    if(u)
      this.u = true;
    if(d)
      this.d = true;
    if(l)
      this.l = true;
    if(r)
      this.r = true;
  }
  public void setDashDirUp(boolean u, boolean d, boolean l, boolean r)
  {
    if(u)
      this.u = false;
    if(d)
      this.d = false;
    if(l)
      this.l = false;
    if(r)
      this.r = false;
  }
}
