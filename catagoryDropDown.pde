//added By Rowan Barr
//Used in searrch screen, when adding a new catagory to display.
class catagoryDropDown
{
  int itemToDisplay = 8;
  Widget creator;
  int x; int y; int width; int height;
  int heightPerBox;
  final int UP_ARROW = -1;
  final int DOWN_ARROW = -2;
  int catagoryPointer = 0;
  int[] catagoryIndexes = new int[itemToDisplay+2];
  String[] itemNames = new String[itemToDisplay+2];
  Widget[] theWidgets = new Widget[itemToDisplay+2];
  
  int pointer;
  
  catagoryDropDown(int x, int y, int width, int height)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    heightPerBox = height/(itemToDisplay+2);
    pointer = 0;
    updateIndexes();
    updateStringNames();
    for (int i = 0; i < catagoryIndexes.length; i++)
    {
      screens.get(currentScreen).addWidget(x , y + (i*heightPerBox), width, heightPerBox, itemNames[i], color(200, 200, 200), sortButtonsFont, EVENT_BUTTON11);
      theWidgets[i] = (screens.get(currentScreen).widgetList.get(screens.get(currentScreen).widgetList.size() - 1));
    }
  }
  
  void updateWidgets()
  {
    for (int i = 0; i < catagoryIndexes.length; i++)
    {
      theWidgets[i].label = itemNames[i];
    }
  }
  
  void updateIndexes()
  {
  
    
    for (int i = 1; i < itemToDisplay+1; i++)
    {
      catagoryIndexes[i] = pointer+(i-1);
    }
    

     catagoryIndexes[0] = UP_ARROW;
     catagoryIndexes[catagoryIndexes.length - 1] = DOWN_ARROW;
    

    
  }
  
  void updateStringNames()
  {
    for (int i = 0; i < catagoryIndexes.length; i++)
    {
      if (catagoryIndexes[i] == UP_ARROW)
      {
        itemNames[i] = "^";
      }
      else if (catagoryIndexes[i] == DOWN_ARROW)
      {
        itemNames[i] = "v";
      }
      else
      {
        itemNames[i] = catagoryNames[catagoryIndexes[i]];
      }
    }
  }
  
  void pressed(Widget theWidget)
  {
    int pos = findWidget(theWidget, theWidgets);
    int value = catagoryIndexes[pos];
    if (value != UP_ARROW && value != DOWN_ARROW)
    {
      
      for (int i = 0; i < theWidgets.length; i++) //<>//
      {
         screens.get(SEARCH_SCREEN).removeWidget(theWidgets[i]);
      }
      screens.get(currentScreen).cDropDown = null;
      if (currentScreen == SEARCH_SCREEN)
      {
        screens.get(SEARCH_SCREEN).addWidget(30 , headingHeight, 120, 30, theWidget.label, color(200, 200, 200), sortButtonsFont, EVENT_BUTTON9);
        displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
      }
      searchScreenDisplayedCatagories = appendIntArray(findStringArray(theWidget.label, catagoryNames), searchScreenDisplayedCatagories);
      screens.get(SEARCH_SCREEN).updateCatagoryWidgets();
      println(searchScreenDisplayedCatagories);
    }
    else
    {
      if (value == UP_ARROW)
      {
       pointer--; 
       pointer = max(0, pointer);
      }
      if (value == DOWN_ARROW)
      {
       pointer++; 
       pointer = min(pointer, CATEGORIES_AMOUNT-itemToDisplay);
      }
      updateIndexes();
      updateStringNames();
      updateWidgets();
    }
  }


  
  
}
