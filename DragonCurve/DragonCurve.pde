
import java.util.*;

int orientation = 1; // 1 = right 2 = up 3 = left 4 = down
int iteration = 1;
int xPos = 0;
int yPos = 0;
float dim = 100;

List<Character> directions = new ArrayList<Character>();


void setup(){
  size(1960, 1080);
  directions.add('r');
}

void draw(){
  translate(width/2, height/2);
  background(255);
  
  drawCurve();
}

void drawCurve(){
  //float dim = 1000/(directions.size() * .5);
  
  orientation = 1;
  xPos = 0;
  yPos = 0;
   //line(xPos, yPos, xPos, yPos + dim); 
     //yPos += 1000 / directions.size();
  for(int i = 0; i < directions.size(); i++){
    if(directions.get(i) == 'r'){
      orientation--; 
    }
    else{
      orientation++;
    }
    
    if(orientation > 4){
      orientation = 1; 
    }
    else if(orientation < 1){
      orientation = 4; 
    }
    
   if(orientation == 1){
     line(xPos, yPos, xPos + dim, yPos);
     xPos += dim;
   }
   else if(orientation == 2){
     line(xPos, yPos, xPos, yPos + dim); 
     yPos += dim;
   }
   else if(orientation == 3){
     line(xPos, yPos, xPos - dim, yPos);
     xPos += -dim;
   }
   else{
     line(xPos, yPos, xPos, yPos - dim); 
     yPos += -dim;
   }
   
   //System.out.print(directions.get(i));
  }
  //System.out.println();
  
}

void keyPressed(){
  if(key == 32){
    nextIteration();
  }
}

void nextIteration(){
  directions.add('r');
  int temp = directions.size() - 1;
  for(int i = temp; i > 0; i--){
    //System.out.println(directions.size() - 1);
    if(directions.get(i - 1) == 'r'){
      directions.add('l');
    }
    else if(directions.get(i - 1) == 'l'){
      directions.add('r'); 
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e == -1){
    dim++;
  }
  else if(e == 1){
    dim--;
  }
}