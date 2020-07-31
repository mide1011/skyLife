// Child class to the obstacleClass
//the birdClass will inherit from the obstacle class
//will inherit members and methods from the obstacleClass
//this the second type of obstacle which contains a flying
//animation seqeunce 
class birdClass extends obstacleClass {

  int counter = 0;
  int imgWidth;
  int imgHeight;


  PImage bird1Left, bird2Left,bird3Left,image;



  birdClass(float obstacleX, float obstacleY, float speedX, float speedY) {
    super(obstacleX, obstacleY, speedX, speedY);
    
    speedY +=15;

  

    bird1Left = loadImage("images/bird1Left.png");
    bird1Left.resize(25, 85);


 
    bird2Left = loadImage("images/bird2Left.png");
    bird2Left.resize(25, 85);

  


    bird3Left = loadImage("images/bird3Left.png");
    bird3Left.resize(25, 85);
  }


  void render()


  {


    // counter will be used to determine 
    // the speed at which the bird image changes
    // get the dimensions of the image
    //used for collision detection,.
    if (counter >= 0 && counter <7)
    {
      image = bird1Left;
      image(bird1Left, obstacleX, obstacleY);
      getImageDimension(image);
    } else if (counter >= 7 && counter <17)
    {
      image = bird2Left;
      image(bird2Left, obstacleX, obstacleY);
      getImageDimension(image);
    } else if (counter>=17 && counter<27)

    { 
      image = bird3Left;
      image(bird3Left, obstacleX, obstacleY);
      getImageDimension(image);
    } else {
      counter = 0;
    }
    //increment counter
    counter++;
  }

 // gets the dimensions of the image
 //in this case the bird image and stores
 // it into varaibles
  void getImageDimension(PImage image) {
    imgWidth = image.width;
    imgHeight = image.height;
  }




  void update()
   
  {
    render(); 
    //form of inheritance using the keyword "super"
    //uses the move() procedure from its parent class 
    //obstacleClass
    //this makes the bird have movement along the X and Y position
    super.move();
  }
}
