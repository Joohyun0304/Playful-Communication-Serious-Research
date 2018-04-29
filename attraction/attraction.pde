import org.openkinect.processing.*;

  Kinect2 kinect2;
  
int numMov = 2000;

float min = 1000 ; 
 float max = 1500 ; 
 PImage img ;
 int scaleValue ;
 float avgX ;
float avgY ;


Mover[] movers = new Mover[numMov];

void setup() {
   fullScreen(P2D);
   //size(512, 424);
   
   scaleValue = width/512 ;

   
  //size(900, 900);
  //smooth(8);
  strokeWeight(1);
  
   kinect2 = new Kinect2(this);
    kinect2.initDepth();
    kinect2.initDevice();    
    
    img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);

  
  for (int i=0; i<numMov; i++) {
    movers[i] = new Mover();
  }
}



void draw() {
  background(0);
  

  
  
  img.loadPixels();
 
int[] depth = kinect2.getRawDepth();
  
float sumX = 0 ; 
float sumY = 0 ; 
float count = 0 ;
 
    for (int x = 0; x < kinect2.depthWidth; x++) {
      for (int y = 0; y < kinect2.depthHeight; y++) {

        // mirroring image
        int offset = x + y * kinect2.depthWidth;
        // Raw depth
        int rawDepth = depth[offset];
      //int clr = get(x, y);        
 
        if (rawDepth > min && rawDepth < max) {
         //img.pixels[offset] = color(255, 0, 0) ; 
          sumX += x; 
          sumY += y;
          count++; 
        }

        else {
          //img.pixels[offset] = color(0);
        }
      }
    }
    //img.updatePixels();
    //image(img, 0, 0, width, height);
  

if(count > 20000){
 
avgX = sumX / count * scaleValue ;
avgY = sumY / count * scaleValue ;

   fill(50, 100, 250);
    ellipse(avgX, avgY, 20, 20);
}

else {
avgX = width/2;
avgY = height/2;
}

  //print(avgX, avgY);
  //println(count);
  
    for (int i=0; i<numMov; i++) {
    movers[i].run();
  }
  
}



class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topSpeed, sz, d=0;

  Mover() {
    sz = 5;
    location = new PVector(random(sz, width-sz), random(sz, height-sz));
    velocity = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(random(-0.01, 0.01), random(-0.02, 0.02));
    topSpeed = 3;
  }

  void run() {
    update();
    checkEdges();
    display();
  }


  void update() {

    // positioning 
    PVector mouse = new PVector(avgX, avgY);
    
    PVector dir = PVector.sub(mouse, location);
    dir.normalize();
    float distance = mouse.dist(location);
    if (distance<1000) {
      d = map(distance, 0, 1000, 0.2, 0.001);
    }
    if (distance>200) {
      d = 0;
      //velocity.mult(.99);
    }
    dir.mult(d);
    acceleration = dir;

    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);
  }


  void display() {
    fill(0);
    stroke(255);
    ellipse(location.x, location.y, sz, sz);
  }


  void checkEdges() {
    if (location.x<sz/2 || location.x > width-sz/2) {
      velocity.x *= -1;
      acceleration.x *= -1;
    }
    if (location.y<sz/2 || location.y>height-sz/2) {
      velocity.y *= -1;
      acceleration.y *= -1;
    }
  }
}