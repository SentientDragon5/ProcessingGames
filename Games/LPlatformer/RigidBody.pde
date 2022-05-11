public class RigidBody extends Sprite
{
  public float deltaTime = 0.01666666666;
  
  public float mass;
  public Vector velocity;
  public Vector acceleration;
  public float drag;
  
  public RigidBody(String filename, Rect rect)
  {
    super(filename, rect);
    mass = 1;
    velocity = new Vector(0,0);//Vector.zero();
    acceleration = new Vector(0, -18);
    drag = 0.1;
  }
  
  public void update(ArrayList<Sprite> all)
  {
    // Apply Accel
    velocity.addv(acceleration.multiply(deltaTime));
    // Apply Vel
    rect.position.addv(velocity.multiply(deltaTime));
    // Constrain
    rect.setPos(constraint(rect.position, all));
    // Apply Drag
    acceleration.subtract(acceleration.multiply(-1 * drag));
    
    display();
  }
  
  public Vector constraint(Vector posAfter, ArrayList<Sprite> all)
  {
    for(Sprite s : all)
    {
      posAfter.addv(findOffset(new Rect(posAfter, rect.size), s.rect));
    }
    return posAfter;
  }
  public Vector findOffset(Rect r1, Rect r2)
  {
    float right1 = r1.position.x + r1.size.x /2;
    float left1 = r1.position.x - r1.size.x /2;
    float top1 = r1.position.y + r1.size.y /2;
    float bottom1 = r1.position.y - r1.size.y /2;
    
    float right2 = r2.position.x + r2.size.x /2;
    float left2 = r2.position.x - r2.size.x /2;
    float top2 = r2.position.y + r2.size.y /2;
    float bottom2 = r2.position.y - r2.size.y /2;
    /*
    boolean noXOverlap = right1 <= left2 || left1 >= right2;
    boolean noYOverlap = bottom1 <= top2 || top1 >= bottom2;
    if(noXOverlap || noYOverlap)
    { return false; }
    else
    { return true; } */
    Vector offset = new Vector(0,0);//Vector.zero();
    if(right1 <= left2)
    {
      offset.x = left2 - right1;
    }
    else if(right2 <= left1)
    {
      offset.x = left1 - right2;
    }
    
    if(bottom1 <= top2)
    {
      offset.y = top2 - bottom1;
    }
    else if(bottom2 <= top1)
    {
      offset.y = top1 - bottom2;
    }
    return offset;
  }
  
  
  //An instant force that lasts for 1 frame
  public void AddForce(Vector force)
  {
    acceleration.addv(force.divide(mass));
  }
  
}
