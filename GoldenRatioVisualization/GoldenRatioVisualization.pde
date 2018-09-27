float angle = 0;
float seeds = 50;
float addSpeed = 0.0001;
float cX = 0;

void setup() {
  size(1980, 1080);
  background(255);
  fill(0);
  //noStroke();
  textSize(50);
  frameRate(60);
  key = ENTER;
}

void draw() {
  background(255);
  if(key != ENTER){
    angle += addSpeed;
  }
  if(key == BACKSPACE)
  {
    angle -= addSpeed * 2; 
  }
  
  //angle =1.61803398875;
  
  for(int i = 0; i < seeds; i++){
    pushMatrix();
    translate(width/2, height/2);
    
    rotate(radians(angle * i * 360));
    ellipse(10 +(i * (500 / seeds)), 0, 10, 10);  
    //line(0, 0, 10 +(i * (500 / seeds)), 0);
    //line(cX, 0, 10 +((i) * (500 / seeds)), 0);
    popMatrix();
  }
  
  text(angle, 50, 100);
  text((int) seeds, 50, 200);
}

void mouseWheel(MouseEvent wheel){
  float wheelVal = wheel.getCount();
  if(wheelVal > 0){
    seeds--; 
  }
  else if(wheelVal < 0){
    seeds++;
  }
}