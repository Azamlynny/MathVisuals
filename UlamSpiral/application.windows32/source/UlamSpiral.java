import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class UlamSpiral extends PApplet {



int primesAmount = 100000;
List<Boolean> primes = new ArrayList<Boolean>();
int boxDim;
int boxWidth;
boolean first = true;
List<Integer> eulersPrimes = new ArrayList<Integer>();

public void settings(){
  size(1000, 1000); 
}

public void setup(){
  noStroke();
  //strokeWeight(0);
  textAlign(CENTER);
  for(int i = 0; i < primesAmount; i++){
    primes.add(true); 
  }
  
  primes.set(0, false);//1

  for(int i = 2; i < primesAmount; i++){
    for(int o = i + 1; o < primesAmount; o++){
      if(o % i == 0){
        primes.set(o - 1, false); 
      }
    }
  }
  
  primes.set(primesAmount - 1, false); // Because the last number will always be a perfect square to draw the Ulam Spiral, it will never be prime. This way we do not have to worry about edge cases
  
  findDimensions();
  
  for(int i = 1; i < 400; i++){
    eulersPrimes.add((int) (pow(i, 2) - i + 41));
  }
  
}

public void draw(){
  background(255);
  
  drawSquares();
}

public void drawSquares(){
  int xPos = (int) ((boxDim - 1)/ 2);
  int yPos = (int) ((boxDim - 1) / 2);
  int xLength = 2;
  int xTracker = 1;
  int yLength = 2;
  int yTracker = 1;
  int direction = 1;
  for(int i = 0; i < primesAmount; i++){
    if(primes.get(i) == true){
      fill(0); 
    }
    else{
      fill(255); 
    }
    
    for(int x = 0; x < eulersPrimes.size(); x++){
      if(i + 1 == eulersPrimes.get(x) && primes.get(i) == true){
        fill(0, 0, 255); 
      }
    }
    
    if(first == true){
      fill(255, 0, 0); 
      first = false;
    }
    
    rect(xPos * boxWidth, (width - (yPos * boxWidth)) - boxWidth, boxWidth, boxWidth); 
    ////textSize(30);
    //fill(0,0,255);
    //text(i + 1, (xPos * boxWidth) + boxWidth / 2, (width - (yPos * boxWidth)) + boxWidth / 2);
    
    if(xTracker >= xLength){
      direction++;
      xTracker = 1;
      xLength++;
    }
    else if(yTracker >= yLength){
      direction++;
      yTracker = 1;
      yLength++;
    }
    
    
    if(direction == 5){
      direction = 1; 
    }
    
    if(direction == 1){
      xPos++;
      xTracker++;
    }
    else if(direction == 2){
      yPos++; 
      yTracker++;
    }
    else if(direction == 3){
      xPos--; 
      xTracker++;
    }
    else if(direction == 4){
      yPos--; 
      yTracker++;
    }
    
    
  }
  first = true;
}

public void findDimensions(){
  boxDim = (int) sqrt(primesAmount);
  boxWidth = width / boxDim;
}

public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e == 1 && primesAmount > 1){
    primesAmount = (int) pow(sqrt(primesAmount) - 1, 2); 
  }
  else if(e == -1 && primesAmount < 100000){
    
    primesAmount = (int) pow(sqrt(primesAmount) + 1, 2); 
    if(primesAmount >= 100000){
      primesAmount = 100000; 
    }
  }
  findDimensions();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "UlamSpiral" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
