
// Hugh 24/03
// input category and string to search
// return arraylist of matching indexes

// search for entries containing a string
public ArrayList<Integer> search(int category, String str) {
  str = str.toLowerCase();
  ArrayList<Integer> list = new ArrayList<Integer>();
  for (int i = 0; i < allCategories.size(); i++) {
    if (allCategories.get(i).get(category).toLowerCase().contains(str)) {
      list.add(i);
    }
  }
  return list;
}

// search for entries matching a string exactly
public ArrayList<Integer> searchExact(int category, String str) {
  ArrayList<Integer> list = new ArrayList<Integer>();
  for (int i = 0; i < allCategories.size(); i++) {
    if (allCategories.get(i).get(category).toLowerCase().equalsIgnoreCase(str)) {
      list.add(i);
    }
  }
  return list;
}
