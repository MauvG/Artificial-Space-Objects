
// Hugh - started 31/03
// pie chart method from processing.org example (https://processing.org/examples/piechart.html)


// calls method to draw pie chart itself, and draws everything else shown on screen
void drawPieChart() {
  if (currentScreen == PIE_SCREEN) {
      pieChart(650, angles);
      int pieChartScale = 35;
      fill(255);
      textFont(sortButtonsFont);
      textSize(40);
      text("TOTAL - " + currentTimePeriodCount, pieChartScale, pieChartScale * 1.5);
      text("LAUNCH STATE PIE CHART", 820, pieChartScale * 1.5);
      float minStateCount = (float)currentTimePeriodCount / 360;
      int x = 0;
      for (int i = 0; i < states.size(); i++) {
        if (statesCount.get(i) > (minStateCount)) {
          float percentage = (float)statesCount.get(i) / (float)currentTimePeriodCount * 100;
          percentage *= 10;
          percentage = round(percentage);
          percentage /= 10;
          if (x <= 14) {
            fill(colors[i][0], colors[i][1], colors[i][2]);
            rect(pieChartScale,x * pieChartScale + pieChartScale * 2, pieChartScale,pieChartScale);
            text(states.get(i) + " - " + statesCount.get(i) + " - " + percentage + "%",2 * pieChartScale + 10, x * pieChartScale + (pieChartScale * 3) - 1);
          } else {
            if (x <= 31) {
            fill(colors[i][0], colors[i][1], colors[i][2]);
            rect(pieChartScale + 300,(x * pieChartScale + pieChartScale * 2)   - (15 * pieChartScale), pieChartScale,pieChartScale);
            text(states.get(i) + " - " + statesCount.get(i) + " - " + percentage + "%",(2 * pieChartScale + 10) + 300,(x * pieChartScale + (pieChartScale * 3)- 1) - (15 * pieChartScale));
            }
          }
          x++;
          
        }
      }
      fill(255);
      text(minYear, 50, height - 50);
      text(maxYear, 200, height - 50);
      textSize(30);
      text("LAUNCH YEAR RANGE:",50, height - 120);
      text("FILTER:", 340, height - 120);
      textSize(20);
      text("MIN", 50, height - 90);
      text("MAX",200, height - 90);
      image(upArrow, 120, height - 90, 20,20); // min year up
      image(downArrow, 120, height - 60, 20,20); // min year down
      image(upArrow, 280, height - 90, 20,20); // max year up
      image(downArrow, 280, height - 60, 20,20); // max year down
      
      text("EXCLUDE DEBRIS", 370, height - 90);
      text("CURRENTLY IN ORBIT", 370, height - 60);
      text("MASS >= 1000KG", 370, height - 30);
      noStroke();
      rect(340,height-108,20,20);
      rect(340, height-78,20,20);
      rect(340, height-48,20,20);
      fill(100,190,255);
      if (pieChartExcludeDebris) {
        rect(342, height - 106, 16,16);
      }
      if (pieChartCurrentlyInOrbit) {
        rect(342, height - 76, 16,16);
      }
      if (pieChartMinMass) {
        rect(342, height - 46, 16,16);
      }
    }
}

// detects mouse clicking on pie chart buttons
// each button resets and creates a pie chart with the new queries
void pieMousePressed() {
  // min year increase
  if (mouseX >= 120 && mouseX <= 140 && mouseY >= height - 90 && mouseY <= height - 70 && minYear < maxYear) {
    minYear++;
    createPieChartStates();
  }
  // min year decrease
  if (mouseX >= 120 && mouseX <= 140 && mouseY >= height - 60 && mouseY <= height - 40 && minYear > minMinYear) {
    minYear--;
    createPieChartStates();
  }
  // max year increase
  if (mouseX >= 280 && mouseX <= 300 && mouseY >= height - 90 && mouseY <= height - 70 && maxYear < maxMaxYear) {
    maxYear++;
    createPieChartStates();
  }
  // max year decrease
  if (mouseX >= 280 && mouseX <= 300 && mouseY >= height - 60 && mouseY <= height - 40 && maxYear > minYear) {
    maxYear--;
    createPieChartStates();
  }
  // exclude debris filter toggle
  if (mouseX >= 340 && mouseX <= 360 && mouseY >= height - 108 && mouseY <= height - 88) {
    pieChartExcludeDebris = !pieChartExcludeDebris;
    createPieChartStates();
  }
  // currently in orbit filter toggle
  if (mouseX >= 340 && mouseX <= 360 && mouseY >= height - 78 && mouseY <= height - 58) {
    pieChartCurrentlyInOrbit = !pieChartCurrentlyInOrbit;
    createPieChartStates();
  }
  // min mass filter toggle
  if (mouseX >= 340 && mouseX <= 360 && mouseY >= height - 48 && mouseY <= height - 28) {
    pieChartMinMass = !pieChartMinMass;
    createPieChartStates();
  }
}

/*
void pieChartChangeDecade(int min, int max) {
  minYear = min;
  maxYear = max;
  states.clear();
  statesCount.clear();
  angles.clear();
  int currentTimePeriodCount = 0;
  for (int i = 0; i < allCategories.size(); i++) {
    if (getYear(allCategories.get(i).get(LDate_INDEX)) >= minYear && getYear(allCategories.get(i).get(LDate_INDEX)) <= maxYear) {
      currentTimePeriodCount++;
    }
  }
}
*/

