class Person{
  
  PImage [] img = new PImage[8];
  float status = 50.0;
  
  Person(){
  
    img[0] = loadImage("face/happy-3.png");
    img[1] = loadImage("face/happy-2.png"); 
    img[2] = loadImage("face/happy-1.png");
    
    img[3] = loadImage("face/serious-1.png");
    img[4] = loadImage("face/serious-2.png");
    
    img[5] = loadImage("face/angry-1.png");
    img[6] = loadImage("face/angry-2.png");
    img[7] = loadImage("face/angry-3.png");
    
  }
  
  void changeStatus(float num){
    status += num;
    if (status > 100.0) status = 100.0;
    else if (status < 0.0) status = 0.0;
  }  
}
