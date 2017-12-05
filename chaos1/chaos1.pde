PImage m;
PImage[] lines;

float i = 0.892;
int j = 1;
float oldi;
int oldj;
float a = 3.95;
int count = 0;


void setup(){
  size(1000,800);
  m=loadImage("pic.jpg");
  image(m,0,0,m.width,m.height);
  lines = new PImage[m.height];
  for(int i=0; i<lines.length; i++){
   lines[i] = get(0, i, m.width,1); 
  }
}


void draw(){
  background(200);
  /*
  oldi = i;
  oldj = j;
  i = chaos(i,2);
   j+=5;
  line(oldj,oldi *100,j,i*100);
    count++;
  println("a"+count+":"+i);
 if(j>width){
   background(200);
  j=0;
 }
*/

for(int b=0; b<lines.length; b++){
   i = chaos(i,b);
 image(lines[b],i*200,b,m.width,1); 
 }
 println(i);
 a = map(mouseX,0,width,1,4);

}

float chaos(float i, int s){
 for(int k=0; k<s; k++){
  i = a*i *(1-i); 
 }
 return i;
}