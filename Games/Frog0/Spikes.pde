public class Spikes extends Sprite
{
  public Spikes(PImage img, float scale)
  {
    super(img, scale);
    dir =0;
  }
  // up, down, left, right
  public Spikes(PImage img, float scale, int dir)
  {
    super(img, scale);
    this.dir = dir;
  }
  int dir;
  
  @Override
  void setLeft(float left){
    center_x = left + w/2;
  }
  @Override
  float getLeft(){
    return center_x - w/2;
  }
  @Override
  void setRight(float right){
    center_x = right - w/2;
  }
  @Override
  float getRight(){
    return center_x + w/2;
  }
  @Override
  void setTop(float top){
    center_y = top;
  }
  @Override
  float getTop(){
    return center_y;
  }
  @Override
  void setBottom(float bottom){
    center_y = bottom - h/2;
  }
  @Override
  float getBottom(){
    return center_y + h/2;
  }
  
  @Override
  void OnCollide()
  {
    
  }
}
