//declare global variables.
PImage img;
float center_x, center_y;
float change_x, change_y;
float radius;

//initialize them in setup().
void setup(){
  size(800, 600);
  img = loadImage("data/ball.png");
  center_x = 100;
  center_y = 300;
  change_x = 5;
  change_y = 5;
  radius = 50;
}

//modify and update them in draw().
void draw(){
  background(255);
  image(img, center_x, center_y, radius, radius);
  center_x += change_x;
  center_y += change_y;
  
  if(center_x >= width - radius){
    center_x = width - radius;
    change_x *= -1;
  }
  if(center_x <= 0 + radius){
    center_x = 0 + radius;
    change_x *= -1;
  }
  if(center_y >= height - radius){
    center_y = height - radius;
    change_y *= -1;
  }
  if(center_y <= 0 + radius){
    center_y = 0 + radius;
    change_y *= -1;
  }
}
