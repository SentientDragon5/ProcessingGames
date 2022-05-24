// Implement this class. You just need to implement the constructor
// the three inherited methods from AnimatedSprite will work as is.

public class Coin extends AnimatedSprite{
  // call super appropriately
  // initialize standNeutral PImage array only since
  // we only have four coins and coins do not move.
  // set currentImages to point to standNeutral array(this class only cycles
  // through standNeutral for animation).
  
  public Coin(PImage[] anim, float scale, int speed)
  {
    super(anim, scale, speed);
  }
  public Coin(PImage[] anim,float x, float y, float scale, int speed, int index)
  {
    super(anim, scale, speed);
    this.index = index;
    center_x = x;
    center_y = y;
  }
  @Override
  void OnCollide()
  {
    
  }
}
