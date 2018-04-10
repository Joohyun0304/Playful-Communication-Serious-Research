import org.openkinect.processing.*;



// The kinect stuff is happening in another class
  Kinect2 kinect2;
 float min = 100 ; 
 float max = 2200 ; 
 PImage img ;
 int scaleValue ;
 float d ;

float volume;


void setup() {
  //fullScreen(FX2D);
  //fullScreen(P3D);
  size(1024, 848);
  
  noCursor();
  scaleValue = width/512 ;
  
    kinect2 = new Kinect2(this);
    kinect2.initDepth();
    kinect2.initDevice();    
    img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);

}

void draw() {
  background(0);
//       fill(0, 20);
//       rect(0, 0, width, height);
       
 //img.loadPixels();
 
int[] depth = kinect2.getRawDepth();
  
float sumX = 0 ; 
float sumY = 0 ; 
float count = 0 ;
float sumX2 = 0 ; 
float sumY2 = 0 ; 
float count2 = 0 ;
float sumX3 = 0 ; 
float sumY3 = 0 ; 
float count3 = 0 ;
float sumX4 = 0 ; 
float sumY4 = 0 ; 
float count4 = 0 ;
float sumX5 = 0 ; 
float sumY5 = 0 ; 
float count5 = 0 ;
float sumX6 = 0 ; 
float sumY6 = 0 ; 
float count6 = 0 ;
float sumX7 = 0 ; 
float sumY7 = 0 ; 
float count7 = 0 ;
float sumX8 = 0 ; 
float sumY8 = 0 ; 
float count8 = 0 ;

 float avgX, avgY, avgX2, avgY2, avgX3, avgY3, avgX4, avgY4 ;
 float avgX5, avgY5, avgX6, avgY6, avgX7, avgY7, avgX8, avgY8 ;

 
    for (int x = 0; x < kinect2.depthWidth; x++) {
      for (int y = 0; y < kinect2.depthHeight; y++) {
        // mirroring image
        int offset = x + y * kinect2.depthWidth;
        // Raw depth
        int rawDepth = depth[offset];
        
        //int clr = get(x, y);
        
        if (rawDepth > min && rawDepth < max && x < kinect2.depthWidth/2 ) {
          
           if (y < kinect2.depthHeight/4 ) {
              img.pixels[offset] = color(0, 0, 200) ; 
          sumX += x; 
          sumY += y;
          count++;
           }
           
            if (y > kinect2.depthHeight/4 && y < kinect2.depthHeight/4*2 ) {
               img.pixels[offset] = color(0, 200, 0) ; 
          sumX2 += x; 
          sumY2 += y;
          count2++;
           }
          
        if (y > kinect2.depthHeight/4*2 && y < kinect2.depthHeight/4*3) {
              //img.pixels[offset] = color(200, 0, 0) ; 
          sumX3 += x; 
          sumY3 += y;
          count3++;
           }

         if (y > kinect2.depthHeight/4*3 && y < kinect2.depthHeight/4*4) {
               //img.pixels[offset] = color(200, 100, 0) ; 
          sumX4 += x; 
          sumY4 += y;
          count4++;
           }
  
        }

         else if (rawDepth > min && rawDepth < max && x >= kinect2.depthWidth/2 ) {
        
           
           if (y < kinect2.depthHeight/4 ) {
              //img.pixels[offset] = color(100, 100, 200) ; 
          sumX5 += x; 
          sumY5 += y;
          count5++;
           }
           
            if (y > kinect2.depthHeight/4 && y < kinect2.depthHeight/4*2 ) {
               //img.pixels[offset] = color(20, 20, 20) ; 
          sumX6 += x; 
          sumY6 += y;
          count6++;
           }
          
        if (y > kinect2.depthHeight/4*2 && y < kinect2.depthHeight/4*3) {
              //img.pixels[offset] = color(20, 150, 200) ; 
          sumX7 += x; 
          sumY7 += y;
          count7++;
           }

         if (y > kinect2.depthHeight/4*3 && y < kinect2.depthHeight/4*4) {
               //img.pixels[offset] = color(0, 150, 60) ; 
          sumX8 += x; 
          sumY8 += y;
          count8++;
           }
          
          
          
        }
        else {
          img.pixels[offset] = color(0);
        }
      }
    }
    img.updatePixels();
    image(img, 0, 0, width, height);

  
  
  
avgX = sumX / count * scaleValue ;
avgY = sumY / count *scaleValue ;
avgX2 = sumX2 / count2 *scaleValue ;
avgY2 = sumY2 / count2 * scaleValue ;
avgX3 = sumX3 / count3 *scaleValue ;
avgY3 = sumY3 / count3 * scaleValue ;
avgX4 = sumX4 / count4 *scaleValue ;
avgY4 = sumY4 / count4 * scaleValue ;
avgX5 = sumX5 / count5 *scaleValue ;
avgY5 = sumY5 / count5 * scaleValue ;
avgX6 = sumX6 / count6 *scaleValue ;
avgY6 = sumY6 / count6 * scaleValue ;
avgX7 = sumX7 / count7 *scaleValue ;
avgY7 = sumY7 / count7 * scaleValue ;
avgX8 = sumX8 / count8 *scaleValue ;
avgY8 = sumY8 / count8 * scaleValue ;


float minimum = 6000 ;

float excitation = 0 ; 
boolean e1 = false; 
boolean e2 = false; 


if (count > minimum && 100 < avgX && avgX<200 && 50<avgY && avgY<150){
  e1 = true;
  //println("Hello");
}

if (count2 > minimum && 100 < avgX2 && avgX2<200 && 300<avgY2 && avgY2<400){
  e2 = true ; 
  //println("Hello");
}


if (e1) {
     excitation += 1 ; 
}

if (e2) {
     excitation += 1 ; 
}


println(excitation);



fill(200, 0, 0);
rect(100, 50, 100, 100);
rect(100, 300, 100, 100);


       noStroke();

        fill(84, 100, 200);
      ellipse(avgX, avgY, 20, 20);
      ellipse(avgX2, avgY2, 20, 20);
      ellipse(avgX3, avgY3, 20, 20);
      ellipse(avgX4, avgY4, 20, 20);
      ellipse(avgX5, avgY5, 20, 20);
      ellipse(avgX6, avgY6, 20, 20);
      ellipse(avgX7, avgY7, 20, 20);
      ellipse(avgX8, avgY8, 20, 20);
}