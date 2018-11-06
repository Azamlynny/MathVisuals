class Dot{
 float x;
 float y;
 int time = 1000;
 
 public Dot(float xPos, float yPos){
   x = xPos;
   y = yPos;
 }
 
 void drawDot(){
   noStroke();
   fill(0, 255, 0, time * 0.1);
   ellipse(x,y,4,4);
   fill(0);
   stroke(0);
 }
 
}