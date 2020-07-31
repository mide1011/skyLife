
/********* Declaration of VARIABLES & Constants *********/

//To store images
//the class contains fields to edit image
PImage splash, gameOverscreen, nextLevel, background;

//scrollling backgorund speed
int bgY=0;



//create an arrayList to store 
//obstacles; balloons and birds



ArrayList balloons = new ArrayList();
ArrayList birds = new ArrayList();
ArrayList points = new ArrayList();

//To control which screen should
//load, we update the variable gameMode

// INTRO  : Start Screen
// PLAYIN : Game Screen
// FINISH : End game Screen
// LEVEL  : Level game Screen

final int INTRO = 0;
final int PLAYIN = 1;
final int FINISH = 2;
final int LEVEL = 3;

//set current game mode to
//splash page 
int gameMode = INTRO; 


float coordX;
float coordY; 
float moveX;
float moveY;

//objects of new type diverClass,balloonClass,birdClass
diverClass skyDiver1;
balloonClass balloon1;
birdClass bird1;
pointsClass star;

//health bar
//the player will have a maximum of 5 lives
int fullHealth = 100;
float currentHealth = 100;
float healthDecrease =20;
int healthBarWidth = 120;

//variable to keep score 
int score = 0;

// inital level set to 1
int level = 1;


//this game varaible
// will help to determine
//the diffculty of the level
//by deciding the amount of obstacles
//and points that will appear on the screen
//when the user is playing
int gameVar = 2;

//varaiable used to determine
// the amount of points
//player needs to move 
//onto the next level
int pointVar = 5;






/********* SETUP BLOCK *********/
void setup()

{
  //Setup screen size,game background and obstacles
  size(1110, 920);

  splash = loadImage("images/splash.jpg");
  splash.resize(width, height);

  gameOverscreen = loadImage("images/gameOver.jpg");
  gameOverscreen.resize(width, height);

  nextLevel = loadImage("images/nextLevel.jpg");
  nextLevel.resize(width, height);

  background = loadImage("images/skybg.png");
  background.resize(width, height);







  //ArrayList balloons, birds and points
  //elements are appended into these ArrayLists
  //each element will have unique member values with the use 
  //of the "random" funtion

  for (int i = 0; i < gameVar; i++)
  {
    coordX = random(50, 800);
    coordY = random(650, 1200);
    moveX = random(-2);
    moveY = random(3, 6);
    
  
    balloon1 = new balloonClass(coordX, coordY, moveX, (int)moveY );
    balloons.add(balloon1);
  }


  for (int i = 0; i < gameVar-1; i++)
  {
    coordX = random(250, 800);
    coordY = random(550, 750);
    moveX = random(-3);
    moveY = random(1, 5);

    bird1 = new birdClass(coordX, coordY, moveX, (int)moveY );
    birds.add(bird1);
  }

  for ( int i = 0; i< gameVar-1; i++)

  {
    coordX = random(100, 900);
    coordY = random(380, 950);



    star = new pointsClass(coordX, coordY);
    points.add(star);
  }

  // create an instance of the diverClass
  // therefore creating an object
  // "skyDiver"
  skyDiver1 = new diverClass(500, 175);
}







/********* DRAW BLOCK *********/
void draw()

{
  // Display screen depending on the variable gameMode
  // a procedure will be called depending of the value of
  //gameMode


  if (gameMode == INTRO)

  {
    introScreen();
  }


  if (gameMode == PLAYIN) {

    gameScreen();
  }


  if (gameMode == FINISH) {

    endGame();
  }



  if (gameMode == LEVEL) {

    setLevel();
  }
}




/********* SCREEN CONTENTS *********/


//splash page
//explains how the game works 
// to the user
void introScreen() {
  gameMode = INTRO;

  image(splash, 0, 0);

  textAlign(CENTER);
  textSize(60);
  fill(236, 240, 241);
  text("Aim of the game: ", width/2, 400);
  textSize(40);
  text("Avoid obstacles in your way: ", width/2, 500);
  text("Collect the stars to score points", width/2, 600);
  text("Levels will get more difficult", width/2, 700);

  text("Click to Start", width/2, 800);
}



//Game screen 
//contains contents when gameMode is playing
// the game screen will load the sky diver, healthbar
//the current score and the level

void gameScreen()

