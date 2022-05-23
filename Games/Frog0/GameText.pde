public class GameText
{
  String text;
  float center_x, center_y;
  PFont mono;
  int size;
  int r,g,b;
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
  }
  
  public void display(){
    textFont(mono);
    fill(r,g,b);
    textSize(size);
    text(text, center_x, center_y);
  }
}
