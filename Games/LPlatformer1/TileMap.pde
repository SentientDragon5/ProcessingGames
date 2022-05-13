public class TileMap
{
  
ArrayList<PImage> palette;
ArrayList<PImage> paletteFlipped;

int[][] tiles;

public TileMap(String filename)
{
  setTilePalette();
  createTileMap(filename);
}
public void display()
{
  drawTileMap(0,0);
}

public void display(int xOffset)
{
  drawTileMap(xOffset, 0);
}


void drawTileMap(int xOff, int yOff)
{
  for(int r= tiles.length-1; r >=0; r--)
  {
    for(int c=0; c<tiles.length; c++)
    {
      int wh = PPX * SCALE;
      int x = (r * wh) + (wh / 2) + xOff;
      int y = (c * wh) + (wh / 2) + yOff;
      int i = tiles[r][c];
      if(i != 0)
        image(getImage(r,c), x, y, wh, wh);
    }
  }
}
PImage getImage(int r, int c)
{
  int i = tiles[r][c];
  if(i > 0){
    return palette.get(i);
  }
  return paletteFlipped.get(-1 * i);
}
void setTilePalette()
{
  String filePath = "CaveTileSet/caves_";
  palette = new ArrayList<PImage>();
  paletteFlipped = new ArrayList<PImage>();
  
  int maxTiles = 95;
  for(int i=0; i<maxTiles; i++)
  {
    palette.add(loadImage(filePath + i + ".png"));
    paletteFlipped.add(loadImage(filePath + i + "_FlipedV.png"));
  }
}
void createTileMap(String filename)
{
  int maxX = 50;
  int maxY = 50;
  tiles = new int[maxX][maxY];
  for(int r=0; r<maxX; r++)
    for(int c=0; c<maxY; c++)
      tiles[r][c] = 0;
  
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length && row < tiles.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length && col < tiles[row].length; col++){
      String str = values[col];
      if(str.trim().equals(""))
      {
        tiles[col][row] = 0;
      }
      else
      {
        int flipped = 1;
        if(str.contains("FlipedV"))
        {
          flipped = -1;
        }
        if(str.contains("v"))
        {
          flipped = -1;
        }
        tiles[col][row] = flipped * int(str);
      }
    }
  }
}

public boolean overlap(int x, int y)
{
  int wh = PPX * SCALE;
  int r = (x - (wh / 2)) / wh;
  int c = (y - (wh / 2)) / wh;
  if(r > tiles.length-1 || c > tiles[r].length-1 || r<0 || c<0)
    return false;
  return tiles[r][c] != 0;
}
public float raycastVertical(int x, int y, boolean positive, int d)
{
  int v = y;
  if(positive)
  {
    while(v < d){
      if(overlap(x,v))
        break;
      v++;
    }
  }
  else
  {
    while(v > d){
      if(overlap(x,v))
        break;
      v--;
    }
  }
  
  return y - v;
}
public float raycastHorizontal(int x, int y, boolean positive, int d)
{
  int u = x;
  if(positive)
  {
    while(u < d){
      if(overlap(u,y))
        break;
      u++;
    }
  }
  else
  {
    while(u > d){
      if(overlap(u,y))
        break;
      u--;
    }
  }
  return x - u;
}
  
}
