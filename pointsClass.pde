
//points 

class pointsClass {

  int imgWidth;
  int imgHeight;

  float pointX;
  float pointY;

  int speed = 2;
  PImage star, image;

  pointsClass(float pointX, float pointY)

  {
    this.pointX = pointX;
    this.pointY = pointY;

    star = loadImage("images/star2.png");
    star.resize(45, 45);
  }

  void render()

  {
    image = star;
    image(image, pointX, pointY);
    getImageDimension(image);
  }
  
  
  

  void getImageDimension(PImage image) {
    imgWidth = image.width;
    imgHeight = image.height;
  }

  void move() {
    pointY -= speed + 2.5 ;

    if (pointY <= -90 )

    {
      pointY = (background.height-20) - speed;
    }
  }

  void update() {

    render();
    move();
  }
}
