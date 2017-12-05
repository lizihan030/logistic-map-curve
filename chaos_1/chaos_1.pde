             //the original play speed
PImage[] images;
int i=0;
int count=0;
boolean run=true;
PImage[][] lines;
float a=3.95;
float ch= 0.892;

import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput output;
FilePlayer groove;
HighPassSP hpf;



void setup() {
  size(1080,712);
  images=new PImage[2789];
    lines = new PImage[2789][356];
  for (int i=0; i<images.length; i++) {        //loading a sequence of images
    String filename="a_"+i+".jpg";            //because my images' name is from 1~66
    images[i]=loadImage(filename);
   // image(images[i],0,0,600,600);
      for (int j = 0; j < 356; j++) {
    lines[i][j] = images[i].get(0, j, 640, 1);
  }
  }

minim = new Minim(this);
  output = minim.getLineOut();
  groove = new FilePlayer( minim.loadFileStream("1.mp3") );
  
  // make a low pass filter with a cutoff frequency of 100 Hz
  // the second argument is the sample rate of the audio that will be filtered
  // it is required to correctly compute values used by the filter
  hpf = new HighPassSP(1000, output.sampleRate());
  groove.patch( hpf ).patch( output );
  
  groove.loop();

}

void draw() {
  background(0);
 // image(images[j], 600, 100, 341, 300);    //text instrctions
  fill(255);
  if (run) {
                        //every Ts display an image
        i++;
        count=0;
        if (i>2788) { 
          i=0;
        }
      } 
    
float mouse = constrain(mouseX,0,width);    
 
 for(int b=0; b<356; b++){
   ch = chaos(ch,b);
   
   
   lines[i][b].loadPixels();
   for(int x=0; x<640 ;x++){
  for(int y = 0; y<1;y++){
     int pos = 640 *y +x;
     color c=lines[i][b].pixels[pos];
     float r = red(c);
     float g = green(c);
     float blue = blue(c);
     r = map(mouse,0,width,r,blue);
     g = map(mouse,0,width,g,blue);
     //blue = map(mouse,0,width,blue,r);
     color newc = color(r,g,blue);
     lines[i][b].pixels[pos] = newc;
   }
   }
   lines[i][b].updatePixels();
   
 image(lines[i][b],ch*200-200,b*2,1280,2); 
 }
 a = map(mouseX,0,width,1,4);
 if(mouseX<0)mouseX=0;
 else if(mouseX>width)mouseX=width;



  float q = map(mouseX, 0,width,0,8000);

  float cutoff = ch *q;
  hpf.setFreq(cutoff);


}


float chaos(float i, int s){
 for(int k=0; k<s; k++){
  i = a*i *(1-i); 
 }
 return i;
}