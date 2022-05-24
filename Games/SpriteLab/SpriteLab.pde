
import processing.sound.*;
SoundFile file;

void setup() {
  size(640, 360);
  background(255);
    
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "JumpSFX.mp3");
  file.loop();
  file.play();
}

void draw() {
}
/*
import processing.sound.*;

Sprite s1, s2;
SoundFile s;
void setup(){
  size(800, 600);
  imageMode(CENTER);
  s1 = new Sprite("player", 0.5, 600,200);
  s2 = new Sprite("crate", 2.0, 500,400);
  s1.setVel(3);
  s2.setVel(2);
  s = new SoundFile(this, "music.mp3");
}

void draw(){
  background(255);
  
  s.play();
  s1.display();
  s1.update();
  s2.display();
  s2.update();
} */
