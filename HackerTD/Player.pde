public class Player {
  public String name;
  public int money;
  public int score;
  public Menu menu;
  
  Player(String newName){
    name=newName;
    money=100;
    score=0;
  }
  
  public void reset(){
    this.money = 100;
    this.score = 0;
  }
  
  public void updateScore(int score){
    this.score = score;
  }
  
  public void addScore(int score){
    this.score += score;
  }

  public void updateMoney(int money){
    this.money = money;
  }
  
  public void addMoney(int money){
    this.money += money;
  }

  public void removeMoney(int money){
    this.money -= money;
  }
  
  /**
  private static Player instance = null;
   protected Player() {
      // Exists only to defeat instantiation.
   }
   public static Player getInstance() {
      if(instance == null) {
         instance = new Player();
      }
      return instance;
   }
   **/
}