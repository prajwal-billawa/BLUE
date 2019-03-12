import processing.serial.*;  
Serial myPort;  
String data="";
int val;
int mark = 0;

void setup(){
size(610,610);
background(255);    // Setting the background to white
stroke(0);          // Setting the outline (stroke) to black
fill(150);          // Setting the interior of a shape (fill) to grey 
 
myPort = new Serial(this, "COM5", 9600);
myPort.bufferUntil('\n'); 
}

void draw(){

int col_num = 0; 
for(int x = 0;x < width;x+=38){
  if(col_num % 2 == 0){
    for(int y = 0;y<height;y+=38){
      stroke(0);
      fill(mark);
      rect(x,y,38,38);
      mark+=1;
      } 
    col_num+=1;
    }
   else{
     for(int z=height;z > 0;z-=38){
       stroke(0);
       fill(mark);
       rect(x,z,38,38);
       mark+=1;
       }
     col_num+=1;
     }
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
  
  
