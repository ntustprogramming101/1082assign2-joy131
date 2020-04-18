PImage bgImg;
PImage gameover;
PImage title;

PImage groundhogIdle;
PImage groundhogDown;
PImage groundhogLeft;
PImage groundhogRight;

PImage life;
//PImage robot;
PImage soil;
PImage soldier;
PImage cabbage;

PImage restartNormal,  restartHovered, startHovered, startNormal;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_OVER = 3;
int gameState = GAME_START;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed =false;
boolean rightPressed =false;





//int laserX; //Laser edge point 1 (right)
//int laserX2; //Laer edge point 2 (left)

//int laserLength = 40;

//int robotPositionX;
//int robotPositionY;

int soldierX; //soldier position X
int soldierY; // soldier position Y


final int hogStartPositionX = 320;
final int hogStartPositionY = 80;
int hogX, hogY;


int hogUp, hogDown, hogLeft, hogRight;

int soldierUp, soldierDown, soldierLeft, soldierRight;

int LifeCount, cabbagePositionX, cabbagePositionY ;
int cabbageUP, cabbageDOWN, cabbageLEFT, cabbageRIGHT ;
boolean cabbageImg = true;


void GameRunSetup(){
    soldierX = 0; //soldier


    hogX=hogStartPositionX;
    hogY=hogStartPositionY;
    //robotPositionX = int(random(100,500));// robot ramdom in x (there are 5 boxes)
    //int y_robotCase = int(random(0,3.99)); // between 0,1,2,3 (soil)
    int x_cabbageCase =int(random(0,7.99));
    int y_soldierCase= int(random(0,3.99)); //between 0,1,2,3 (soil)
     int y_cabbageCase= int(random(0,3.99));
    //robotPositionY =  160 + y_robotCase*80; //160 is sky + random * 1 box(80) 
    soldierY = 160 + y_soldierCase*80; //160 is sky + random * 1 box(80)
    cabbagePositionY = 160 +y_cabbageCase*80;
    cabbagePositionX = x_cabbageCase * 80;
    //laserX = robotPositionX + 25; // Laser point 1 (right) robot hand
    
    LifeCount = 2;
}


void setup() {
  size(640, 480);


  bgImg = loadImage("img/bg.jpg");
  gameover = loadImage("img/gameover.jpg");
  title = loadImage("img/title.jpg"); 

  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");

  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  //robot = loadImage("img/robot.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");

  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage ("img/restartNormal.png");
  startHovered = loadImage ("img/startHovered.png");
  startNormal = loadImage ("img/startNormal.png");
  

}

int movehogUP = 0;
int movehogDOWN = 0;
int movehogLEFT = 0;
int movehogRIGHT = 0;
//hog not moving
boolean allZero(){
  if(movehogUP == 0 && movehogDOWN == 0 && movehogLEFT == 0 && movehogRIGHT == 0){
    return true;
  }
  return false;
}


void zero(){
  movehogUP = 0;
  movehogDOWN = 0;
  movehogLEFT = 0;
  movehogRIGHT = 0;
}

