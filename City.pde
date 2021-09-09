class City {
  // city variables
  int id;
  String name; 
  int p1991, p2001, p2011;
  boolean visible = true;
  boolean selected = true;
  
  PVector pos;
  PVector screenPos = new PVector(0, 0); // 2D vector  
  
  // constructor for the city class
  City(int cid, String CityName, int Population1991, int Population2001, int Population2011, String loc){
    name = CityName;
    p1991 = Population1991;
    p2001 = Population2001;
    p2011 = Population2011;
    id = cid;
    
    // splitting the x-y coords from being formatted as "x y" into two two values which can be used in the position vector. 
    String[] xy = loc.split(" ");
    if(xy[0] != "" && xy[1] != ""){
      pos = new PVector(Integer.parseInt(xy[0]), Integer.parseInt(xy[1]), 0);
    }
  }
  
  // draw the visualised box
  void drawBox(){
    
    // mapping the colour value of a given box to a range within RGB 0-255, based on population size compared to min/max population. 
    float colour = map(log(getPop()), log(minPop), log(maxPop), 255, 0);
    
    // mapping height to a given value between 20,200. 
    float sHeight = map(log(getPop()), log(minPop), log(maxPop), 20, 200);
    
    // changing width depending on the size overall
    float sWidth = 20+sHeight/50*5;
    
    // changing text size depending on city population size
    float tSize = map(log(getPop()), log(minPop), log(maxPop), 10, 20);


    pushMatrix();
    noStroke();
    
    // if city is selected, display where necessary, with the fill determined above
    if(selected){
      translate(pos.x-sWidth/2,pos.y, sHeight/2+2);
      fill(0,colour,255);
    }else{
      // set all boxes to a stroke outline with no fill, for when single view selection is chosen
      translate(pos.x-sWidth/2,pos.y, 0);
      stroke(#cdfd8a);
      sHeight = 1;
      noFill();
    }
    
    box(sWidth/2, sWidth/2, sHeight);
    screenPos.set(modelX(0, 0, 0), modelY(0, 0, 0));
    popMatrix();
  
    
    if(selected){
      fill(255);
      
      // if only one city is selected, this means single view selection is active 
      if(amountSelected == 1){
        // display more indepth statistics for the given city
        tSize = 35;
        textFont(bold);
        textSize(tSize);
        text(name, pos.x, pos.y+(sWidth/4), 5);  
        text("1991 Population: "+ p1991, pos.x, pos.y+(sWidth/4)+(3+tSize), 5);  
        text("2001 Population: "+ p2001+ " (" +percentageOf(p2001, p1991)+"% of previous)", pos.x, pos.y+(sWidth/4)+2*(3+tSize), 5);  
        text("2011 Population: "+ p2011+ " (" +percentageOf(p2011, p2001)+"% of previous)", pos.x, pos.y+(sWidth/4)+3*(3+tSize), 5);  
         
        text("1991 -> 2011 Has seen a total % change of "+ percentageOf(p2011, p1991)+"%", pos.x, pos.y+(sWidth/4)+4*(3+tSize), 5);  
      }else{
        // if more than 1 city is selected, just show the text for each city
        textFont(regular);
        textSize(tSize);
        text(name, pos.x, pos.y+(sWidth/4), 5);   
      }
    }
      


  }

  //boolean mouseOver() {
  //  return 
  //    dist(mouseX, mouseY, screenPos.x, screenPos.y) < 30;
  //}
  
  // return city name string
  String getName(){
    return name;
  }
  
  // get the population of the city. This output will change depending on which city is selected when the method is called
  int getPop(){
    switch(chosenYear) {
      case 1991: 
        return getPop1991();
      case 2001: 
        return getPop2001();  
      case 2011: 
        return getPop2011();  
    }
    return 0;
  }
  
  //return the "visible" boolean true/false
  boolean visible(){
    return visible; 
  }
  
  //return city id
  int id(){
    return id;
  }
  
  // toggle the visibility of the city
  void toggleVis(){
    visible = !visible; 
  }
  
  // set the selected boolean to the input b
  void setSelected(Boolean b){
     selected = b; 
  }
  
  // set visible to false
  void hide(){
    visible = false; 
  }
  
  //set visible to true
  void show(){
    visible = true; 
  }
  
  //return 1991 population
  int getPop1991(){
    return p1991;
  }
  
  //return 2001 population
  int getPop2001(){
    return p2001;
  }  
  
  //return 2011 population
  int getPop2011(){
    return p2011;
  }
  
  //return x coord
  float getX(){
    return pos.x;
  }
  
  //return y coord
  float getY(){
    return pos.y;
  }
  
}
