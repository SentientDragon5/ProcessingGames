public class TileMap
{
  float z;
  ArrayList<Sprite> tiles;
  ArrayList<Spikes> spikes;
  public TileMap(String filename){
    tiles = new ArrayList<Sprite>();
    createPlatforms(filename);
    z =0;
  }
  public TileMap(String filename, float z){
    tiles = new ArrayList<Sprite>();
    createPlatforms(filename);
    this.z = z;
  }
  public void display(){
    for(Sprite s : tiles)
      s.display();
  }
  public void display(float xOffset){
    for(Sprite s : tiles)
      s.display(xOffset * z);
  }
  public void update()
  {
    for(Sprite s : tiles)
    {
      if( s instanceof AnimatedSprite)
      {      
        ((AnimatedSprite)s).updateAnimation();
      }
    }
  }
  public boolean checkDeath()
  {
    boolean collideSpike = false;
    for(Sprite s : tiles)
    {
      if( s instanceof Spikes)
      {      
        //((Spikes)s).updateAnimation();
        if(isTouching(player, s))
          onDie();
        collideSpike = collideSpike || checkCollision(player, s);
      }
    }
    return collideSpike;
  }
  
void createPlatforms(String filename){
  
  String filePath = "CaveTileSet/caves_";
  
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("0")){
        continue; // continue with for loop, i.e do nothing.
      }
      int i = int(values[col]);
      Sprite s = null;
      
      if(i==101)
      {
        //gem
        PImage[] anim = createAnim("Gem/Gem_",3,"");
        s = new Gem(anim, 4, 5);
        
      }
      else if(i==100)
      {
        //coin
        PImage[] anim = createAnim("coin/coin_",7,"");
        s = new Coin(anim, 4, 5);
        
      }
      else if(i==17 || i==8 || i==9 || i==10 || i==19 || i==25)
      {//FlipV anim
        PImage[] anim = new PImage[2];
        anim[0] = loadImage(filePath + i + ".png");
        anim[1] = loadImage(filePath + i + "_FlipedV.png");
        s = new AnimatedSprite(anim, 4, 16);
      }
      else if(i==16)
      {
        PImage[] anim = new PImage[2];
        anim[0] = loadImage(filePath + 16 + ".png");
        anim[1] = loadImage(filePath + 18 + "_FlipedV.png");
        s = new AnimatedSprite(anim, 4, 16);
      }
      else if(i==18)
      {
        PImage[] anim = new PImage[2];
        anim[0] = loadImage(filePath + 18 + ".png");
        anim[1] = loadImage(filePath + 16 + "_FlipedV.png");
        s = new AnimatedSprite(anim, 4, 16);
      }
      else if(i==96 || i==97 || i==98 || i==99 || i==2)
      {
        PImage img;
        img = loadImage(filePath + i + ".png");
        s = new Spikes(img, 4);
      }
      else
      {
        PImage img;
        if(i < 0)
          img = loadImage(filePath + i + "_FlipedV.png");
        else
          img = loadImage(filePath + i + ".png");
        s = new Sprite(img, 4);
      }
      
      s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
      s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
      if(i==100)
        coins.add(s);
      else if (i==101)
        gems.add(s);
      else
        tiles.add(s);
      
      
    }
  }
}

}
