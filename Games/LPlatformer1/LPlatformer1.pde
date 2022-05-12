//https://adamatomic.itch.io/cavernas
//https://free-game-assets.itch.io/free-tiny-hero-sprites-pixel-art?download

//declare global variables.
ArrayList<PImage> palette;
int[][] tiles;

//initialize them in setup().
void setup(){
  size(800, 600);
  imageMode(CENTER);
  
  
  createTileMap("map.csv");
}

//modify and update them in draw().
void draw(){
  background(255);
  
}

public void createTileMap(String filename)
{
  //String filePath = "CaveTileset/caves_";
  int maxX = 50;
  int maxY = 50;
  tiles = new int[maxX][maxY];
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      String str = values[col];
      if(str.trim().equals(""))
      {
        tiles[row][col] = -1;
      }
      else
      {
        tiles[row][col] = Integer.parseInt(str);
      }
    }
  }
}
