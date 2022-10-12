class searchBar
{
  //Rowan Barr, 24/03/2022: Created searchBar class.
  int x; int y;
  int width; int height;
  int maxlen;
  int event;
  String label;
  color widgetColor;
  PFont widgetFont;
  color labelColor;
  String emptyLabel;
  searchButton catagoryButton;
  searchBar(int x, int y, int width, int height, String label, color widgetColor, PFont font, int event, int maxlen)
  {
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event;
    this.widgetColor=widgetColor; this.widgetFont=font;
    labelColor=color(0); this.maxlen=maxlen;
    catagoryButton = new searchButton(600, height, "TEST", widgetColor, font, this);
    emptyLabel = "Type here to Search.";
  }

  //Adds a character s to the searchbars string.
  void append(char s)
  {
    if(s==BACKSPACE)
    {
      if(!label.equals(""))
        label=label.substring(0,label.length()-1);
    }
    else 
    {
      if (label.length() <maxlen)
      {
        if ((byte) s >= 32 && (byte) s < 127)
        {
          label=label+str(s);
        }
      }
    }
  }
  
  
  void draw()
  {
    fill(widgetColor);
    rect(x,y,width,height);
    fill(labelColor);
    textFont(widgetFont); 
    if (label.equals(""))
    {
      text(emptyLabel, x+10, y+10 + (height/2));
    }
    else
    {
      text(label, x+10, y+10 + (height/2));
    }
    catagoryButton.draw();

  }
}
