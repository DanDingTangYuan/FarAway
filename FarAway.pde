int status = 1;    //  Status 流程
PImage BG;    // BG = 背景
PImage PF;    // P = 主角 , F = 視角變數 1 ~ 9
PImage gameStart;   //遊戲開始按鈕
PImage mapL;    //左側地圖
PImage mapC;    //中間地圖
PImage mapR;    //右側地圖
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


// class Block
// {
//     int pX, pY, x, y;
//     Block(int a, int b, int c, int d);
//     {
//         this.pX = a;
//         this.pY = b;
//         this.x = c;
//         this.y = d;
//     }
// }

class mapIndicate
{
    int x, x_2;
    mapIndicate()
    {
        x = 0;
        x_2 = 2560;
    }

    void mapMove()
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
        else if(x <= -3840 && x > -6400) 
        {
            x_2 = x + 5120;
            image(mapC, x + 2560, 0);
            image(mapR, x_2, 0);
        }
        else if(x <= -6400)
        {
            x = -6400;
            x_2 = x + 5120;
            image(mapR, x_2, 0);
        }
    }
}

mapIndicate b = new mapIndicate(); 
player e = new player();


void setup()
{
    size(1280, 720, P2D);
    BG = loadImage("cover.jpg");
    PF = loadImage("p5.png");
    gameStart = loadImage("startbotton-1.png");
    mapL = loadImage("map-1.jpg");
    mapC = loadImage("map-2.jpg");
    mapR = loadImage("map-3.jpg");
    image(BG, 0, 0);
}

void draw()
{
    switch(status)
    {
        case 1 :    //遊戲選單
            GameManu();
            break;
        case 2 :    //遊戲畫面
            b.mapMove();
            e.playerMove(b);
            e.display();
            break;
    }
}

void keyPressed()
{
  switch(keyCode)
  {
  case LEFT:
    PressLeft = true;
    break;
  case RIGHT:
    PressRight = true;
    break;
  case ' ':
    PressUp = true;
    break;
  }
}

void keyReleased()
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

void mousePressed()
{
    if(onBotton == true && mouseButton == LEFT)
    {
        status = 2;
    }
}

void GameManu()
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
