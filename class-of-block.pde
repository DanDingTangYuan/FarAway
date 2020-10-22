class theBlock
{
    int x, y, x_2;
    theBlock();
    {
        x = 0;
        y = 0;
        x_2 = 0;
    }

    void setting(int a, int b)
    {
        this.x = a;
        this.y = b;
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
