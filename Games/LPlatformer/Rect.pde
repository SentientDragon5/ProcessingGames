public class Rect
{
  public Vector position;
  public Vector size;
  
  public Rect(Vector position, Vector size)
  {
    this.position = position;
    this.size = size;
  }
  public Rect(float x, float y, float w, float h)
  {
    this(new Vector(x,y), new Vector(w,h));
  }
  
  public void setPos(Vector v)
  {
    position = v;
  }
}
