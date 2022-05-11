public class Sprite
{
  public PImage image;
  public Rect rect;
  
  public Sprite(String filename, Rect rect)
  {
    image = loadImage(filename);
    this.rect = rect;
  }
  public void display()
  {
     image(image, rect.position.x, rect.position.y, rect.size.x, rect.size.y); 
  }
  
  
}
