public class Player
{
  // Anims
  PImage[] idleR;
  PImage[] walkR;
  PImage[] jumpR;
  PImage[] dieR;
  PImage[] idleL;
  PImage[] walkL;
  PImage[] jumpL;
  PImage[] dieL;
  
  // Current data
  PImage[] cAnim;
  
  int t;
  int f;
  
  int w;
  int h;
  
  // Physics
  int posX;
  int posY;
  float velX;
  float velY;
  float grav;
  
  public Player(int x, int y)
  {
    setAnims();
    cAnim = idleR;
    
    posX = x;
    posY = y;
    velX = 0;
    velY = 0;
    grav = 10;
    
    w = 16;
    h = 16;
    
    t = 0;
    incrementFrame();
  }
  public void display()
  {
    // Physics
    physicsUpdate();
    // Collisions
    
    // Show image
    cAnim[f] = loadImage("Character/Dude_Monster_Idle_4_0.png");
    image(cAnim[f], posX, posY, w * SCALE, h * SCALE);
    // Update the animation frame
    incrementFrame();
  }
  
  void checkCollisions(TileMap tMap)
  {
    float yOffset = tMap.raycastVertical(posX, posY - h/2, true, h) -
    tMap.raycastVertical(posX, posY + h/2, false, h);
    float xOffset = tMap.raycastHorizontal(posX - w/2, posY, true, w) - 
    tMap.raycastHorizontal(posX + w/2, posY, false, w);
    posX += xOffset;
    posY += yOffset;
  }
  
  void physicsUpdate()
  {
    velY += grav * DELTATIME;
    posX += velX * DELTATIME;
    posY += velY * DELTATIME;
  }
  
  void incrementFrame()
  {
    f = t / ANIMRATE;
    while(f > cAnim.length -1)
    {
      f -= cAnim.length;
    }
    
    t++;
  }
  
  void setAnims()
  {
    idleR = getAnimR("Character/Dude_Monster_Idle_4_", 4);
  }
  public PImage[] getAnimR(String fileName, int size)
  {
    PImage[] anim = new PImage[size];
    for(int i=0; i<size; i++)
    {
      anim[i] = loadImage(fileName + i + ".png");
    }
    return anim;
  }
  
  public PImage[] getAnimL(String fileName, int size)
  {
    PImage[] anim = new PImage[size];
    for(int i=0; i<size; i++)
    {
      anim[i] = loadImage(fileName + i + "_FlipedV.png");
    }
    return anim;
  }
}
