public class TileMap
{
  ArrayList<Sprite> tiles;
  public TileMap(String filename){
    tiles = new ArrayList<Sprite>();
    createPlatforms(filename);
  }
  public void display(){
    for(Sprite s : tiles)
      s.display();
  }
  public void display(int xOffset){
    for(Sprite s : tiles)
      s.display(xOffset, 0);
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
      PImage img;
      if(i < 0)
        img = loadImage(filePath + i + "_FlipedV.png");
      else
        img = loadImage(filePath + i + ".png");
      
      Sprite s = new Sprite(img, 4);
      s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
      s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
      tiles.add(s);
      
    }
  }
}

}
