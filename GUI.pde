ControlP5 cp5;
CheckBox checkboxToggleCity;
RadioButton radioSelectYear, radioMenu, radioSelectCity;

// adding both sets of buttons, one for the hide/view menu and one for the select menu.
void newCheckBox(String name, int x, int y){
  checkboxToggleCity.addItem(name,x);
  radioSelectCity.addItem(name+" ",x*2);
}

// controling button events from the controlp5 buttons
void controlEvent(ControlEvent e) {
  println(e.getName());
  
  if (e.isFrom(checkboxToggleCity)) updateVis();

  if (e.isFrom(radioSelectCity)) updateSelected();

  if(e.isFrom(radioSelectCity) && e.getValue() == -1.0){ 
    for(City c : cities){
      amountSelected = cities.size();
      c.setSelected(true);
    }
  }

  // if the event is from the select year radio button menu, depending on which input is selected, change year.
  if(e.isFrom(radioSelectYear)) {
    switch (int(e.getValue())) {
      case 103: chosenYear = 1991;
        break;
      case 104: chosenYear = 2001;
        break;
      case 105: chosenYear = 2011;
        break;
      default: chosenYear = 2011;
        break;
    }
    updateVis();
  }
  
  //if the event is from the main radio menu, hide any other menu and show the required menu
  if(e.isFrom(radioMenu)){
    if(e.getValue() == 101.0){ 
      checkboxToggleCity.show(); 
      radioSelectCity.hide(); 
      keybgHeight = 260;
    }else if(e.getValue() == 102.0){
      radioSelectCity.show(); 
      checkboxToggleCity.hide();
      keybgHeight = 260;
    }
    if(e.getValue() == -1.0){ 
      checkboxToggleCity.hide();
      radioSelectCity.hide();
      keybgHeight = 0;
    }
  }

}

PShape titlebg; 

void addGUI(){
  
  // adding texture to the population key graphic. 
  rectMode(CORNERS);
  pkey = createShape(RECT, 0, 0, 53, 112);
  pkey.setTexture(key_texture);
  
  // adding a background shape to contrast the onscreen title text.
  rectMode(LEFT);
  titlebg = createShape(RECT, 0, 0, 300, 50);
  titlebg.setFill(color(25,25,25));
  
  cp5 = new ControlP5(this);
  
  // Style options for the button's used
  /* hide/show cities and select city radio buttons menu */
  radioMenu = cp5.addRadioButton("Menu")
         .setPosition(20,20)
         .setSize(20,20)
         .setColorBackground(color(#56b64e))
         .setColorForeground(color(#2f8528))
         .setColorActive(color(#0b290a))
         .setColorLabel(color(255))
         .setItemsPerRow(5)
         .setSpacingColumn(120)
         .addItem("Hide Show Cities",101)
         .addItem("Select City",102)
         ;
  
  /* menu items for adding and removing cities from view */
  checkboxToggleCity = cp5.addCheckBox("cityToggle")
                .setPosition(20, 65)
                .setColorBackground(color(#56b64e))
                .setColorForeground(color(#2f8528))
                .setColorActive(color(#bd2323))
                .setColorLabel(color(255))
                .setSize(20, 20)
                .setItemsPerRow(15)
                .setSpacingColumn(100)
                .setSpacingRow(10)
                .setFont(regular)
                ;  
   checkboxToggleCity.hide();             
   
   /* menu items for 'selecting' to focus on a city */
   radioSelectCity = cp5.addRadioButton("citySelect")
                .setPosition(20, 65)
                .setColorBackground(color(#bebebe))
                .setColorForeground(color(#979797))
                .setColorActive(color(#56b64e))
                .setColorLabel(color(255))
                .setSize(20, 20)
                .setItemsPerRow(15)
                .setSpacingColumn(100)
                .setSpacingRow(10)
                .setFont(regular)
                ;  
   radioSelectCity.hide();         
   
   /* radio buttons to select what year is being viewed */
   radioSelectYear = cp5.addRadioButton("yearSelect")
         .setPosition(350,20)
         .setSize(20,20)
         .setColorBackground(color(#ffa500))
         .setColorForeground(color(#ce8500))
         .setColorActive(color(#664200))
         .setColorLabel(color(255))
         .setItemsPerRow(5)
         .setSpacingColumn(120)
         .addItem("Select 1991",103)
         .addItem("Select 2001",104)
         .addItem("Select 2011",105)
         ;
        
  for(Toggle t:radioSelectYear.getItems()) {
    t.getCaptionLabel().setColorBackground(color(255,80));
    t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
    t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
    t.getCaptionLabel().getStyle().backgroundWidth = 100;
    t.getCaptionLabel().getStyle().backgroundHeight = 13;       
  } 
  
  // for every city, add a button  
  int i = 1;
  for(City c : cities){
    //println(i+"city: "+c.getName()+" "+c.getPop1991()+" "+c.getPop2001()+" "+c.getPop2011());
    newCheckBox(c.getName(), 20, i*20);
    i++;
  }
  
}
