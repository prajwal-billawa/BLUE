import processing.serial.*;  
Serial myPort;
String data="";
int mark=0;
int val;


int cols,rows;
int scl = 20;
int w = 1200;
int h =900;
float flying = 0;

float[][] terrain;


  
void setup(){
  size(800,700,P3D);
  myPort = new Serial(this, "COM8", 9600);
  myPort.bufferUntil('\n'); 

  cols=w/scl;
  rows=h/scl; 
  terrain = new float[cols][rows];
  float yoff=0;
  for(int y =0; y < rows; y++){
    float xoff=0;
    for(int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoff,yoff),0,1,-20-(val*20),20+(val*20));
      xoff+=0.1;
    }
    yoff+=0.1;
  }
  
}


void draw(){
  if(val>12){
    mark = 1;
  }
  else{mark=10;}
  flying +=0.02;
  float yoff = flying;
  for(int y = 0;y < rows;y++){
    float xoff = 0;
    for(int x = 0;x<cols;x++){
      terrain[x][y]=map(noise(xoff,yoff),0,1,-50-(mark*15),50+(mark*15));
      xoff+=0.05;
    
    }
    yoff+=0.05;
  }
  stroke(255);
  noFill();
  background(0);
  translate(width/2,height/2);
  rotateX(PI/3);
  translate(-w/2,-h/2);
  for(int y =0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
      vertex(x*scl,y*scl,terrain[x][y]);
      vertex(x*scl,(y+1)*scl,terrain[x][y+1]);
      //rect(x*scl,y*scl,scl,scl);    
    }
  endShape();  
  }
}



void serialEvent(Serial myPort){

  while (myPort.available() > 0) {
    data = myPort.readStringUntil('\n');
    if (data != null) {
      try {
        val=Integer.parseInt(data.trim());
        println(data);
        println(val);
        println(val-1);
      } catch (NumberFormatException npe){
     
      }
      
    }
  }
}
