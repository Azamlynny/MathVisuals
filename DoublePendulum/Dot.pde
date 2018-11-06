class Dot{
 float x;
 float y;
 int time = 200;
 
 public Dot(float xPos, float yPos){
   x = xPos;
   y = yPos;
 }
 
 void drawDot(){
   noStroke();
   fill(0, time);
   ellipse(x,y,3,3);
   fill(0);
   stroke(0);
 }
 
}