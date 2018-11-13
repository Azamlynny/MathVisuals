short step = 1;
float p1x;
float p2x;
float p1y;
float p2y;
float slope;
float b;
float intersectX;
float intersectY;
float tanSlope;
float tanb;
void setup(){
  size(1980, 1080);
}

void draw(){
  background(255);
  noFill();
  strokeWeight(10);
  ellipse(width/2,height/2,300,300);
  
  strokeWeight(1);
  fill(255, 0, 0);
  ellipse(p1x,p1y, 5, 5);
  ellipse(p2x,p2y, 5, 5);
  
  stroke(127, 255, 255);
  strokeWeight(2);
  drawLine();
  stroke(0);
}

void mouseClicked(){
  if(step == 1){
    p1x = mouseX;
    p1y = mouseY;
  }
  else{
    p2x = mouseX;
    p2y = mouseY;
  }
 
  step++;
  
  if(step > 2){
    step = 1; 
  }
  findLine();
}

void findLine(){ // Finds y=mx+b function modeling the two points
  slope = (p2y - p1y)/(p2x - p1x);
  b = p1y -((float) slope*p1x);
  findIntersection();
}

void drawLine(){
  for(float i = 0; i < 1980; i+= 0.5){
     point(i, (float)( i*slope + b));
  }
  for(float i = 0; i < 1980; i+= 0.5){
     point(i, (float)( i*tanSlope + tanb));
  }
  //float xMax = (1080 - b) / slope;
  //float xMin = (0 - b) / slope;
  //System.out.println(xMax);
  //line(xMin, 0*slope + b, xMax, 0*slope + b);
}

void findIntersection(){ //Finds the intersection of the line and circle
  for(int x = (width/2) - 200; x < (width/2) + 200; x++){ //Use distance formula to find x when the distance from the center of the circle is less than 150
     if(300 <= sqrt(((float)(Math.pow((x - width/2),2) + Math.pow((x * slope + b) - height/2,2))))){
       intersectX = x;
       intersectY = x * slope + b;
       tanSlope = (-intersectX/intersectY);//Derivative of circle y' = -x/y
       tanb = intersectY - (intersectX * tanSlope);
       break;
     }
  }
  
  
}