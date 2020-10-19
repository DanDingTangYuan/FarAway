class player
{
    int x, y, playerFace, walkSpeed, fallTime;

    player()
    {
        x = 540;
        y = 510;
        playerFace = 5;
        walkSpeed = 0;
        fallTime = 0;
    }

    // void barrier()
    // {
    // }

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
        if(x >= 640)
        {
            if(walkSpeed > 0)
            {
                mapSpeed = walkSpeed;
            }
            x = x - mapSpeed;
            if(walkSpeed <= 0)
            {
                x = x + walkSpeed;
            }
            if(b.x <= -6100 && x <= 1180)
            {
                mapSpeed = 0;
                x = x + walkSpeed;
                if(x > 1180)
                {
                    x = 1180;
                }
            }
            b.mapMove();
        }
        if(x <= 100)
        {
            if(walkSpeed < 0)
            {
                mapSpeed = walkSpeed;
                if(b.x <= 0 && x >= 0)
                {
                    mapSpeed = 0;
                    x = x - walkSpeed;
                    if(x < 0)
                    {
                        x = 0;
                    }
                }
                x = x - walkSpeed;
            }   
            if(walkSpeed >= 0)
            {
                x = x + walkSpeed;
            }
            b.mapMove();
        }
        if(x > 100 && x < 640)
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
