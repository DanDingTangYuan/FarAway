int status = 1;    //  Status 流程
PImage BG;    // BG = 背景
PImage PF;    // P = 主角 , F = 視角變數 1 ~ 9
PImage gameStart;   //遊戲開始按鈕
PImage mapL;    //左側地圖
PImage mapC;    //中間地圖
PImage mapR;    //右側地圖
PImage textureBlock;    //地圖物件圖片
PImage theFloor;    //地圖地板

boolean onBotton = false;   // 游標位置判定

int jumpTime = 0;   //跳躍的時間計算

boolean PressRight = false;    //多重判斷用, 向右
boolean PressLeft = false;    //多重判斷用, 向左
boolean PressUp = false;    //多重判斷用, 向上
boolean jump = false;       //Jump() 中向上階段
boolean fall = false;       //Jump() 中向下階段

boolean fallDown = false; // 判定腳色掉落

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

    void playerMove(mapIndicate b)
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
    
    void display()
    {
        image(PF, x, y);
    }

    void PlayerFace()
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

    void Jump()
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

    void Fall()
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

    void display(mapIndicate b)
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

class theBlock
{
    int x, y, x_2;
    theBlock()
    {
        x = 0;
        y = 0;
        x_2 = 0;
    }

    void setting(int x, int y)
    {
        this.x = x;
        this.y = y;
    }

    void display(mapIndicate b)
    {
        x_2 = x + b.x;
        beginShape();   //圖形開始
        texture(textureBlock);
        vertex(x_2, y, 0, 0);
        vertex(x_2+100, y, 100, 0);
        vertex(x_2+100, y+100, 100, 100);
        vertex(x_2, y+100, 0, 100);
        endShape();
    }
}



mapIndicate b = new mapIndicate(); 
player e = new player();
floor start = new floor(0, 520);
floor end = new floor(7180, 520);
theBlock[] bk = new theBlock[37];

void setup()
{
    setuptheblock();
    size(1280, 720, P2D);
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

void draw()
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
            judgment();
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
  case UP:
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

void setuptheblock()
{
    bk[0].setting(700, 520);
    bk[1].setting(800, 520);
    bk[2].setting(1100, 520);
    bk[3].setting(1200, 520);
    bk[4].setting(1200, 620);
    bk[5].setting(1500, 520);
    bk[6].setting(1500, 620);
    bk[7].setting(1600, 520);
    bk[8].setting(1900, 520);
    bk[9].setting(1900, 620);
    bk[10].setting(2100, 520);
    bk[11].setting(2200, 520);
    bk[12].setting(2500, 520);
    bk[13].setting(2800, 520);
    bk[14].setting(2800, 620);
    bk[15].setting(3100, 520);
    bk[16].setting(3200, 520);
    bk[17].setting(3400, 520);
    bk[18].setting(3700, 520);
    bk[19].setting(4000, 520);
    bk[20].setting(4300, 520);
    bk[21].setting(4300, 620);
    bk[22].setting(4400, 520);
    bk[23].setting(4700, 520);
    bk[24].setting(4800, 520);
    bk[25].setting(4800, 620);
    bk[26].setting(5100, 520);
    bk[27].setting(5100, 620);
    bk[28].setting(5400, 520);
    bk[29].setting(5500, 520);
    bk[30].setting(5800, 520);
    bk[31].setting(6100, 520);
    bk[32].setting(6100, 620);
    bk[33].setting(6400, 520);
    bk[34].setting(6500, 520);
    bk[35].setting(6800, 520);
    bk[36].setting(6900, 520);
}

void judgment()
{
    for(int i = 0; i < 37; i++)
    {
        if(e.x - bk[i].x < 100 || bk[i].x - e.x < 100 && e.y - bk[i].y < 100)
        {
            e.y = bk[i].y + 100;
        }
        if(e.x - bk[i].x < 100 && e.y - bk[i].y == 100)
        {
            e.x = bk[i].x - 100;
        }
        if(bk[i].x - e.x < 100 && e.y - bk[i].y == 100)
        {
            e.x = bk[i].x + 100;
        }
    }
}