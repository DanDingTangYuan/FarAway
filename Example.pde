//use mouse to control the cannon
//mouse click to shoot
//'p','q' to increase or decrease the speed
//'r' to reset
//when you hit the plane, you get 3 bullet and 100 points
// for reward
int remain=20;
int credit=0;
int hit=0;
PFont font;
class plane
{
  int x;
  int y;
  int flag;
  int speed;
  plane(int x,int y)
  {
    this.x=x;
    this.y=y;
    speed=3;
    flag=-1;
  }
  void fly()
  {
      if(flag==-1)
      {
        x+=speed;
        if(x>=600) 
        {
          x-=600;
          y=(int)random(20,300);
        }
      }
     if(flag==1)
     {
        flag=-1;
        x=0;
        speed++;
     } 
  }
  void crash(cannonball c)
  {
    if(dist(x,y,c.x,c.y)<30) 
    {
      credit+=100;
      flag=1;
      hit=1;
    }
  }
  void display()
  {
    if(x<600)
    {
      fill(20);
      rect(x,y,60,20);
      ellipse(x+15,y,10,20);
      ellipse(x+15,y+20,10,20);
    }
  }
}
class cannonball
{
  int x;
  int y;
  int flag;
  cannonball()
  {
    x=600;
    y=600;
    flag=1;//can be fired
  }
  void fire(int x,int y)
  {
    this.x=x;
    this.y=y;
    flag=-1;//fired
  }
  void fly()
  {
    if(flag==-1) y-=5;
  }
  void display()
  {
    if(y<600)
    {
      fill(100);
      ellipse(x,y,20,20);
    }
  }
}
class cannon
{
  int x;
  cannon(int x)
  {
    this.x=x;
  }
  void display()
  {
    fill(0);
    rect(mouseX,580,40,20);
    rect(mouseX+10,560,20,40);
  }
  void fire(cannonball c)
  {
    c.fire(mouseX,580);
  }
}
cannon a=new cannon((int)random(20,500));
cannonball[] c=new cannonball[20];
plane p=new plane(0,(int)random(20,200));
void setup()
{
  size(600,600);
  smooth();
  background(255);
  font=loadFont("font.vlw");
  textFont(font);
  for(int i=0;i<20;i++)
  {
     c[i]=new cannonball();
  }
}
void keyPressed()
{
  if(key=='r')
  {
     remain=20;
     credit=0;
     for(int i=0;i<20;i++)
       c[i]=new cannonball();
     p.flag=-1;
     p.speed=3;
  }
  if(key=='e') p.speed+=3;
  if(key=='q')
  {
    if(p.speed<=3) return;
    else p.speed-=3;
  }
}
void mousePressed()
{
  int i=0;
    for(i=0;i<20;i++)
    {
      if(c[i].flag==1) break;
    }
    if(i==20) return;
    a.fire(c[i]);
    remain--;
}
void draw()
{
  background(255); 
  a.display();
  for(int i=0;i<20;i++)
  {
    if(c[i].flag==-1) 
    {
      c[i].fly();
      c[i].display();
    }
  }
  for(int i=0;i<20;i++)
  {
    p.crash(c[i]);
  }
  p.fly();
  p.display();
  if(hit==1)
  {
    hit=0;
    int j=5;
    for(int i=0;i<20;i++)
    {
      if(c[i].flag==-1) 
      {
        c[i]=new cannonball();
        j--;
        remain++;
        if(j==0) break;
      }
    }
  }
  textSize(20);
  text("remain: "+remain,500,50);
  text("credit: "+credit,500,100);
  if(remain==0)
  {
    textSize(50);
    text("run out of ammo...",100,150);
    text("final score is: "+credit,100,220);
    text("press 'r' to restart..",100,280); 
  }
  
}