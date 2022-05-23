public class GameText
{
  String text;
  float center_x, center_y;
  PFont mono;
  int size;
  int r,g,b;
  float z;
  public GameText(String text, float x, float y, int size, int r, int g, int b)
  {
    this.text = text;
    mono = createFont("Menu/Pixellari.ttf", 16);
    this.size = size;
    center_x = x;
    center_y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    this.z = 0;
  }
  public GameText(String text, float x, float y, int size, int r, int g, int b, float z)
  {
    this(text, x, y, size, r, g, b);
    this.z = z;
  }
  public void display(){
    textFont(mono);
    fill(r,g,b);
    textSize(size);
    text(text, center_x, center_y);
  }
  public void display(float xOffset){
   
    textFont(mono);
    fill(r,g,b);
    textSize(size);
    text(text, center_x + xOffset * z, center_y);
  }
}
