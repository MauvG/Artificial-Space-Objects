ArrayList<ArrayList<String>> fileReader()
{
  //Rowan BArr
  /*
 * 
 * This method returns an ArrayList of ArrayLists of strings.
 * The format is allCategories[index][catagory]
 * So if you want to access the Name of the 105 item, use
 * allCategories.get(105).get(Name_INDEX)
 *I Have added constants in main that have the index of each category
 */
  allCategories = new ArrayList<ArrayList<String>>();
  
  String[] lines = loadStrings("gcat.tsv");
  String[] currentLine = new String[CATEGORIES_AMOUNT];
  ArrayList<String> currentCatagories = new ArrayList<String>();
  for (int i=1; i<lines.length; i++)
  {
   currentLine = lines[i].split("\t");
   if (!currentLine[Name_INDEX].equals("") && !currentLine[Name_INDEX].equals("-"))
   {
      for (int j=0; j<CATEGORIES_AMOUNT; j++)
      {
        currentCatagories.add(currentLine[j]);
      }
      allCategories.add(currentCatagories);
      currentCatagories = new ArrayList<String>();
   }
    
  }
  return allCategories;
}
