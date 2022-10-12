 //<>//
final int CATEGORIES_AMOUNT = 41; //The total amont of catagories

// The index of each category in the arrayList returned from fileReader()
final int JCAT_INDEX = 0;
final int Satcat_INDEX = 1;
final int Piece_INDEX = 2;
final int Type_INDEX = 3;
final int Name_INDEX = 4;
final int PLName_INDEX = 5;
final int LDate_INDEX = 6;
final int Parent_INDEX = 7;
final int SDate_INDEX = 8;
final int Primary_INDEX = 9;
final int DDate_INDEX = 10;
final int Status_INDEX = 11;
final int Dest_INDEX = 12;
final int Owner_INDEX = 13;
final int State_INDEX = 14;
final int Manufacturer_INDEX = 15;
final int Bus_INDEX = 16;
final int Motor_INDEX = 17;
final int Mass_INDEX = 18;
final int MassFlag_INDEX = 19;
final int DryMass_INDEX = 20;
final int DryFlag_INDEX = 21;
final int TotMass_INDEX = 22;
final int TotFlag_INDEX = 23;
final int Length_INDEX = 24;
final int LFlag_INDEX = 25;
final int Diameter_INDEX = 26;
final int DFlag_INDEX = 27;
final int Span_INDEX = 28;
final int SpanFlag_INDEX = 29;
final int Shape_INDEX = 30;
final int ODate_INDEX = 31;
final int Perigee_INDEX = 32;
final int PF_INDEX = 33;
final int Apogee_INDEX = 34;
final int AF_INDEX = 35;
final int Inc_INDEX = 36;
final int IF_INDEX = 37;
final int OpOrbit_INDEX = 38;
final int OQUAL_INDEX = 39;
final int AltNames_INDEX = 40;


final int COLORMARGIN = 50;

final String[] catagoryNames = {"JCAT", "Satcat", "Piece", "Type", "Name", "Payload Name", "Launch Date", "Parent", "Seperation Date",
  "Primary Body", "Descent Date", "Status", "Dest", "Owner", "State", "Manufacturer", "Bus", "Motor", "Mass", "Mass Flag", "Dry Mass",
  "Dry Flag", "Total Mass", "Total Flag", "Length", "Length Flag", "Diameter", "Diameter Flag", "Span", "Span Flag", "Shape", "Orbit Epoch Date",
  "Perigee", "Perigee Flag", "Apogee", "Apogee Flag", "Inclination", "Inclination Flag", "Orbit Type", "Orbit Quality", "Alternate Names"};

final int SCREEN_COUNT = 6;
final int MAIN_MENU = 0;
final int SEARCH_SCREEN = 1;
final int BAR_SCREEN = 2;
final int PIE_SCREEN = 3;
final int DISPLAY_SCREEN = 4;
final int BAR_SCREEN_2 = 5;

final int TO_SEARCH = 1;
final int TO_MAIN = 2;
final int TO_BAR = 3;
final int TO_DISPLAY = 4;
final int PIE_TO_BAR = 12;
final int BAR_TO_PIE = 13;

boolean pieChartExcludeDebris = false;
boolean pieChartCurrentlyInOrbit = false;
boolean pieChartMinMass = false;


int minYear;
int maxYear;
int minMinYear;
int maxMaxYear;
int currentTimePeriodCount = 0;

ArrayList<ArrayList<String>> allCategories;
ArrayList<ArrayList<String>> displayedCategories;
ArrayList<Integer> foundIndexes;
ArrayList<Screen> screens;
PFont stdFont;
PFont searchFont;
PFont sortButtonsFont;
PFont titleFont;
PImage upArrow;
PImage downArrow;
PImage earth, satellite, space;
int scroll = 300;
int currentScreen = MAIN_MENU;
Menu dropdown = new Menu();
int headingHeight=70;
int textHeight=30;
final int SCREEN_WIDTH = 1366;
final int SCREEN_HEIGHT = 768;
ArrayList<String> states = new ArrayList<>();
ArrayList<Integer> statesCount = new ArrayList<>();
ArrayList<Float> angles = new ArrayList<>();
int[][] colors;

int currentSortIndex = -1;
boolean descendingSort = true;

int moveBackground = -1600; 


final int searchColumDistance = 260;

barChart barChart;
barChart statesBarChart;
DisplayScreen displayScreen;

searchBar testSearch;
int searchCatagoryIndex = 4;

String[] obj;
int[] values;
color fill = color(50);
color bar = color(121, 188, 184);
color text = color(235, 235, 211);

