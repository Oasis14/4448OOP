class Tower implements Cloneable {
   private int xPos, yPos;// cost, upCost, atkSpd, hp, dmg;
   private PImage sprite;
   private String name;
   private Projectile projectile;
   private Tower upgradeTower;
   
   Tower (int xIn, int yIn, String nameIn, String imageIn) {
     this.xPos = xIn;
     this.yPos = yIn;
     this.name = nameIn;
     this.sprite = loadImage(imageIn);
   }
   
   void display() {
     image(sprite, xPos, yPos); 
   }
   
   protected Object placeTower(int x, int y){
     this.xPos = x - this.sprite.width / 2;
     this.yPos = y - this.sprite.height / 2
     ;
     try{
       return this.clone();
     }
     catch(CloneNotSupportedException e)
     {
       return null;
     }
   }
   
    protected Object clone() throws CloneNotSupportedException
    {
        return super.clone();
    }
   /*void shoot () {
     
   }
   void upgrade () {
     
   }
   void destroy () {
     
   }
   void refund () {
     
   }
   void damage (int dmg) {
     
   }*/
}