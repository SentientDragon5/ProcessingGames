//https://adamatomic.itch.io/cavernas
//https://free-game-assets.itch.io/free-tiny-hero-sprites-pixel-art?download

final static int PPX = 8;
final static int SCALE = 4;
final static int ANIMRATE = 4; // the rate at which animations update.
final static float DELTATIME = 0.01666666666;

//declare global variables.
//TileMap bg;
TileMap collideables;
TileMap decorations;
TileMap platforms;

Player p;
//initialize them in setup().
void setup(){
  size(800, 600);
  smooth(0);
  imageMode(CENTER);
  //collideables = new TileMap("bg.csv");
  collideables = new TileMap("collide.csv");
  platforms = new TileMap("platform.csv");
  decorations = new TileMap("decor.csv");
  
  p = new Player(200, 200);
}

//modify and update them in draw().
void draw(){
  background(33,38,63);
  //background(255);
  //bg.display(0);
  collideables.display();
  platforms.display();
  decorations.display();
  
  p.display();
}