{
  gameMode = PLAYIN;
  scrollBackground();
  healthBar();
  skyDiver1.update();
  printScore();
  setLevel();
  printLevel();






  // to create behaviours/ movements of obstacles 
  // first we create an object of the class 
  //then we loop through each item in the differnt array lists
  //access the 'update' procedure which will cause the obstacle to move 
  for (int i = 0; i < balloons.size(); i++)

  {
    balloonClass myBalloon = (balloonClass)balloons.get(i);
    myBalloon.update();
  }


  for (int i = 0; i < birds.size(); i++)

  {
    birdClass bird = (birdClass)birds.get(i);
    bird.update();
  }

  for (int i = 0; i < points.size(); i++)

  {
    pointsClass star = (pointsClass)points.get(i);
    star.update();

    //when the diver collides with a star
    // call countScore() to add an extra score
    // the X and Y position will change of the star
    // and the star will appear below the screen size
    //creating the effect of the star disappearing

    if (skyDiver1.checkCollision(star))

    { 

      countScore();
      star.pointX = random(100, 900);
      star.pointY = random(-200, -700);
    }
  }



  int balloonslength = balloons.size();
  int birdslength = birds.size();



  for (int i = 0; i < balloonslength; i++) {

    balloonClass obstacle1 = (balloonClass)balloons.get(i);

    if (skyDiver1.checkCollision(obstacle1))



    { //create the effect of obstacle disappearing
      //after the diver collides 
      //decrease health
      //access the members obstacleX and obstacleY
      // to manipulate x and y position
      obstacle1.obstacleX = random(500, 900);
      obstacle1.obstacleY = random(-300, -750);
      decreaseHealth();
    }
  }


  for (int i = 0; i < birdslength; i++) {

    birdClass bird = (birdClass)birds.get(i);

    if (skyDiver1.checkCollision(bird))

    { 
      bird.obstacleX = random(300, 900);
      bird.obstacleY = random(-400, -750);
      decreaseHealth();
    }
  }
}





//screen when the player dies
// load end game page 
// show the score and level 
// give option to restart game
void  endGame() {
  gameMode = FINISH;


  image(gameOverscreen, 0, 0);

  textAlign(CENTER);
  textSize(60);
  fill(236, 240, 241);
  text("Your Score: " + score, width/2, 500);
  text("You Reached Level: " + level, width/2, 600);
  text("Click to Restart", width/2, 700);
}


// procedure will set the level
// depending on the value of the score 
void setLevel() {



  if ( score >= pointVar) {
    gameMode = LEVEL;


    image(nextLevel, 0, 0);




    textAlign(CENTER);
    textSize(60);
    fill(236, 240, 241);
    text("LEVEL: " + (level+1), width/2, 500);
    text("Click to Start", width/2, 600);

    // when user clicks on page 
    // increment gameVar by 1 which will help increase number
    // of obstacles in the next level


    if (mousePressed == true) {
      //increase level difficulty by adding an extra 
      //element to the obstacles (balloons and birds) arraylists
      //double the amount of points the player needs to move 
      //onto the next level
      gameVar = gameVar +1;
      pointVar= pointVar * 2;
      level = level +1;
      reset();
    }
  }
}





//print current level
void printLevel() {
  fill(236, 240, 241);
  textAlign(CENTER);
  textSize(30); 
  text("Level: "+ level, width/2, background.height - 50);
}



//create healthbar
//create dynamic healthbar

void healthBar()

{

  //will disable outlines when drawing  
  noStroke();

  //draws a green rectangle
  fill(236, 240, 241);
  rect(120, 40, healthBarWidth, 30);


  textAlign(CENTER);
  textSize(25);
  fill(236, 240, 241);
  text("Health", 50, 65);

  //change colour of healthbar
  // depending on the value of currenthealth
  // will turn amber for values 40 or less than 60 and red for values
  //below

  if (currentHealth >= 70) {
    fill(46, 204, 113);
  } else if (currentHealth >= 40) {
    fill(230, 126, 34);
  } else {
    fill(231, 76, 60);
  }
  rect(120, 40, healthBarWidth*(currentHealth/fullHealth), 30);
}


//procedure to reduce health of player
//called when diver collides with obstacle 
void decreaseHealth() {

  currentHealth = currentHealth - healthDecrease;

  //end game when play health is
  //equal to zero
  if (currentHealth == 0) {

    endGame();
  }
}

// procedure to calculate score 
void countScore()

{
  score +=1;
}

//procedure to print score
void printScore()
{

  textAlign(CENTER);
  fill(0);
  textSize(50); 
  text(score, background.width/2, 50);
}


//restart procedure
// sets all varaibles to initial value
//empties array lists
void restart() {
  gameVar = 2;
  score = 0;
  level = 1;
  pointVar = 5;
  currentHealth = fullHealth;
  gameScreen();
  balloons.clear();
  birds.clear();
  points.clear();
  setup();
}

// restart the level but not game

void reset() {
  currentHealth = fullHealth;
  gameScreen();
  balloons.clear();
  birds.clear();
  points.clear();
  setup();
}


/********* BACKGROUND *********/

//load two background image
//position them on top of each other
//byY varaiable determines the speed
// at which the scrolling effect happens
void scrollBackground()

{
  image(background, 0, bgY); 
  image(background, 0, bgY + background.height);
  bgY -=5;
  if (bgY == -background.height) 
  {
    bgY=0;
  }
}



/********* GameModes *********/
public void mousePressed() {

  if (gameMode ==0) {

    gameMode = 1;
  }

  if (gameMode == 2) {

    restart();
  }
}