final int EVENT_NULL = 0;
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_BUTTON5 = 5;    //scroll button for search screen
final int EVENT_BUTTON6 = 6;    //scroll button for search screen
final int EVENT_BUTTON7 = 7;    //scroll button for bar screen
final int EVENT_BUTTON8 = 8;    //scroll button for bar screen
final int EVENT_BUTTON9 = 9;    //Search Button Sort
final int EVENT_BUTTON10 = 10;  //Add search catagory and remove search cataory
final int EVENT_BUTTON11 = 11;  //dropdown menu button

final int EVENT_BUTTON14 = 14;  //scroll button for bar screen 2
final int EVENT_BUTTON15 = 15;  //scroll button for bar screen 2



int[] searchScreenDisplayedCatagories = {Name_INDEX, LDate_INDEX, State_INDEX, Status_INDEX, Mass_INDEX};
ArrayList<Widget> displayCatagoryButtons = new ArrayList<Widget>();
final int searchScreenMaxCatagories = 5;


ScrollBar scrollBar1, scrollBar2, scrollBar3;

int getYear(String theDate)
{
  String parts[] = theDate.split(" ");
  String sYear = parts[0];
  return int(sYear);
}

int convertDate(String theDate)
{
  String parts[] = theDate.split(" ");
  if (parts.length == 4)
  {
    parts[2] = parts[3];
  }
  if (parts.length < 5 && parts.length > 2)
  {
    String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    int[] monDays = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    String sYear = parts[0];
    String sMonth = parts[1];
    String sDay = parts[2];
    int iYear = int(sYear)*365;
    iYear -= 1940;
    int iMonth = monDays[0];
    int i = 0;
    while (!months[i].equals(sMonth) && i < 13)
    {
      i++;
      iMonth += monDays[i];
    }
    int iDay = int(sDay);
    return (iDay + iMonth + iYear);
  }
  return 0;
}

//added by Rowan Barr 02/04/2022
boolean pointInRectangle(float px, float py, float rx1, float ry1, float rx2, float ry2)
{
  if (px > rx1 && px < rx2 && py > ry1 && py < ry2) {
    return true;
  }
  return false;
}

//added by Rowan Barr 06/04/2022
int findStringArray(String item, String[] array)
{
  for (int i = 0; i < array.length; i++)
  {
    if (array[i].equals(item))
      return i;
  }
  return -1;
}

//added by Rowan Barr07/04/2022
String[] removeStringArray(int index, String[] array)
{
  String[] newArray = new String[array.length - 1];
  int j = 0;
  for (int i = 0; i < array.length; i++)
  {
    if (i != index)
    {
      newArray[j] = array[i];
      j++;
    }
  }
  return newArray;
}

//Rowan Barr
int[] removeIntArray(int index, int[] array)
{
  int[] newArray = new int[array.length - 1];
  int j = 0;
  for (int i = 0; i < array.length; i++)
  {
    if (i != index)
    {
      newArray[j] = array[i];
      j++;
    }
  }
  return newArray;
}

//Rowan Barr
int[] appendIntArray(int item, int[] theArray)
{
  int[] newArray = new int[theArray.length+1];
  int j = 0;
  for (int i = 0; i < theArray.length; i++)
  {
    newArray[i] = theArray[i];
  }
  newArray[theArray.length] = item;
  return newArray;
}




