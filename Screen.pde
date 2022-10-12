
// Hugh & Muavia - 24/03/2022
// Uses the widget class to create widgets
// puts the widgets in an arrayList
// draws the widets on the screen

// Hugh - created screen arraylist 28/03

class Screen {
  ArrayList<Widget>widgetList = new ArrayList<Widget>();
  int index;
  int plusExists = -1;
  catagoryDropDown cDropDown;
  
  Screen(int n) {
    index = n;
  }

  void addWidget(int x, int y, int width, int height, String widgetName, color widgetColor, PFont widgetFont, int event) {
    Widget tempWidget = new Widget(x, y, width, height, widgetName, widgetColor, widgetFont, event);
    widgetList.add(tempWidget);
  }
  void draw()
  {
    if (currentScreen == index)
    {
      for (int i = 0; i < widgetList.size(); i++)
      {
        widgetList.get(i).draw();
        widgetList.get(i).mouseMoved();
      }
    }

  }

  void mousePressed() {
    for (int i = 0; i < widgetList.size(); i++) 
    {
      widgetList.get(i).mousePressed();
    }
  }

  int widgetCount() {
    return widgetList.size();
  }
  
  //Rowan Barr
  //Used to correctly remove a displayed catagory widgets.
  void removeSearchCatagory(Widget toRemove)
  {
    int pos = findWidget(toRemove, displayCatagoryButtons);
    if (pos != 0)
    {
      displayCatagoryButtons.remove(pos);
      if (!toRemove.label.equals("+"))
      {
        searchScreenDisplayedCatagories = removeIntArray(pos, searchScreenDisplayedCatagories);
      }

      this.widgetList.remove(findWidget(toRemove, widgetList));
      updateCatagoryWidgets();
    }
    
  }
  
  //Rowan Barr//Remove a specified widget from this screens widget list.
  void removeWidget(Widget toRemove)
  {
    int pos = findWidget(toRemove, this.widgetList);
    if (pos != 0)
    {
      widgetList.remove(pos);
    }
    
  }
  
  //Rowan Barr
  //Used to update and ajusted the display catagories on search screen when something has changed.
  void updateCatagoryWidgets()
  {
    for (int i = 0; i < displayCatagoryButtons.size(); i++)
    {
      displayCatagoryButtons.get(i).x = 30 + (searchColumDistance*i);
    }
    
    if (displayCatagoryButtons.size() == searchScreenMaxCatagories)
    {
      plusExists = -1;
    }

    if (displayCatagoryButtons.size() < searchScreenMaxCatagories && plusExists == -1)
    {
      screens.get(SEARCH_SCREEN).addWidget(30 + (searchColumDistance*displayCatagoryButtons.size()), headingHeight, 120, 30, "+", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON10);
      displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
      plusExists = displayCatagoryButtons.size() - 1;

    }
    
    if (displayCatagoryButtons.size() != searchScreenMaxCatagories)
    {
       plusExists = displayCatagoryButtons.size() - 1; 
    }

  }
  
  
  void addSearchCatagory(Widget addButton)
  {
    cDropDown = new catagoryDropDown(addButton.x,addButton.y,addButton.width,addButton.height*10);
    removeSearchCatagory(addButton);
    plusExists = -1;
  }
  
}
void init_screens(int amount) {
  screens = new ArrayList<Screen>();
  for (int i = 0; i < amount; i++) {
    screens.add(new Screen(i));
  }
}


  
  //Rowan Barr
  //finds a Widget from an widget list and returns the index
 int findWidget(Widget item, ArrayList<Widget> theWidgets)
 {
  for (int i = 0; i < theWidgets.size(); i++)
  {
    if (item.equals(theWidgets.get(i)))
      return i;
  }
  
  return -1;
 }
  
  //Rowan Barr
  //finds a Widget from an widget array and returns the index
 int findWidget(Widget item, Widget[] theWidgets)
 { //<>//
  for (int i = 0; i < theWidgets.length; i++)
  {
    if (item.equals(theWidgets[i]))
      return i;
  }
  
  return -1;
 }




void addWidgets() {

  screens.get(MAIN_MENU).addWidget((1366/2) - 90, 600, 180, 40, "ENTER", color(255, 0, 100), sortButtonsFont, TO_SEARCH);

  //Muavia Ghazi 06/04/2022 - added scroll butttons to search screen, bar chart screen 1 & 2 
  screens.get(SEARCH_SCREEN).addWidget(1345, 75, 25, 25, "^", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON5);
  screens.get(SEARCH_SCREEN).addWidget(1345, 730, 25, 25, "v", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON6);
  
  screens.get(BAR_SCREEN).addWidget(1345, 75, 25, 25, "^", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON7);
  screens.get(BAR_SCREEN).addWidget(1345, 730, 25, 25, "v", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON8);
  
  screens.get(BAR_SCREEN_2).addWidget(1345, 75, 25, 25, "^", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON14);
  screens.get(BAR_SCREEN_2).addWidget(1345, 730, 25, 25, "v", color(200, 200, 200), sortButtonsFont, EVENT_BUTTON15);
  
  
  
  //Rowan Barr 05/04/2022
  screens.get(SEARCH_SCREEN).addWidget(30 , headingHeight, 120, 30, catagoryNames[Name_INDEX], color(200, 200, 200), sortButtonsFont, EVENT_BUTTON9);
  displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
  screens.get(SEARCH_SCREEN).addWidget(30 + (searchColumDistance), headingHeight, 120, 30, catagoryNames[LDate_INDEX], color(200, 200, 200), sortButtonsFont, EVENT_BUTTON9);
  displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
  screens.get(SEARCH_SCREEN).addWidget(30 + (searchColumDistance*2), headingHeight, 120, 30, catagoryNames[State_INDEX], color(200, 200, 200), sortButtonsFont, EVENT_BUTTON9);
  displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
  screens.get(SEARCH_SCREEN).addWidget(30 + (searchColumDistance*3), headingHeight, 120, 30, catagoryNames[Status_INDEX], color(200, 200, 200), sortButtonsFont, EVENT_BUTTON9);
  displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
  screens.get(SEARCH_SCREEN).addWidget(30 + (searchColumDistance*4), headingHeight, 120, 30, catagoryNames[Mass_INDEX], color(200, 200, 200), sortButtonsFont, EVENT_BUTTON9);
  displayCatagoryButtons.add(screens.get(SEARCH_SCREEN).widgetList.get(screens.get(SEARCH_SCREEN).widgetList.size() - 1));
  
  
  
 
  //Barry Deane woz ere 11/04/2022
  screens.get(PIE_SCREEN).addWidget(300, 15, (int)(textWidth("SWITCH TO BAR CHART")+50), 30, "SWITCH TO BAR CHART", color(200, 200, 200), sortButtonsFont, PIE_TO_BAR);
  screens.get(BAR_SCREEN_2).addWidget(300, 15, (int)(textWidth("SWITCH TO PIE CHART")+50), 30, "SWITCH TO PIE CHART", color(200, 200, 200), sortButtonsFont, BAR_TO_PIE);
  
  /*
    screens.get(SEARCH_SCREEN).addWidget(800, 620, 180, 40,
   "NEXT", color(50, 150, 255),
   stdFont, TO_BAR);
   
   screens.get(SEARCH_SCREEN).addWidget(800, 700, 180, 40,
   "BACK", color(50, 150, 255),
   stdFont, TO_MAIN);
   
   screens.get(BAR_SCREEN).addWidget(800, 600, 180, 40,
   "BACK", color(50, 150, 255),
   stdFont, TO_SEARCH);
   */
}