void RunDraw()
{
//------CALCULATIONS ------//



   //moving 15 frames 
  if(movehogUP>0){
    hogY -=80.0/15.0;
  }  else if (movehogDOWN>0){
    hogY +=80.0/15.0;
  }  else if (movehogLEFT>0){
    hogX -=80.0/15.0;
  }  else if (movehogRIGHT>0){
    hogX +=80.0/15.0;
  }
  
  
 
  if(movehogDOWN > 0) movehogDOWN--;
  if(movehogLEFT > 0) movehogLEFT--;
  if(movehogRIGHT > 0) movehogRIGHT--;
  
  //hog boundary
    if(hogX>560 ){
    hogX=560;
   }
    if(hogX<0){
      hogX=0;
   }
  if(hogY >400 ){
    hogY=400;
  }
  if(hogY<80){
    hogY=80;
  }
  
   //moving soldier
  soldierX+=5;
  
  if(soldierX>width)
  {
    soldierX =  -100;
  }
  
  
  //create hog & soldier collision detection
  hogUp = hogY;
  hogDown = hogY + 79;
  hogLeft = hogX;
  hogRight = hogX + 79;
  
  soldierUp = soldierY;
  soldierDown = soldierY + 79;
  soldierLeft = soldierX;
  soldierRight = soldierX + 79;
  
  //create hog & cabbage collision detection 
  cabbageRIGHT = cabbagePositionX + 79;
  cabbageDOWN = cabbagePositionY + 79;
  cabbageLEFT = cabbagePositionX;
  cabbageUP = cabbagePositionY;
  
  //boolean isColliding = false;
  if(hogUp < soldierDown && hogDown > soldierUp &&
    hogLeft < soldierRight && hogRight > soldierLeft)
  {
      LifeCount -= 1;
      hogX=hogStartPositionX;
      hogY=hogStartPositionY;    
      zero();
  }
  
  //boolean cabbage and hog colliding 
  if (hogDown > cabbageUP && hogLeft < cabbageRIGHT &&
      hogRight > cabbageLEFT)
  {
     
    LifeCount = 3; //only plus one life 
    cabbagePositionX = -width;
    cabbagePositionY =-height;
    
    
     cabbageImg = false; //to make the cabbage disappear after colliding with hog
      
  }
  
  
  
  //println(isColliding);
  

  
  
  //------START DRAWING ------//
  
 //background
  image (bgImg, 0, 0); 

  //sun
  stroke(255,255,0);
  strokeWeight(5);
  fill(253, 184, 19);
  ellipse(590, 50, 120, 120); 
  
 
  
   //soil
  image (soil , 0 , 160); 
  
  //grass
  noStroke();
  fill(124,204,25);
  quad(0,145,640,145,640,160,0,160);  
  
  //hog
   
  if(allZero())image (groundhogIdle , hogX , hogY);
  if(movehogUP > 0)image (groundhogIdle , hogX , hogY);
  if(movehogDOWN > 0)image (groundhogDown , hogX , hogY);
  if(movehogLEFT > 0)image (groundhogLeft , hogX , hogY);
  if(movehogRIGHT > 0)image (groundhogRight , hogX , hogY);
 
  
  // 3 lifes
  
  //image (life , 10, 10);
  //image (life , 80, 10);
  //image (life , 150, 10); 
  for(int i=0;i<LifeCount;i++){  
    image (life , 10 + i * 70, 10);
  }  
  
  
  //draw soldier
  image(soldier, soldierX ,soldierY);
  
   //cabbage
  image(cabbage,cabbagePositionX,cabbagePositionY); 
  //robot
  //image ( robot , robotPositionX , robotPositionY); 
  
  
  //laser 
  //stroke(255,0,0);
  //strokeWeight(10);
  ////laser shooting
  //laserX=laserX-1;
  //if(laserX<robotPositionX-100){
  //laserX = robotPositionX+25;
  //}
  //laserX2 = (laserX + laserLength);
  //if(laserX2 > robotPositionX+25)
  //{
  //  laserX2 = robotPositionX+25;
  //}
  //line(laserX,robotPositionY+37,laserX2,robotPositionY+37); 
 
  
 
 
 
 
 
 
 
 
  if(LifeCount <= 0){
    gameState = GAME_OVER;
  }
}

//mouse detect button and hovering
boolean overRect(int x, int y, int width, int height)  { // over the button 
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true; //result is true
  } else {
    return false;
  }
}

boolean rectOver = false;


void drawMainMenu()
{
  image(title, 0, 0);
  rectOver = overRect(248, 360, 144, 60);
  if(rectOver){
    image(startHovered, 248, 360);
  } else 
  {
    image(startNormal, 248, 360);
  }
  
}

void drawGameOverScene()
{
  image(gameover, 0, 0);
  rectOver = overRect(248, 360, 144, 60);
  if(rectOver){
    image(restartHovered, 248, 360);
  } else 
  {
    image(restartNormal, 248, 360);
  }
  
}


void draw() {
  
  switch (gameState){
      case GAME_START:
        drawMainMenu();
      break;
    
      case GAME_RUN:
        RunDraw();
      break;
    
      case GAME_WIN:
      break;
    
      case GAME_OVER:
      drawGameOverScene();
      break;  
    }
    
   
  }




void mousePressed() {
  if (rectOver  && (gameState == GAME_START || gameState == GAME_OVER)) {
    GameRunSetup();
    gameState = GAME_RUN;
  }
}
    
    
    
    
void keyPressed() {
  if (key == CODED && gameState == GAME_RUN && allZero() ) {
      zero();
      switch( keyCode )
      {
       
        case DOWN:
         downPressed = true;
         movehogDOWN = 15;
          break;
        case LEFT :
        leftPressed = true;
        movehogLEFT = 15;
          break;
        case RIGHT:
        rightPressed = true;
        movehogRIGHT = 15;
        break;     

      }
    }
  }

void keyReleased() {
  if (key == CODED) {
      switch( keyCode )
      { 
        case UP :
        upPressed = false;
        break;
        case DOWN :
        downPressed = false;
        break;
        case LEFT :
        leftPressed = false;
        break;
        case RIGHT :
        rightPressed = false ;
        break;
      }
    }
  }
