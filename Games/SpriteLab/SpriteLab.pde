
Sprite s1, s2;

void setup(){
  size(800, 600);
  imageMode(CENTER);
  s1 = new Sprite("player", 0.5, 600,200);
  s2 = new Sprite("crate", 2.0, 500,400);

}

void draw(){
  background(255);
  
  s1.display();
  s1.update();
  s2.display();
  s2.update();
} 
