//Parent class
//obstacles will inherit from this class



class obstacleClass {

  float obstacleX;
  float obstacleY;
  float speedX;
  float speedY;






  obstacleClass(float obstacleX, float obstacleY, float speedX, float speedY)

  {
    this.obstacleX =obstacleX;
    this.obstacleY = obstacleY;
    this.speedX = speedX;
    this.speedY = speedY;
  }


  //move procedure for obstacles
  void move()

  {

    obstacleX += speedX;
    // obstacle will change x direction
    //when it's x position is less or equal to 50

    if (obstacleX <=50 )

    {
      speedX = -speedX;
    } else if (obstacleX>=1000)

    {
      speedX = - speedX;
    }




    obstacleY -= speedY + 2.5 ;

    if (obstacleY <= -90 )

    {//the Y position of obstacle will start at the bottom 
      // of the screen and work its way up 
      //by subtraction 
      obstacleY = (background.height-20) - speedY;
    }
  }
}
