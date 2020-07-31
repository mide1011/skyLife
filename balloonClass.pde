
//Child class of the obstacleClass
// will inherit its members and methods

class balloonClass extends obstacleClass {




  PImage greenBalloon;
  PImage redBalloon;
  PImage image;

  int imgWidth;
  int imgHeight;


  /********* Constructor *********/
  balloonClass(float obstacleX, float obstacleY, float speedX, float speedY) {
    super(obstacleX, obstacleY, speedX, speedY);


    //load image to the Pimage variable
    greenBalloon = loadImage("images/greenB.png");
    greenBalloon.resize(45, 115);
  }





  void render()


  { // store Pimage into image variable
    image = greenBalloon;
    image(image, obstacleX, obstacleY);

    // the function will calculate the 
    // width and height of the image
    // essential calulation for collision detection
    getImageDimension(image);
  }



  void getImageDimension(PImage image) {
    imgWidth = image.width;
    imgHeight = image.height;
  }




  void update()

  {
    render(); 
    super.move();
  }
}