void initMaxMinYear(){
  int minYearFound = 3000;
  int maxYearFound = 0;
  for (int i = 0; i < allCategories.size(); i++) {
    if (getYear(allCategories.get(i).get(LDate_INDEX)) > maxYearFound)
       maxYearFound = getYear(allCategories.get(i).get(LDate_INDEX));
   if (getYear(allCategories.get(i).get(LDate_INDEX)) < minYearFound && getYear(allCategories.get(i).get(LDate_INDEX)) != 0)
       minYearFound = getYear(allCategories.get(i).get(LDate_INDEX));
  }
  minYear = minYearFound;
  maxYear = maxYearFound;
  minMinYear = minYear;
  maxMaxYear = maxYear;
}


// creates an arraylist of states, excluding entries that dont fit the queries (date range and filters)
// creates a second arraylist which stores the amount of compatible entries for each state as an int. index for statesCount matches states
// creates a 2d array of colors (int R, int G, int B) based on the amount of states that will be shown on the pie chart (ie states that have enough entries to take up at least 1 degree on the pie chart)

void createPieChartStates() {
  states.clear();
  statesCount.clear();
  angles.clear();
  colors = null;
  currentTimePeriodCount = 0;
  for (int i = 0; i < allCategories.size(); i++) {
    if (getYear(allCategories.get(i).get(LDate_INDEX)) >= minYear && getYear(allCategories.get(i).get(LDate_INDEX)) <= maxYear) {
      if ((!allCategories.get(i).get(Name_INDEX).toLowerCase().contains("deb") || !pieChartExcludeDebris) 
        && (allCategories.get(i).get(Status_INDEX).equalsIgnoreCase("O") || !pieChartCurrentlyInOrbit) 
        && (Float.valueOf(allCategories.get(i).get(Mass_INDEX)) >= 1000 || !pieChartMinMass)) {
      currentTimePeriodCount++;
      }
      //println(currentTimePeriodCount);
    }
  }
  for (int i = 0; i < allCategories.size(); i++) {
    if (getYear(allCategories.get(i).get(LDate_INDEX)) >= minYear && getYear(allCategories.get(i).get(LDate_INDEX)) <= maxYear){
      if ((!allCategories.get(i).get(Name_INDEX).toLowerCase().contains("deb") || !pieChartExcludeDebris) 
        && (allCategories.get(i).get(Status_INDEX).equalsIgnoreCase("O") || !pieChartCurrentlyInOrbit) 
        && (Float.valueOf(allCategories.get(i).get(Mass_INDEX)) >= 1000 || !pieChartMinMass)) {
        String currentState = allCategories.get(i).get(State_INDEX);
        boolean newState = true;
        int index = 0;
        for (int x = 0; x < states.size(); x++) {
          if (currentState.equalsIgnoreCase(states.get(x))) {
          newState = false;
           //statesCount.set(x,statesCount.get(x) + 1);
          index = x;
          }
        }
        if (newState == true) {
          states.add(currentState);
          statesCount.add(1);
        } else {
          statesCount.set(index, statesCount.get(index) + 1);
        }
      }
    }
  }
  // call method to convert filtered list of states into angles to be used by pie chart
  createPieArrayList();
    
  // creates 2D array with RGB values for each state shown on the pie chart
  // randomises colour until it finds a suitable one to be used in the pie chart
  // color will be randomised again if it is too similar to an existing color in the pie chart (final int COLORMARGIN sets how close colors can be to each other)
  // color will be randomised if it is not bright enough (R + G + B >= 180)
  colors = new int[states.size()][3];
  float minStateCount = (float)currentTimePeriodCount / 360;
  for (int i = 0; i < states.size(); i++) {
    if (statesCount.get(i) > (minStateCount)) {
      colors[i][0] = (int)random(0,255);
      colors[i][1] = (int)random(0,255);
      colors[i][2] = (int)random(0,255);
      boolean uniqueColor = false;
      while (!uniqueColor) {
        boolean colorMatchFound = false;
          for(int x = 0; x < states.size(); x++) {
            if (i != x &&
              colors[x][0] > colors[i][0] - COLORMARGIN && colors[x][0] < colors[i][0] + COLORMARGIN &&
              colors[x][1] > colors[i][1] - COLORMARGIN && colors[x][1] < colors[i][1] + COLORMARGIN &&
              colors[x][2] > colors[i][2] - COLORMARGIN && colors[x][2] < colors[i][2] + COLORMARGIN || (colors[i][0] + colors[i][1] + colors[i][2]) < 180) {
              colorMatchFound = true;
            }
          }
          if (colorMatchFound) {
            colors[i][0] = (int)random(0,255);
            colors[i][1] = (int)random(0,255);
            colors[i][2] = (int)random(0,255);
          } else {
          uniqueColor = true;
          }
        }
      }
    }
}

// from processing.org example, changed to worked with arraylist. 
// draws pie chart from arraylist of angles and 2d array of colors
void pieChart(float diameter, ArrayList<Float> data) {
      float lastAngle = 0;
      for (int i = 0; i < data.size(); i++) {
        fill(colors[i][0], colors[i][1], colors[i][2]);
        arc(1000, height/2 + 50, diameter, diameter, lastAngle, lastAngle+radians(data.get(i)));
        lastAngle += radians(data.get(i));
      }
    
  }
  
  // creates arraylist of angles to be used in pie chart
  // only adds states that will be greater than 1 degree
  // adds "other" category to states arraylist for states that are less than 1 degree
void createPieArrayList() {
  float angleLeftover = 360;
  int otherCount = 0;
  for(int i = 0; i < states.size(); i++) {
    float angle = ((float)statesCount.get(i) * 360) / (float)currentTimePeriodCount;
    if (angle >= 1) {
      angles.add(angle);
    }
    else {
      angles.add((float)0);
      otherCount += statesCount.get(i);
    }
    }
    angleLeftover = 360;
    for (int i = 0; i < angles.size(); i++) {
      angleLeftover -= angles.get(i);
    }
  
  states.add("OTHER");
  statesCount.add(otherCount);
  angles.add(angleLeftover);
}
