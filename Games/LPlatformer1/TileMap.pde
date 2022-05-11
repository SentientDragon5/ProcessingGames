public class TileMap
{
  public ArrayList<PImage> texes;
  
  public TileMap(ArrayList<String> textures)
  {
    texes = new ArrayList<PImage>();
    for(int i=0; i<textures.size(); i++)
    {
      texes.add(loadImage(textures.get(i)));
    }
    
  }
  
}