void setup()
{
  smooth(4);
  frameRate(60);

  stdFont = loadFont("BellMT-22.vlw");
  sortButtonsFont = loadFont("AgencyFB-Bold-18.vlw");
  searchFont = loadFont("ComicSansMS-36.vlw");
  titleFont = loadFont("CalistoMT-48.vlw");
  upArrow = loadImage("upArrow.png");
  downArrow = loadImage("downArrow.png");
  size(1366, 768);
  background(20);
  fileReader();
  init_screens(SCREEN_COUNT);
  addWidgets();
  init_menuButtons();

  ArrayList<String> nameList = new ArrayList<String>();
  ArrayList<String> launchDateList = new ArrayList<String>();
  ArrayList<String> statusList = new ArrayList<String>();
  ArrayList<String> stateList = new ArrayList<String>();
  ArrayList<String> massList = new ArrayList<String>();
  ArrayList<String> diameterList = new ArrayList<String>();
  ArrayList<String> perigeeList = new ArrayList<String>();
  ArrayList<String> apogeeList = new ArrayList<String>();

  initMaxMinYear();


  for (int i = 0; i < allCategories.size() - 1; i++) {
    //println(allCategories.get(Mass_INDEX).get(i));


    nameList.add(allCategories.get(i).get(Name_INDEX));
    launchDateList.add(allCategories.get(i).get(LDate_INDEX));
    statusList.add(allCategories.get(i).get(Status_INDEX));
    stateList.add(allCategories.get(i).get(State_INDEX));
    massList.add(allCategories.get(i).get(Mass_INDEX));
    diameterList.add(allCategories.get(i).get(Diameter_INDEX));
    perigeeList.add(allCategories.get(i).get(Perigee_INDEX));
    apogeeList.add(allCategories.get(i).get(Apogee_INDEX));


    //println("Name: " + nameList.get(i) +
    //  "      Launch Date: " + launchDateList.get(i) +
    //  "      Status: " + statusList.get(i) +
    //  "      State: " + stateList.get(i)  +
    //  "      Mass: " + massList.get(i) +
    //  "      Diameter: " + diameterList.get(i) +
    //  "      Perigee: " + perigeeList.get(i) +
    //  "      Apogee: " + apogeeList.get(i) );
  }
  frameRate(30);
  testSearch = new searchBar(20, 10, 800, 50, "", color(255, 255, 255), searchFont, -1, 26);

  //Muavia ghazi - added scrollbars
  noStroke();
  scrollBar1 = new ScrollBar(1356, 100, 20, 20, 630);
  scrollBar2 = new ScrollBar(1356, 100, 20, 370, 630);
  scrollBar3 = new ScrollBar(1356, 100, 20, 30, 630);

  //Muavia Ghazi - change first number to display info of another satellite.
  displayScreen = new DisplayScreen(0, nameList, launchDateList, statusList, stateList, massList, diameterList, perigeeList, apogeeList);

  createPieChartStates();

  displayedCategories = new ArrayList<>(allCategories);
  obj = new String[20];
  values = new int[20];
  for (int count = 0; count<obj.length; count++)
  {
    obj[count]=allCategories.get(count).get(Name_INDEX);
    values[count]=Integer.parseInt(massList.get(count));
  }
  barChart = new barChart(200, 50, 1000, 500, obj, values, "Mass(kgs)", bar, fill, text);
  //added by Barry Deane (07/04/2022)
  String[] statesObj = new String[states.size()];
  int[] stateCount = new int[statesCount.size()];
  for (int i=0; i<statesObj.length; i++)
  {
    statesObj[i]=states.get(i);
    stateCount[i]=statesCount.get(i);
  }
  statesBarChart = new barChart(200, 50, 1000, 500, statesObj, stateCount, "No. of Spacecraft by State", bar, fill, text);
  for (int i=0; i<statesObj.length; i++)
  {
    statesObj[i]=states.get(i);
    stateCount[i]=statesCount.get(i);
  }
  statesBarChart = new barChart(200, 50, 1000, 500, statesObj, stateCount, "No. of Spacecraft by State", bar, fill, text);

  //Muavia Ghazi - loads images for displayScreen.
  earth = loadImage("earth.png");
  earth.resize(300, 0);

  satellite = loadImage("satellite.png");
  satellite.resize(75, 0);

  //Muavia Ghazi - background image
  space = loadImage("space.png");
  //space.resize(SCREEN_WIDTH, SCREEN_HEIGHT);
  space.resize(3000, 0);

}

void mousePressed() {
  screens.get(currentScreen).mousePressed();
  dropdown.mousePressed();
  menuButtonsMousePressed();
  if (currentScreen == TO_SEARCH && !dropdown.opening && !dropdown.closing)
  {
    testSearch.catagoryButton.mousePressed();
    tryOpenSatellite();
  }
  if (currentScreen == PIE_SCREEN) {
    pieMousePressed();
  }
}

//Rowan Barr
//Method checks if the user has clicked while the mouse is over a satillite name. If so, if will open that satillite in the display screen.
void tryOpenSatellite()
{
  for (int i = 0; i < displayedCategories.size(); i++)
  {
    if (pointInRectangle(mouseX, mouseY, 30, (120 + (16*(i-1)))-scroll, 30+ textWidth( displayedCategories.get(i).get( Name_INDEX ) ), (120 + (16*i )) - scroll ) && mouseY > 100)
    {
      println("works");
      displayScreen.update(i);
      currentScreen = DISPLAY_SCREEN;
      break;
    }
  }
}

void mouseMoved() {
  menuButtonsMouseMoved();
}

