
// Hugh 29/03

class Menu {
  boolean open = false;
  int buttonX = SCREEN_WIDTH - 50;
  int buttonY = 0;
  int buttonSize = 50;
  int moveCount = 0;
  int maxMoveCount = 30;
  boolean opening = false;
  boolean closing = false;
  int margin = 30;
  
  void mousePressed() {
    if (mouseX >= buttonX && mouseX <= (buttonX + buttonSize) && mouseY >= buttonY && mouseY <= (buttonY + buttonSize)) {
      if (open && !opening && !closing) {
        moveCount = maxMoveCount;
        closing = true;
      } else if (!open && !opening && !closing) {
        opening = true;
      }
    }
  }
  void draw() {
    fill(255);
    //text(moveCount, 200,200);
    if (opening) {
      openMenu();
    }
    if (closing) {
      closeMenu();
    }
    noStroke();
    fill(255);
    rect(((SCREEN_WIDTH - ((400/30) * moveCount))),0,(400 / 30) * moveCount,SCREEN_HEIGHT);
    if (open) {
      //rect(((SCREEN_WIDTH - 400)),0,400,SCREEN_HEIGHT);
    }
    fill(100);
    rect(buttonX,buttonY,buttonSize,buttonSize);
    fill(255);
    rect(buttonX + 6, buttonY + 7, buttonSize - 12, 8);
    rect(buttonX + 6, buttonY + 21, buttonSize - 12, 8);
    rect(buttonX + 6, buttonY + 35, buttonSize - 12, 8);
  }
  void openMenu() {
    if (moveCount < maxMoveCount) {
      moveCount += 5;
    } else {
      open = true;
      opening = false;
    }
  }
  void closeMenu() {
    if (moveCount > 0) {
      moveCount-=5;
    } else {
      open = false;
      closing = false;
      moveCount = 0;
    }
  }
}

class MenuButton {
  int height;
  int page;
  String label;
  boolean hover = false;
  MenuButton(int heightInput, int pageInput, String labelInput) {
    height = heightInput;
    page = pageInput;
    label = labelInput;
  }
  void draw() {
    textFont(sortButtonsFont);
    textSize(30);
    if (!hover)
    fill(255,0,0);
    else 
    fill(0);
    text(label, ((SCREEN_WIDTH - ((400/30) * dropdown.moveCount))) + dropdown.margin, height);
  }
  void mouseMoved() {
    if (mouseX > SCREEN_WIDTH - 400 && mouseY >= height - 35 && mouseY <= height + 10 && dropdown.open)
      hover = true;
      else 
       hover = false;
  }
  void mousePressed() {
    if (mouseX > SCREEN_WIDTH - 400 && mouseY >= height - 35 && mouseY <= height + 10 && dropdown.open)
      currentScreen = page;
    if (mouseX < SCREEN_WIDTH - 400 && dropdown.open) {
      dropdown.moveCount = dropdown.maxMoveCount;
      dropdown.closing = true;
    }
  }
}
ArrayList<MenuButton> menuButtons = new ArrayList();
void init_menuButtons() {
  menuButtons.add(new MenuButton(100,MAIN_MENU,"Home"));
  menuButtons.add(new MenuButton(150, SEARCH_SCREEN,"Search"));
  menuButtons.add(new MenuButton(200, BAR_SCREEN,"Bar Chart"));
  menuButtons.add(new MenuButton(250, PIE_SCREEN,"Pie Chart"));
  menuButtons.add(new MenuButton(300, DISPLAY_SCREEN,"Display Screen"));
  
}
void drawMenuButtons() {
  for (int i = 0; i < menuButtons.size(); i++) {
    menuButtons.get(i).draw();
  }
}
void menuButtonsMouseMoved() {
  for (int i = 0; i < menuButtons.size(); i++) {
    menuButtons.get(i).mouseMoved();
  }
}
void menuButtonsMousePressed() {
  for (int i = 0; i < menuButtons.size(); i++) {
    menuButtons.get(i).mousePressed();
  }
}
