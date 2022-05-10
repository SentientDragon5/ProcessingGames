
final static float MOVE_SPEED = 5; 

Sprite s1;


//initialize them in setup().
void setup(){
  size(800, 600); 
  imageMode(CENTER); 
  s1 = new Sprite("player.png", 1.0, width/2, height/2);

}

// modify and update them in draw().
void draw(){
  background(255);
  s1.display();
  s1.update();
  
} 

void keyPressed(){
// move character using 'a', 's', 'd', 'w'. Also use MOVE_SPEED above.
  if(key == 'a'){
    s1.change_x = -MOVE_SPEED; 
  }
  if(key == 'd'){
    s1.change_x = MOVE_SPEED; 
  }
  if(key == 'w'){
    s1.change_y = -MOVE_SPEED; 
  }
  if(key == 's'){
    s1.change_y = MOVE_SPEED; 
  }
}

void keyReleased(){
// if key is released, set change_x, change_y back to 0
  if(key == 'a'){
    s1.change_x = 0; 
  }
  if(key == 'd'){
    s1.change_x = 0; 
  }
  if(key == 'w'){
    s1.change_y = 0; 
  }
  if(key == 's'){
    s1.change_y = 0; 
  }
}
