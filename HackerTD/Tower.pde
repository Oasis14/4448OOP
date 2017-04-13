class Tower {
   private int x_pos, y_pos;// cost, upCost, atkSpd, hp, dmg;
   private PImage sprite;
   private String name;
   private Projectile projectile;
   private Tower upgradeTower;
   
   Tower (int xIn, int yIn, String nameIn, String imageIn) {
     x_pos = xIn;
     y_pos = yIn;
     name = nameIn;
     sprite = loadImage(imageIn);
   }
   void display() {
     image(sprite, x_pos, y_pos); 
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