public class Gem extends AnimatedSprite
{
  PImage[] full;
  PImage[] empty;
  PImage[] charge;
  
  // 0 = empty
  // rechargeTime = full
  int rechargeTime;
  int state;
  public Gem(PImage[] anim, float scale, int speed)
  {
    super(anim, scale, speed);
    
    full = createAnim("Gem/Gem_",3,4,"");
    empty = createAnim("Gem/Gem_",0,1,"");
    charge = createAnim("Gem/Gem_",1,3,"");
    
    rechargeTime = 20;
    state = rechargeTime;
    
  }
  @Override
  public void updateAnimation() 
  {
    super.updateAnimation();
  }
  @Override
  public void selectCurrentImages(){
    
    if(state < rechargeTime-1)
      state++;
    if(state >= rechargeTime)
      currentImages = full;
    else if(rechargeTime - state > speed * charge.length)
      currentImages = charge;
    else
      currentImages = empty;
    
    println(currentImages == full);
  }
  public void onCollide()
  {
    player.dashes++;
    state = 0;
  }
}