//<>//
//added by Rowan Barr07/04/2022
//Used to sort the displayed item by any catagory
ArrayList<ArrayList<String>> sortDisplayedCatagories(int sortIndex)
{
  if (currentSortIndex == sortIndex)
  {
    descendingSort = !descendingSort;
  } else
  {
    descendingSort = true;
  }
  ArrayList<ArrayList<String>> newDisplay = new ArrayList<ArrayList<String>>();
  ArrayList<ArrayList<String>> copyDisplay = new ArrayList<ArrayList<String>>(displayedCategories);
  String[] itemsOfCatagory = new String[copyDisplay.size()];
  for (int i = 0; i<displayedCategories.size(); i++)
  {
    itemsOfCatagory[i] = (copyDisplay.get(i).get(sortIndex)).toUpperCase();
  }
  itemsOfCatagory = sort(itemsOfCatagory);

  if (!descendingSort)
  {
    itemsOfCatagory = reverse(itemsOfCatagory);
  }
  int storeLen = itemsOfCatagory.length;
  for (int i = 0; i<storeLen; i++)
  {
    if (i % 1000 == 0)
    {
      println("sorting: " + (((float)i/storeLen)*100) + "%");
    }
    for (int j = 0; j < copyDisplay.size(); j++)
    {
      if (copyDisplay.get(j).get(sortIndex).equalsIgnoreCase(itemsOfCatagory[0]))
      {
        newDisplay.add(copyDisplay.get(j));
        copyDisplay.remove(j);
        itemsOfCatagory = removeStringArray(0, itemsOfCatagory);
        break;
      }
    }
  }
  currentSortIndex = sortIndex;
  return newDisplay;
}

//Rowan Barr
void keyPressed() {
  if (testSearch != null && currentScreen == SEARCH_SCREEN)
  {
    if (key == ENTER)
    {
      scrollBar1.newBarPos = scrollBar1.ypos;

      if (testSearch.label.equals(""))
      {
        displayedCategories = new ArrayList<>(allCategories);
      } else
      {
        scroll = 0;
        println("Searching");
        foundIndexes = search(testSearch.catagoryButton.selectableCatagories[testSearch.catagoryButton.catagoryIndex], testSearch.label);
        displayedCategories.clear();
        for (int i = 0; i < foundIndexes.size(); i++)
        {
          displayedCategories.add(allCategories.get(foundIndexes.get(i)));
        }

        if (displayedCategories.size() == 0)
        {
          println("Emtpy") ;
        }
      }
    } else
    {
      testSearch.append(key);
    }
  }
}

float scrollBarChart;
float scrollStatesBarChart;

// Muavia Ghazi - added the ability to scroll through the list using the the mouse scroll wheel
void mouseWheel(MouseEvent event) {
  if (currentScreen == SEARCH_SCREEN)
  {

    if (scroll >= 0)
    {
      scroll += event.getCount() * 10;
    } else
    {
      scroll = 0;
      ;
    }
    //println(scroll);

    if (scrollBar1.barPos >= scrollBar1.ypos)
    {
      scrollBar1.barPos += event.getCount() * 0.1;
      scrollBar1.newBarPos = scrollBar1.barPos;
    }
  } else if (currentScreen == BAR_SCREEN)
  {

    scrollBarChart = event.getCount() * 10;

    barChart.y -= scrollBarChart;

    if (barChart.y >= 50)
    {
      barChart.y += scrollBarChart;
    } else if (barChart.y <= -230)
    {
      barChart.y += scrollBarChart;
    }


    if (scrollBar2.barPos >= scrollBar2.ypos)
    {
      scrollBar2.barPos += event.getCount() * 9;
      scrollBar2.newBarPos = scrollBar2.barPos;
    }
  } else if (currentScreen == BAR_SCREEN_2)
  {

    scrollStatesBarChart = event.getCount() * 10;

    statesBarChart.y -= scrollStatesBarChart;

    if (statesBarChart.y >= 60)
    {
      statesBarChart.y += scrollStatesBarChart;
    } else if (statesBarChart.y <= -4835)
    {
      statesBarChart.y += scrollStatesBarChart;
    }


    if (scrollBar3.barPos >= scrollBar3.ypos)
    {
      scrollBar3.barPos += event.getCount() * 1.2;
      scrollBar3.newBarPos = scrollBar3.barPos;
    }

    //println(statesBarChart.y + " ypos");
  }
  else if(currentScreen == DISPLAY_SCREEN)
  {
     displayScreen.textPos -= event.getCount() * 10;
  }
}

