// Muavia - 24/03/2022
// creates widegt
// puts them on screen and returns event number if widget is clicked
// buttons also get highlighted if mouse hovers on them.

class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  color strokeColour = 0;
  int searchButtonCatagory;

  Widget(int x, int y, int width, int height, String label,
    color widgetColor, PFont widgetFont, int event) {

    this.x=x;
    this.y=y;
    this.width = width;
    this.height= height;
    this.label=label;
    this.event=event;
    this.widgetColor=widgetColor;
    this.widgetFont = widgetFont;
    searchButtonCatagory = findStringArray(label, catagoryNames);
    labelColor= color(0);
  }

  void draw() {
    textFont(widgetFont);
    fill(widgetColor);
    //stroke(strokeColour);
    //strokeWeight(4);
    rect(x, y, width, height);
    fill(labelColor);
    textAlign(LEFT, CENTER);
    text(label, x + (width/2)-(textWidth(label)/2), y + (height/2));
    textAlign(LEFT);
  }

  int getEvent(int mX, int mY) {
    if (mX > x && mX < x + width && mY > y && mY < y + height) {
      return event;
    }
    return EVENT_NULL;
  }

  void mouseMoved() {

    for (int i = 0; i < screens.get(MAIN_MENU).widgetList.size(); i++)
    {
      if (screens.get(MAIN_MENU).widgetList.get(i).getEvent(mouseX, mouseY) > 0)
      {
        screens.get(MAIN_MENU).widgetList.get(i).widgetColor = color(200, 200, 200);
      } else
      {
        screens.get(MAIN_MENU).widgetList.get(i).widgetColor = color(255, 0, 100);
      }
    }

    for (int i = 0; i < screens.get(SEARCH_SCREEN).widgetList.size(); i++)
    {
      if (screens.get(SEARCH_SCREEN).widgetList.get(i).getEvent(mouseX, mouseY) > 0)
      {
        screens.get(SEARCH_SCREEN).widgetList.get(i).widgetColor = color(250, 250, 250);
      } else
      {
        screens.get(SEARCH_SCREEN).widgetList.get(i).widgetColor = color(200, 200, 200);
      }
    }

    for (int i = 0; i < screens.get(BAR_SCREEN).widgetList.size(); i++)
    {
      if (screens.get(BAR_SCREEN).widgetList.get(i).getEvent(mouseX, mouseY) > 0)
      {
        screens.get(BAR_SCREEN).widgetList.get(i).widgetColor = color(250, 250, 250);
      } else
      {
        screens.get(BAR_SCREEN).widgetList.get(i).widgetColor = color(200, 200, 200);
      }
    }
    
    for (int i = 0; i < screens.get(BAR_SCREEN_2).widgetList.size(); i++)
    {
      if (screens.get(BAR_SCREEN_2).widgetList.get(i).getEvent(mouseX, mouseY) > 0)
      {
        screens.get(BAR_SCREEN_2).widgetList.get(i).widgetColor = color(250, 250, 250);
      } else
      {
        screens.get(BAR_SCREEN_2).widgetList.get(i).widgetColor = color(200, 200, 200);
      }
    }


    stroke(0);
  }


  void mousePressed()
  {
    int event2;

    event2 = this.getEvent(mouseX, mouseY);

    switch(event2)
    {
    case TO_SEARCH:
      currentScreen = SEARCH_SCREEN;
      break;
    case TO_MAIN:
      currentScreen = MAIN_MENU;
      break;
    case TO_BAR:
      currentScreen = BAR_SCREEN;
      break;
    case PIE_TO_BAR:
      currentScreen = BAR_SCREEN_2;
      break;
    case BAR_TO_PIE:
      currentScreen = PIE_SCREEN;
      break;
    case EVENT_BUTTON9:
      if (mouseButton == LEFT)
      {
        displayedCategories = sortDisplayedCatagories(searchButtonCatagory);
      }
      else
      {
        if (!label.equals("+") && screens.get(currentScreen).cDropDown == null)
        {
          screens.get(SEARCH_SCREEN).removeSearchCatagory(this); 
        }
      }
      break;  
    case EVENT_BUTTON10:
      if (mouseButton == LEFT)
      {
         screens.get(SEARCH_SCREEN).addSearchCatagory(this); 
      }
      break; 
    case EVENT_BUTTON11:
      screens.get(SEARCH_SCREEN).cDropDown.pressed(this);
      break;  
    }
  }
}
