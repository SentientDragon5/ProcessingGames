
public class Sprite{
  PImage image;
  float center_x, center_y;
  float change_x, change_y;
  float w, h; 
  
  public Sprite(String filename, float scale, float x, float y){
    image = loadImage("data/" + filename + ".png");
    w = image.width * scale;
    h = image.height * scale;
    center_x = x;
    center_y = y;
    change_x = 0;
    change_y = 0;
  }
  public Sprite(String filename, float scale){
    this(filename, scale, 0,0);
}
  
  public void display(){
    image(image, center_x, center_y, w,h);
}
  public void update(){
    center_x += change_x;
    center_y += change_y;
  }
  public void setVel(float x)
  {
    change_x = x;
  }
}
