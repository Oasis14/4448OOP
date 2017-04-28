class PlayerNameMenu extends Menu {
  int l1,l2,l3;
  char[] alpha = new char[26];
  String name;
  
  Button buttonOneUp = new Button(500,300,50, 35,255,0,"","");
  Button buttonOneDown = new Button(500,420,50, 35,255,0,"","");
  Label labelOne = new  Label(500, 400,60, 255,"A");
  
  Button buttonTwoUp = new Button(575,300,50, 35,255,0,"","");
  Button buttonTwoDown = new Button(575,420,50, 35,255,0,"","");
  Label labelTwo = new  Label(575, 400,60, 255,"A");
  
  Button buttonThreeUp = new Button(650,300,50, 35,255,0,"","");
  Button buttonThreeDown = new Button(650,420,50, 35,255,0,"","");
  Label labelThree = new  Label(650, 400,60, 255,"A");
  
  Label welcome = new  Label(400, 250,40, 255,"Please Enter A Name");
  Button submit = new Button(475,475,250, 35,255,0,"","Submit Name");
  
  PlayerNameMenu(){
    super("playerNameMenu");
    
    for(char cur = 'A'; cur <= 'Z'; ++cur){
     alpha[cur-'A']=cur; 
    }
    l1 = 0;
    l2 = 0;
    l3 = 0;
  }
  
  void update(int time) {
    buttonOneUp.update();
    buttonOneDown.update();
    buttonTwoUp.update();
    buttonTwoDown.update();
    buttonThreeUp.update();
    buttonThreeDown.update();
    submit.update();
    
    if(mouse.currentEvent == "click"){
     //check each button
     if(buttonOneUp.pressed()){
       if(l1 == 25){
        l1 = 0; 
       }else{
        l1 += 1; 
       }
       labelOne.updateLabel(alpha[l1]);
     } else if(buttonOneDown.pressed()){
       if(l1 == 0){
        l1 = 25; 
       }else{
        l1 -= 1; 
       }
       labelOne.updateLabel(alpha[l1]);
     }else if (buttonTwoUp.pressed()){
       if(l2 == 25){
        l2 = 0; 
       }else{
        l2 += 1; 
       }
       labelTwo.updateLabel(alpha[l2]);
     } else if(buttonTwoDown.pressed()){
       if(l2 == 0){
        l2 = 25; 
       }else{
        l2 -= 1; 
       }
       labelTwo.updateLabel(alpha[l2]);
     }else if (buttonThreeUp.pressed()){
       if(l3 == 25){
        l3 = 0; 
       }else{
        l3 += 1; 
       }
       labelThree.updateLabel(alpha[l3]);
     } else if(buttonThreeDown.pressed()){
       if(l3 == 0){
        l3 = 25; 
       }else{
        l3 -= 1; 
       }
       labelThree.updateLabel(alpha[l3]);
     }else if(submit.pressed()){
       name = Character.toString(alpha[l1]) + Character.toString(alpha[l2]) + Character.toString(alpha[l3]);
       player.updateName(name);
       currentMenu = "mainMenu";
     }
     
    }


  }
  
  void display(){
    beginShape();
    fill(super.fill);
    rect(400,200,400,400);
    endShape();
    buttonOneUp.display();
    buttonOneDown.display();
    labelOne.display();
    
    buttonTwoUp.display();
    buttonTwoDown.display();
    labelTwo.display();
    
    buttonThreeUp.display();
    buttonThreeDown.display();
    labelThree.display();
    
    welcome.display();
    submit.display();

  }

}