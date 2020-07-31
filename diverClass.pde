
class diverClass

{

  int imgWidth;
  int imgHeight;

  float diverX;
  float diverY;
  float speed;

  // we define and create where we are to store 
  // the sky diver image
  PImage img1, img2, img3, img4, image;





  //Constructor for the diver class
  // the 'this' refers to the members
  //declared abaove
  diverClass(float diverX, float diverY)

  {
    this.diverX = diverX;
    this.diverY = diverY;
    speed = 2.5;


    //load image into variable
    //img1-img4 will store the colours/different states 
    // of the diver
    // we then resize the images 

    img1 = loadImage("images/skydiver.png");
    img1.resize(145, 75);


    img2 = loadImage("images/skyDiverBrown.png");
    img2.resize(145, 75);

    img3 = loadImage("images/skyDiverGrey.png");
    img3.resize(145, 75);

    img4 = loadImage("images/skyDiverRed.png");
    img4.resize(145, 75);
  }




  void render()


  {
    /********* Crash Sequence and Behaviour *********/
    //The skyDiver will change colour 
    // when it crashes into an obstacle
    // the code below uses the current health
    // of sky diver to determine colour of sky diver
    if (currentHealth == fullHealth) {
      image = img1;
    } else if (currentHealth >= 70)

    {
      image = img2;
    } else if (currentHealth >= 40)

    {
      image = img3;
    } else {

      image = img4;
    }


    image(image, diverX, diverY);
    getImageDimension(image);
  }


  void getImageDimension(PImage image) {
    imgWidth = image.width;
    imgHeight = image.height;
  }



  // key pressed events 
  // Up, Down Left and Right keys
  // allows the user to play
  // The sky diver will move by certain values
  // along, up and down the screen
  void keyPressed()

  {
    if (key ==CODED)  
    {
      if (keyCode ==UP && diverY>=10)
      {
        diverY = diverY-(speed+4);
      }

      if (keyCode == DOWN && diverY<=840)
      {
        diverY = diverY+(speed+2);
      }


      if (keyCode == LEFT && diverX>=10)
      {
        diverX = diverX-(speed+2);
      }

      if (keyCode == RIGHT && diverX<=950)
      {
        diverX = diverX+(speed+2);
      }
    }
  }

  //collsion detection
  //impliments the Rectangle to Rectangle algorithm
  //used for the different types of obstacles
  boolean checkCollision(balloonClass other)

  {
    return (diverX + imgWidth >= other.obstacleX &&
      diverX <= other.obstacleX + other.imgWidth &&
      diverY + imgHeight >= other.obstacleY &&
      diverY <= other.obstacleY + other.imgHeight);
  }


  //checks for collision between diver and the 
  // point(star)
  boolean checkCollision(pointsClass other)

  {
    return(diverX + imgWidth >= other.pointX &&
      diverX <= other.pointX + other.imgWidth &&
      diverY + imgHeight >= other.pointY &&
      diverY <= other.pointY + other.imgHeight);
  }

   //checks for collision between diver and a 
  // bird
  boolean checkCollision(birdClass other)

  {
    return(diverX + imgWidth >= other.obstacleX && 
      diverX <= other.obstacleX + other.imgWidth && diverY + 
      imgHeight >= other.obstacleY &&
      diverY <= other.obstacleY + other.imgHeight);
  }



  // update procedure used to limit amount of code 
  // calls render() and keyPressed() procedures
  //keyPressed() determines the movement of the diver
  // when certain keys are click
  void update()

  {
    render();
    keyPressed();
  }
}
