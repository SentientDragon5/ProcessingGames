public class Spikes extends Sprite
{
  public Spikes(PImage img, float scale)
  {
    super(img, scale);
  }
  
  @Override
  void setTop(float top){
    center_y = top;
  }
  @Override
  float getTop(){
    return center_y;
  }
}
