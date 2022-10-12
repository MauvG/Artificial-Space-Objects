//Muavia Ghazi - 07/04/2022
// created displayScreen
// it displays information of a satelite
// get information of different satellite by changing i in the constructor in main.
// also added an animation.


class DisplayScreen {
  
  PFont displayScreenFont = loadFont("AgencyFB-Bold-48.vlw");
  int i;
  int j;
  String name;
  String launchDate;
  String status;
  String state;
  String mass;
  String diameter;
  String perigree;
  String apogee;
  String JCAT;
  
  float x;
  float y;
  
  float xpos = 50;
  float ypos = 135;
  int xSpace = 500;
  
  float textPos;
  
  float angle = 0.05;
  float scalar = 200;
  float speed = 0.05;


  DisplayScreen(int i, ArrayList nameList, ArrayList launchDateList, ArrayList statusList, ArrayList stateList, ArrayList massList, ArrayList diameterList, ArrayList perigeeList, ArrayList apogeeList)
  {
    name = "Name:  " + nameList.get(i);
    launchDate = "Launch Date:  " + launchDateList.get(i);
    status = "Status:  " + statusList.get(i);
    state = "State:  " + stateList.get(i);
    mass = "Mass:  " + massList.get(i);
    diameter = "Diameter:  " + diameterList.get(i);
    perigree = "Perigee:  " + perigeeList.get(i);
    apogee = "Apogee:  " + apogeeList.get(i);
  }

  void update(int i)
  {
    this.i = i;
    name = "Name:  " + displayedCategories.get(i).get(Name_INDEX);
    launchDate = "Launch Date:  " + displayedCategories.get(i).get(LDate_INDEX);
    status = "Status:  " + displayedCategories.get(i).get(Status_INDEX);
    state = "State:  " + displayedCategories.get(i).get(State_INDEX);
    mass = "Mass:  " + displayedCategories.get(i).get(Mass_INDEX);
    diameter = "Diameter:  " + displayedCategories.get(i).get(Diameter_INDEX);
    perigree = "Perigee:  " + displayedCategories.get(i).get(Perigee_INDEX);
    apogee = "Apogee:  " + displayedCategories.get(i).get(Apogee_INDEX);
  }
  
  void drawText() {
    textFont(displayScreenFont);
    textSize(35);
    for(int j = 0; j < CATEGORIES_AMOUNT; j++)
    {
      //text(catagoryNames[j] + ":  " + displayedCategories.get(i).get(j), xpos + (xSpace* (j/21)), ypos + (30 * (j%21)) );
      text(catagoryNames[j] + ":  " + displayedCategories.get(i).get(j), xpos + 50, ypos + (40 * j) + textPos);
      println(ypos + (30 * j) + textPos);
    }
    
  }
  
  
  void draw() {
    textFont(displayScreenFont);
    textSize(60);
    text("Name: " + displayedCategories.get(i).get(Name_INDEX), 500, 100);
    //text("Satellite Information", 500, 100);
    //textSize(40);
    //text(name, 100, 250);
    //text(launchDate, 100, 300);
    //text(status, 100, 350);
    //text(state, 100, 400);
    //text(mass, 100, 450);
    //text(diameter, 100, 500);
    //text(perigree, 100, 550);
    //text(apogee, 100, 600);
    
    drawText();

    image(earth, 750, 275);
    image(satellite, x, y);
    
    x = 860 + sin(angle) * scalar;
    y = 390 + cos(angle) * scalar;
    angle += speed;
  }
}
