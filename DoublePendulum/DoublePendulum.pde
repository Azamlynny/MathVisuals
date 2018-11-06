import java.util.*;

float length1 = 300;
float length2 = 300;
float mass1 = 10;
float mass2 = 10;
float angle1 = PI/4;
float angle2 = PI;
float x1; //= length1 * sin(angle1); // Break up into X and Y cmoponents.
float y1; //= length1 * cos(angle1);
float x2; //= x1 + (length2 * sin(angle2));
float y2; //= y1 + (length2 * cos(angle2));
float angle1_v = 0;
float angle2_v = 0;
float angle1_a = 0;
float angle2_a = 0;
static float g = 5;
boolean vectors = false;
int colorPendulum = 0;

ArrayList<Dot> Trail = new ArrayList<Dot>();

void setup(){
  size(1960,1080); 
  stroke(0);
  strokeWeight(2);
  fill(0);
}

void draw(){
  background(255);
  translate(width/2, 300);
  stroke(0);
  colorPendulum();
  
  line(0,0, x1, y1);
  ellipse(x1, y1, mass1, mass1); //Radius determined by mass
  line(x1, y1, x2, y2);
  ellipse(x2, y2, mass2, mass2);
  
  //Physics Logic
  
  float num1 = -g * (2 * mass1 + mass2) * sin(angle1);
  float num2 = -mass2 * g * sin(angle1 - 2 * angle2);
  float num3 = -2 * sin(angle1 - angle2) * mass2;
  float num4 = angle2_v*angle2_v*length2+angle1_v*angle1_v*length1*cos(angle1-angle2);
  float denominator = length1 * (2 * mass1 * mass2 - mass2 * cos(2 * angle1 - 2 * angle2));
  angle1_a = (num1 + num2 + num3*num4) / denominator;
  
  num1 = 2 * sin(angle1-angle2);
  num2 = (angle1_v*angle1_v*length1*(mass1+mass2));
  num3 = g * (mass1 + mass2) * cos(angle1);
  num4 = angle2_v*angle2_v*length2*mass2*cos(angle1-angle2);
  denominator = length2 * (2*mass1+mass2-mass2*cos(2*angle1-2*angle2));
  angle2_a = (num1*(num2+num3+num4)) / denominator;
  
 
  x1 = length1 * sin(angle1); // Break up into X and Y cmoponents.
  y1 = length1 * cos(angle1);
  x2 = x1 + (length2 * sin(angle2));
  y2 = y1 + (length2 * cos(angle2));
 
 
  angle1_v += angle1_a;
  angle2_v += angle2_a;
  angle1 += angle1_v;
  angle2 += angle2_v;  
  
  Trail.add(new Dot(x2,y2));              // For the Dot trail
  for(int i = 0; i < Trail.size(); i++){
     Trail.get(i).time--;
     if(Trail.get(i).time <= 0){
       Trail.remove(i); 
     }
     Trail.get(i).drawDot();
  }
  
  for(int i = 0; i < Trail.size()-1; i++){
    stroke(0, 255, 0, Trail.get(i).time);
    line(Trail.get(i).x, Trail.get(i).y, Trail.get(i + 1).x, Trail.get(i + 1).y); 
  }
  
  if(vectors == true){
    drawVectors(); 
  }
  
}

void drawVectors(){
  float angle1_f = mass1 * angle1_a;
  float angle2_f = mass1 * angle2_a;
  stroke(0);
  strokeWeight(5);
  line(x1, y1, x1 + (angle1_f * cos(angle1)), (angle1_f * sin(angle1)));
  line(x2, y2, x2 + (angle2_f * cos(angle2)), (angle2_f * sin(angle2)));
  strokeWeight(2);
}

void colorPendulum(){
  fill(colorPendulum);
  if(colorPendulum == 255){
    noStroke(); 
  }
  else{
    stroke(1); 
  }
}

void keyPressed(){
  if(key == 'v'){
    if(vectors == false){
      vectors = true; 
    }
    else{
     vectors = false; 
    }
  }
  if(key == 'c'){
    if(colorPendulum == 0){
      colorPendulum = 255; 
    }
    else{
      colorPendulum = 0; 
    }
  }
}