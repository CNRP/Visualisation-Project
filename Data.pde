int minPop, maxPop = 0; 
int amountSelected = cities.size();

// data loading and moving to array
void data(){
  // loading table from data file
  data = loadTable("../data/Data.csv", "header");
  //trim table
  data.trim();
  
  // setting textures from files
  map_texture = loadImage("../data/map.jpg");
  sky_texture = loadImage("../data/sky2.jpg");
  key_texture = loadImage("../data/key.png");
   
  // loop through parsing each row in table
  for(TableRow row : data.rows()){
    String city = "";
    int id = row.getInt("No");
    int pop_1991 = 0;
    int pop_2001 = 0;
    int pop_2011 = 0;
      city = row.getString("City");
      try{ 
        // parse input string to integer so it can be used in calculations
        pop_1991 = Integer.parseInt(row.getString("1991").replaceAll(",",""));
          
      }catch(Exception e) {
          pop_1991 = 0;
      }
        
      try{ 
        pop_2001 = Integer.parseInt(row.getString("2001").replaceAll(",",""));
      } catch(Exception e) {
        pop_2001 = 0;
      }
        
      try{ 
        pop_2011 = Integer.parseInt(row.getString("2011").replaceAll(",",""));
          
      } catch(Exception e) {
        pop_2011 = 0;
      }
      
      String xy = row.getString("xy");
      
      //creating a new City object for each row in the table and adding this to the global array.
      cities.add(new City(id, city, pop_1991, pop_2001, pop_2011, xy));
      
    }
  
}

// method for retriving a city from its name
City getCity(String name){
  for(City c : cities){
    if(c.getName().equalsIgnoreCase(name)) return c;
  }
  return null;
}

// method for retriving city from its ID
City getCityByID(int id){
  for(City c : cities){
    if(c.id() == id) return c;
  }
  return null;
}

// method to update the visibility of a city
void updateVis(){
  for(City c : cities){
    if(checkboxToggleCity.getArrayValue()[c.id()-1] == 1.0) c.hide();
    if(checkboxToggleCity.getArrayValue()[c.id()-1] == 0.0) c.show();
  }
  //recalculate the min/max values on for the map based on the visible cities
  minMax();
}

// if a city is selected move camera to this location and set it as selected. set all other cities to unselected
void updateSelected(){
  for(City c : cities){
    // if the selected city's button ID is equal to the city id, this city is selected
    if(radioSelectCity.getArrayValue()[c.id()-1] == 1.0){
      amountSelected = 1;
      //set selected and move camera
      c.setSelected(true);
                    // offset by +300 to give a better view 
      camX = c.getX()+300;
      camY = c.getY();
    }else{
      c.setSelected(false);
    }
  }
}

// this deems the minimum and maximum values of all the cities that are visible, giving a range in which I can plot the height of the cities. 
void minMax(){
  minPop = 10000000; 
  maxPop = 0; 
  // go through each city and determine the minimum and maximum values for each year. 
  for(City c : cities){
    if(c.visible()){
      if(chosenYear == 2011){
          if(c.getPop2011() > maxPop) maxPop = c.getPop2011();
          if(c.getPop2011() > 0 && c.getPop2011() < minPop) minPop = c.getPop2011();
      }else if(chosenYear == 2001){
          if(c.getPop2001() > maxPop) maxPop = c.getPop2001();
          if(c.getPop2001() > 0 && c.getPop2001() < minPop) minPop = c.getPop2001();
      }else if(chosenYear == 1991){
          if(c.getPop1991() > maxPop) maxPop = c.getPop1991();
          if(c.getPop1991() > 0 && c.getPop1991() < minPop) minPop = c.getPop1991();
      }
    }
  }
}

// work out a % based on two inputs
int percentageOf(int amount, int total){
  if(amount != 0 && total != 0) return amount*100/total;
  return 0;
}
