//declare global variables.
RigidBody player;

//initialize them in setup().
void setup(){
  size(800, 600);
  imageMode(CENTER);
  player = new RigidBody("data/ball.png", new Rect(100,100, 50,50));
}

//modify and update them in draw().
void draw(){
  background(255);
  
  player.update(new ArrayList<Sprite>());
}