//Muavia Ghazi - executes instructions after an event has been fired.
void events() {

  int event;

  if (mousePressed)
  {
    for (int i = 0; i < screens.get(currentScreen).widgetList.size(); i++)
    {
      Widget aWidget = (Widget) screens.get(currentScreen).widgetList.get(i);

      event = aWidget.getEvent(mouseX, mouseY);

      switch(event)
      {
      case EVENT_BUTTON1:

      case EVENT_BUTTON2:

        break;
      case EVENT_BUTTON3:

        break;
      case EVENT_BUTTON4:

        break;
      case EVENT_BUTTON5:

        if (scrollBar1.barPos >= 102)
        {
          //scroll -= 10;
          scrollBar1.barPos -= 1;
          scrollBar1.newBarPos = scrollBar1.barPos;
          scroll = ((int) scrollBar1.position - scrollBar1.ypos) * 30;
        }

        break;
      case EVENT_BUTTON6:

        if (scrollBar1.barPos <= scrollBar1.sposMax)
        {
          scrollBar1.barPos += 1;
          scrollBar1.newBarPos = scrollBar1.barPos;
          scroll = ((int) scrollBar1.position - scrollBar1.ypos) * 30;
        }
        break;

      case EVENT_BUTTON7:

        if (scrollBar2.barPos >= 103)
        {
          barChart.y += 10;
          scrollBar2.newBarPos -= 10;
        }

        break;
      case EVENT_BUTTON8:

        if (scrollBar2.barPos <= 353)
        {
          barChart.y -= 10;
          scrollBar2.newBarPos += 10;
        }

        break;
      case EVENT_BUTTON14:

        if (scrollBar3.barPos >= 102)
        {
          statesBarChart.y += 10;
          scrollBar3.newBarPos -= 1.2;
        }

        break;

      case EVENT_BUTTON15:

        if (scrollBar3.barPos <= 699)
        {
          statesBarChart.y -= 10;
          scrollBar3.newBarPos += 1.2;
        }
      }
    }
  }
}

void draw() {

  if (currentScreen == MAIN_MENU || currentScreen == DISPLAY_SCREEN || currentScreen == PIE_SCREEN)
  {
    //Muavia Ghazi - added moving Background
    image(space, moveBackground, 0);
    moveBackground += 1;
    
    if(moveBackground >= -100)
    {
      moveBackground = -1600;
    }
    //println(moveBackground);
  
  }
  else
  {
    background(0);
  }
  
  int textHeight = 120;
  textFont(stdFont);
  fill(255);

  if (currentScreen == MAIN_MENU) {
    textFont(titleFont);
    //textFont(displayScreen.displayScreenFont);
    //textSize(78);
    fill(46, 196, 182);
    text("SPACE DATA PROJECT", 425, 300);
  }

  if (currentScreen == SEARCH_SCREEN) {
    for (int i = 0; i < displayedCategories.size(); i++) {
      if ((textHeight - scroll) >= 0 && (textHeight - scroll <= 820)) {
        for (int j = 0; j < searchScreenDisplayedCatagories.length; j++)
        {
          text(displayedCategories.get(i).get(searchScreenDisplayedCatagories[j]), 30 + (searchColumDistance * j), textHeight - scroll);
        }
      }
      textHeight+=16;
    }
    fill(40);
    rect(0, 0, SCREEN_WIDTH, 105);
    fill(255);
    /*
  text("NAME", 50, headingHeight);
     text("LAUNCH DATE", 220, headingHeight);
     text("STATUS", 350, headingHeight);
     text("STATE", 450, headingHeight);
     text("MASS", 550, headingHeight);
     textSize(48);
     text(displayedCategories.get(0).size() + " results", 50, headingHeight + 20);
     */
    testSearch.draw();

    scrollBar1.draw();
  }
  if (currentScreen == BAR_SCREEN) {
    barChart.draw();
    scrollBar2.draw();
  } else if (currentScreen == DISPLAY_SCREEN)
  {
    displayScreen.draw();
  }
  if (currentScreen==BAR_SCREEN_2) {
    statesBarChart.draw();
    scrollBar3.draw();
  }

  //scroll += 1;

  for (int i = 0; i < screens.get(currentScreen).widgetList.size(); i++)
  {
    screens.get(currentScreen).widgetList.get(i).draw();

    stroke(0);
  }
  screens.get(currentScreen).draw();
  drawPieChart();
  dropdown.draw();
  drawMenuButtons();
  events();
}
