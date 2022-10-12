//Barry, 24/03/22 //<>// //<>// //<>//
class barChart {

  final int barWidth=30;
  int x;
  int y;
  int width;
  int height;
  int textStartHeight;
  int barStartHeight;
  int originalHeight;
  int maxValue = 0;
  String[] obj;
  int[] values;
  String valueCategory;
  color barColor;
  color fillColor;
  color textColor;
  PFont barChartFont;
  boolean sizeLimit;
  double sizeConstant;
  //bar chart constructor which takes parameters for x Position, y Position, width and height of the chart. Also, titles for each data point and values for each one, and then the required colors and font.
  barChart(int x, int y, int width, int height, String[] obj, int[] values, String valueCategory, color barColor, color fillColor, color textColor)
  {
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
    this.obj=obj;
    this.values=values;
    this.valueCategory=valueCategory;
    this.barColor=barColor;
    this.fillColor=fillColor;
    this.textColor=textColor;
    this.barChartFont=loadFont("Bahnschrift-30.vlw");
    originalHeight = height;
    for (int count = 0; count < values.length; count++)
    {
      if (values[count]>width&&values[count]>maxValue) {
        sizeLimit=true;
        maxValue=values[count];
      }
    }
    sizeConstant = (double)width/ (double)maxValue;
  }

  void draw()
  {
    barStartHeight = 0;
    textStartHeight = (barStartHeight + (barWidth/2))+10;
    fill(fillColor);
    rect(x, y, width, height);
    textFont(barChartFont);
    fill(textColor);
    text(valueCategory, width/2, y-10);
    for (int count=0; count<obj.length; count++) {
      fill(255);
      text(obj[count], x-textWidth(obj[count]), y+textStartHeight);
      fill(158, 183, 229);
      text(values[count], x + 700, y+textStartHeight);  
      if (obj.length<=10) {
        textStartHeight+=height/(obj.length);
      } else
      {
        textStartHeight+=originalHeight/10;
        height+=originalHeight/10;
      }
    }
    for (int count=0; count<values.length; count++)
    {
      fill(barColor);
      if (!sizeLimit)
        rect(x, y+barStartHeight, values[count], barWidth);
      else
        rect(x, y+barStartHeight, (int)(values[count]*sizeConstant), barWidth);      //ensures that bars are not wider than width of chart : BD 31/03/22 //<>// //<>// //<>//

      if (obj.length<=10)
        barStartHeight+=height/(values.length);
      else
        barStartHeight+=originalHeight/10;
      
    }
  }
}
