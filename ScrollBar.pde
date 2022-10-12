// Muavia Ghazi - made a scroll bar to be used in different screens.

class ScrollBar
{
  int barWidth, heightOfBar, barHeight;
  int xpos, ypos;
  float barPos, newBarPos;
  int sposMin, sposMax;
  boolean mouseOn;
  boolean barLocked;
  float ratio;

  ScrollBar (int xpos, int ypos, int barWidth, int heightOfBar, int barHeight) {
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.heightOfBar = heightOfBar;
    int heightToWidth = barHeight - barWidth;
    ratio = (float)barHeight / (float)heightToWidth;
    this.xpos = xpos-barWidth/2;
    this.ypos = ypos;
    barPos = ypos;
    newBarPos = barPos;
    sposMin = ypos;
    sposMax = ypos + barHeight - heightOfBar;
  }

  void update() {
    if (over()) {
      mouseOn = true;
    } else {
      mouseOn = false;
    }
    if (mousePressed && mouseOn) {
      scrolling = true;
      barLocked = true;
    }
    if (!mousePressed) {
      scrolling = false;
      barLocked = false;
    }
    if (barLocked) {
      newBarPos = constrain(mouseY-barWidth/2, sposMin, sposMax);
    }
    if (abs(newBarPos - barPos) > 1) {
      barPos = barPos + (newBarPos-barPos)/1;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if (mouseX > xpos && mouseX < xpos+barWidth &&
      mouseY > ypos && mouseY < ypos+barHeight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(255);
    rect(xpos, ypos, barWidth, barHeight);
    if (mouseOn || barLocked) {
      fill(200, 200, 200);
    } else {
      fill(150, 150, 150);
    }
    rect(xpos, barPos, barWidth, heightOfBar);
  }

  float getPos() {
    return barPos * ratio;
  }
  
  float position;
  boolean scrolling = true;
  
  void scroll() {
    
    position = getPos();   
    
    if(scrolling == true)
    {
      scroll = ((int) position - ypos - 3) * 10;
      barChart.y = -((int) position - ypos - 50);
      statesBarChart.y = (int) -(( position - ypos - 10) * 7.9);
    }
    
    //println(position);
  } 

  void draw() {

    display();
    update();
    scroll();


    if (barPos <= sposMin)
    {
      barPos = sposMin;
    } else if (barPos >= sposMax)
    {
      barPos = sposMax;
    }
  }
}
