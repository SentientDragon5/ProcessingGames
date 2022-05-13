//https://adamatomic.itch.io/cavernas
//https://free-game-assets.itch.io/free-tiny-hero-sprites-pixel-art?download

final static int PPX = 8;
final static int SCALE = 4;

//declare global variables.
//TileMap bg;
TileMap collideables;
TileMap decorations;

//initialize them in setup().
void setup(){
  size(800, 600);
  smooth(0);
  imageMode(CENTER);
  //collideables = new TileMap("bg.csv");
  collideables = new TileMap("collide.csv");
  decorations = new TileMap("decor.csv");
}

//modify and update them in draw().
void draw(){
  //background(33,38,63);
  background(255);
  //bg.display(0);
  collideables.display();
  decorations.display();
}
