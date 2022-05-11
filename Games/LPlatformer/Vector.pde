import java.lang.Math;

public class Vector
{
  public float x;
  public float y;
  
  public Vector(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  public Vector addv(Vector v)
  {
    return new Vector(x+v.x, y+v.y);
  }
  public Vector subtract(Vector v)
  {
    return new Vector(x-v.x, y-v.y);
  }
  public Vector multiply(float f)
  {
    return new Vector(x * f, y * f);
  }
  public Vector divide(float f)
  {
    return new Vector(x / f, y / f);
  }
  public Vector normalized()
  {
    float angle = this.angle();
    return new Vector(cos(angle), sin(angle));
  } 
  public float magnitude()
  {
    return sqrt(x*x + y*y);
  }
  public float sqrMag()
  {
    return x*x + y*y;
  }
  public float angle()
  {
    return acos(x / this.magnitude());
  }
  /*
  public static Vector zero()
  {
    return new Vector(0,0);
  }
  public static Vector up()
  {
    return new Vector(0,1);
  }
  public static Vector down()
  {
    return new Vector(0,-1);
  }
  public static Vector right()
  {
    return new Vector(1,0);
  }
  public static Vector left()
  {
    return new Vector(-1,0);
  }*/
}
