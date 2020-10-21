import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FarAway extends PApplet {

int status = 1;    //  Status 流程
PImage BG;    // BG = 背景
PImage PF;    // P = 主角 , F = 視角變數 1 ~ 9
PImage gameStart;   //遊戲開始按鈕
PImage mapL;    //左側地圖
PImage mapC;    //中間地圖
PImage mapR;    //右側地圖
PImage textureBlock;    //地圖物件圖片
PImage theFloor;    //地圖地板
PImage test;    //test = 測試用

boolean onBotton = false;   // 游標位置判定

int jumpTime = 0;   //跳躍的時間計算

boolean PressRight = false;    //多重判斷用, 向右
boolean PressLeft = false;    //多重判斷用, 向左
boolean PressUp = false;    //多重判斷用, 向上
boolean jump = false;       //Jump() 中向上階段
boolean fall = false;       //Jump() 中向下階段

boolean fallDown = false; // 判定腳色掉落

int playerX = 540;    //玩家位置
int playerY = 510;    //玩家位置
int mapNumber = 1;    //地圖編號
int mapSpeed = 0;

class player
{
    int x, y, playerFace, walkSpeed, fallTime;

    player()
    {
        x = 540;
        y = 420;
        playerFace = 5;
        walkSpeed = 0;
        fallTime = 0;
    }

    public void playerMove(mapIndicate b)
    {
        if(PressUp == true)
        {
            if(PressRight == true && PressLeft == true)
            {
                walkSpeed = 0;
                Jump();
                playerFace = 2;
                if(fall == true)
                {
                    playerFace = 8;
                }
            }
            else if(PressRight == true)
            {
                walkSpeed = 7;
                Jump();
                playerFace = 3;
                if(fall == true)
                {
                    playerFace = 9;
                }
            }
            else if(PressLeft == true)
            {
                walkSpeed = -7;
                Jump();
                playerFace = 1;
                if(fall == true)
                {
                    playerFace = 7;
                }
            }
            else
            {
                walkSpeed = 0;
                Jump();
                playerFace = 2;
                if(fall == true)
                {
                    playerFace = 8;
                }
            }
            PlayerFace();
        }
        else
        {
            if(fallDown == true)
            {
                if(PressRight == true && PressLeft == true)
                {
                    playerFace = 8;
                    walkSpeed = 0;
                    Fall();
                }
                else if(PressRight == true)
                {
                    playerFace = 9;
                    walkSpeed = 7;
                    Fall();
                }
                else if(PressLeft == true)
                {
                    playerFace = 7;
                    walkSpeed = -7;
                    Fall();
                }
                else
                {
                    playerFace = 8;
                    walkSpeed = 0;
                    Fall();
                }
                PlayerFace();
            }
            else
            {
                if(PressRight == true && PressLeft == true)
                {
                    playerFace = 5;
                    walkSpeed = 0;
                }
                else if(PressRight == true)
                {
                    playerFace = 6;
                    walkSpeed = 7;
                }
                else if(PressLeft == true)
                {
                    playerFace = 4;
                    walkSpeed = -7;
                }
                else
                {
                    playerFace = 5;
                    walkSpeed = 0;
                }
                PlayerFace();
            }
        }
        if(x > 640)
        {
            if(walkSpeed > 0)
            {
                mapSpeed = walkSpeed;
            }
            if(walkSpeed == 0)
            {
                mapSpeed = 0;
            }
            if(walkSpeed < 0)
            {
                x = x + walkSpeed;
            }
            if(b.x <= -6400 && x <= 1180)
            {
                mapSpeed = 0;
                x = x + walkSpeed;
                if(x > 1180)
                {
                    x = 1180;
                }
            }
            b.mapMove();
            start.display(b);
            end.display(b);
        }
        if(x < 100)
        {
            if(walkSpeed > 0)
            {
                x = x + walkSpeed;
            }
            if(walkSpeed == 0)
            {
                mapSpeed = 0;
            }
            if(walkSpeed < 0)
            {
                mapSpeed = walkSpeed;
            }
            if(b.x >= 0 && x >= 0)
            {
                mapSpeed = 0;
                x = x + walkSpeed;
                if(x < 0)
                {
                    x = 0;
                }
            }
            b.mapMove();
            start.display(b);
            end.display(b);
        }
        if(x >= 100 && x <= 640)
        {
            mapSpeed = 0;
            x = x + walkSpeed;
        }
    }
    
    public void display()
    {
        image(PF, x, y);
    }

    public void PlayerFace()
    {
        switch(playerFace)
        {
        case 1:
            PF = loadImage("p1.png");
            break;
        case 2:
            PF = loadImage("p2.png");
            break;
        case 3:
            PF = loadImage("p3.png");
            break;
        case 4:
            PF = loadImage("p4.png");
            break;
        case 5:
            PF = loadImage("p5.png");
            break;
        case 6:
            PF = loadImage("p6.png");
            break;
        case 7:
            PF = loadImage("p7.png");
            break;
        case 8:
            PF = loadImage("p8.png");
            break;
        case 9:
            PF = loadImage("p9.png");
            break;
        }
    }

    public void Jump()
    {
        jumpTime ++;
        if(jumpTime >= 1 && jumpTime <= 10)
        {
            y -= 14;
        }
        if(jumpTime >= 11 && jumpTime <= 15)
        {
            y -= 9;
        }
        if(jumpTime >= 16 && jumpTime <= 17)
        {
            y -= 6;
        }
        if(jumpTime == 18)
        {
            y -= 3;
            jump = false;
            fall = true;
        }
        if(jumpTime == 19)
        {
            y += 3;
        }
        if(jumpTime >= 20 && jumpTime <= 21)
        {
            y += 6;
        }
        if(jumpTime >= 22 && jumpTime <= 26)
        {
            y += 9;
        }
        if(jumpTime >= 27 && jumpTime < 36)
        {
            y += 14;
        }
        if(jumpTime == 36)
        {
            y += 14;
            fall = false;
            PressUp = false;
            jumpTime = 0;
        }
    }   

    public void Fall()
    {
        if(fallDown == true)
        {
            if(fallTime < 9)
            {
                fallTime ++;
            }
            switch(fallTime)
            {
                case 1 :
                    y -= 3;
                    break;
                case 2 :
                    y -= 6;
                    break;
                case 3 :
                    y -= 6;
                    break;
                case 4 :
                    y -= 9;
                    break;
                case 5 :
                    y -= 9;
                    break;
                case 6 :
                    y -= 9;
                    break;
                case 7 :
                    y -= 9;
                    break;
                case 8 :
                    y -= 9;
                    break;
                case 9 :
                    y -= 14;
                    break;
            }
        }
    }
}


class mapIndicate
{
    int x, x_2;
    mapIndicate()
    {
        x = 0;
        x_2 = 2560;
    }

    public void mapMove()
    {
        x = x - mapSpeed;
        if(x > 0)
        {
            x = 0;
            image(mapL, x, 0);
        }
        else if(x <= 0 && x > -1280)
        {
            image(mapL, x, 0);
        }
        else if(x <= -1280 && x > -3840)
        {
            x_2 = x + 2560;
            image(mapL, x, 0);
            image(mapC, x_2, 0);
        }
        else if(x <= -3840 && x >= -6400) 
        {
            x_2 = x + 5120;
            image(mapC, x + 2560, 0);
            image(mapR, x_2, 0);
        }
        else if(x < -6400)
        {
            x = -6400;
            x_2 = x + 5120;
            image(mapR, x_2, 0);
        }
    }
}

class floor
{
    int x, y, x_2;
    floor(int a, int b)
    {
        this.x = a;
        this.y = b;
        x_2 = 0;
    }

    public void display(mapIndicate b)
    {

        x_2 = x + b.x;
        beginShape();   //圖形開始
        texture(theFloor);
        vertex(x_2, y, 0, 0);
        vertex(x_2+500, y, 500, 0);
        vertex(x_2+500, y+200, 500, 200);
        vertex(x_2, y+200, 0, 200);
        endShape();
    }
}


mapIndicate b = new mapIndicate(); 
player e = new player();
floor start = new floor(0, 520);
floor end = new floor(7180, 520);


public void setup()
{
    
    BG = loadImage("cover.jpg");
    PF = loadImage("p5.png");
    gameStart = loadImage("startbotton-1.png");
    mapL = loadImage("map-1.jpg");
    mapC = loadImage("map-2.jpg");
    mapR = loadImage("map-3.jpg");
    textureBlock = loadImage("block.png");
    theFloor = loadImage("theFloor.png");
    image(BG, 0, 0);
}

public void draw()
{
    switch(status)
    {
        case 1 :    //遊戲選單
            GameManu();
            break;
        case 2 :    //遊戲畫面
            b.mapMove();
            start.display(b);
            end.display(b);
            e.playerMove(b);
            e.display();
            break;
    }
}

public void keyPressed()
{
  switch(keyCode)
  {
  case LEFT:
    PressLeft = true;
    break;
  case RIGHT:
    PressRight = true;
    break;
  case UP:
    PressUp = true;
    break;
  }
}

public void keyReleased()
{
  switch(keyCode)
  {
  case LEFT:
    PressLeft = false;
    break;
  case RIGHT:
    PressRight = false;
    break;
  }
}

public void mousePressed()
{
    if(onBotton == true && mouseButton == LEFT)
    {
        status = 2;
    }
}

public void GameManu()
{
    if(abs(mouseX - 880) <= 150 && abs(mouseY - 520) <= 50)
    {
        gameStart = loadImage("startbotton-2.png");
        image(BG, 0, 0);  
        noStroke();
        beginShape();   //遊戲開始的按鈕
        texture(gameStart);
        vertex(725, 465, 0, 0);
        vertex(1035, 465, 310, 0);
        vertex(1035, 555, 310, 90);
        vertex(725, 555, 0, 90);
        endShape();
        onBotton = true;
    }
    else
    {
        gameStart = loadImage("startbotton-1.png");
        image(BG, 0, 0);
        noStroke();
        beginShape();   //遊戲開始的按鈕
        texture(gameStart);
        vertex(730, 470, 0, 0);
        vertex(1030, 470, 300, 0);
        vertex(1030, 550, 300, 80);
        vertex(730, 550, 0, 80);
        endShape();
        onBotton = false;
    }
}
// //use mouse to control the cannon
// //mouse click to shoot
// //'p','q' to increase or decrease the speed
// //'r' to reset
// //when you hit the plane, you get 3 bullet and 100 points
// // for reward
// int remain=20;
// int credit=0;
// int hit=0;
// class plane
// {
//   int x;
//   int y;
//   int flag;
//   int speed;
//   plane(int x,int y)
//   {
//     this.x=x;
//     this.y=y;
//     speed=3;
//     flag=-1;
//   }
//   void fly()
//   {
//       if(flag==-1)
//       {
//         x+=speed;
//         if(x>=600) 
//         {
//           x-=600;
//           y=(int)random(20,300);
//         }
//       }
//      if(flag==1)
//      {
//         flag=-1;
//         x=0;
//         speed++;
//      } 
//   }
//   void crash(cannonball c)
//   {
//     if(dist(x,y,c.x,c.y)<30) 
//     {
//       credit+=100;
//       flag=1;
//       hit=1;
//     }
//   }
//   void display()
//   {
//     if(x<600)
//     {
//       fill(20);
//       rect(x,y,60,20);
//       ellipse(x+15,y,10,20);
//       ellipse(x+15,y+20,10,20);
//     }
//   }
// }
// class cannonball
// {
//   int x;
//   int y;
//   int flag;
//   cannonball()
//   {
//     x=600;
//     y=600;
//     flag=1;//can be fired
//   }
//   void fire(int x,int y)
//   {
//     this.x=x;
//     this.y=y;
//     flag=-1;//fired
//   }
//   void fly()
//   {
//     if(flag==-1) y-=5;
//   }
//   void display()
//   {
//     if(y<600)
//     {
//       fill(100);
//       ellipse(x,y,20,20);
//     }
//   }
// }
// class cannon
// {
//   int x;
//   cannon(int x)
//   {
//     this.x=x;
//   }
//   void display()
//   {
//     fill(0);
//     rect(mouseX,580,40,20);
//     rect(mouseX+10,560,20,40);
//   }
//   void fire(cannonball c)
//   {
//     c.fire(mouseX,580);
//   }
// }
// cannon a=new cannon((int)random(20,500));
// cannonball[] c=new cannonball[20];
// plane p=new plane(0,(int)random(20,200));
// void setup()
// {
//   size(600,600);
//   smooth();
//   background(255);
//   for(int i=0;i<20;i++)
//   {
//      c[i]=new cannonball();
//   }
// }
// void keyPressed()
// {
//   if(key=='r')
//   {
//      remain=20;
//      credit=0;
//      for(int i=0;i<20;i++)
//        c[i]=new cannonball();
//      p.flag=-1;
//      p.speed=3;
//   }
//   if(key=='e') p.speed+=3;
//   if(key=='q')
//   {
//     if(p.speed<=3) return;
//     else p.speed-=3;
//   }
// }
// void mousePressed()
// {
//   int i=0;
//     for(i=0;i<20;i++)
//     {
//       if(c[i].flag==1) break;
//     }
//     if(i==20) return;
//     a.fire(c[i]);
//     remain--;
// }
// void draw()
// {
//   background(255); 
//   a.display();
//   for(int i=0;i<20;i++)
//   {
//     if(c[i].flag==-1) 
//     {
//       c[i].fly();
//       c[i].display();
//     }
//   }
//   for(int i=0;i<20;i++)
//   {
//     p.crash(c[i]);
//   }
//   p.fly();
//   p.display();
//   if(hit==1)
//   {
//     hit=0;
//     int j=5;
//     for(int i=0;i<20;i++)
//     {
//       if(c[i].flag==-1) 
//       {
//         c[i]=new cannonball();
//         j--;
//         remain++;
//         if(j==0) break;
//       }
//     }
//   }
//   textSize(20);
//   text("remain: "+remain,500,50);
//   text("credit: "+credit,500,100);
//   if(remain==0)
//   {
//     textSize(50);
//     text("run out of ammo...",100,150);
//     text("final score is: "+credit,100,220);
//     text("press 'r' to restart..",100,280); 
//   }
  
// }
  public void settings() {  size(1280, 720, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FarAway" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
