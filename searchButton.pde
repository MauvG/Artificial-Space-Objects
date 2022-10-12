class searchButton
{
  //added by Rowan Barr on the 31/3/2022
  float x; float y;
  int width; int height;
  int maxlen;
  int event;
  String label;
  color widgetColor;
  PFont widgetFont;
  color labelColor;
  searchBar creator;
  int catagoryIndex = 0;
  int[] selectableCatagories = {Name_INDEX, LDate_INDEX, Status_INDEX, State_INDEX, Mass_INDEX, Diameter_INDEX, Perigee_INDEX, Apogee_INDEX};
  String[] catagoryNames = {"Name", "Launch Date", "Status", "State", "Mass", "Diameter", "Perigee", "Apogee"};
  
  
  searchButton(int width, int height, String label, color widgetColor, PFont font, searchBar creator)
  {
    this.width = width; this.height= height;
    this.label=label;
    this.widgetColor=widgetColor; this.widgetFont=font;
    labelColor=color(0);
    this.creator = creator;
    this.x=creator.x + creator.width + 10; 
    this.y=creator.y;
  }


  void mousePressed()
  {
    if (pointInRectangle(mouseX, mouseY, x,y,x+width,y+height))
    {
        if (mouseButton == LEFT)
        {
           catagoryIndex += 1;
           if (catagoryIndex == selectableCatagories.length)
           {
             catagoryIndex = 0;
           }
        }
        else
        {
           catagoryIndex -= 1;
           if (catagoryIndex == -1)
           {
             catagoryIndex = selectableCatagories.length - 1;
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
    text(catagoryNames[catagoryIndex], x+10, y+10 + (height/2));
  } 
}
