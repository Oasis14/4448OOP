class Projectile implements Cloneable {
   private float xPos, yPos;// cost, upCost, atkSpd, hp, dmg;
   private PImage sprite;
   private int dmg;
   private int speed;
   private Creep target;
   private float angle;
   
   Projectile (String imageIn, int dmg, int speed) {
     this.sprite = loadImage(imageIn);     
     this.dmg = dmg;
     this.speed = speed;
   }
   
   /**
   * Function to display the Projectile
   **/
   public void display() {
     image(sprite, xPos, yPos); 
   }
   
   /**
   * Function to update the logic
   **/
   public void update(){
    this.updatePos();
   }
   
   /**
   * Move the bullet closer
   **/
   public void updatePos(){
     FloatDict targetPos = this.target.getPos();
     float slopeGrade = (targetPos.get("x") - this.xPos) / ( targetPos.get("y") - this.yPos);
    
    /** 
    * Use trig to get y += cos(theta) * speed
    * theta = arctan( (x_2 - x_1) / (y_2 - y_1) )
    * cos(arctan(x)) => 1 / sqrt(x^2 + 1^2)
    **/
    
    int yMult;
    if(targetPos.get("y") - this.yPos >= 0){
      yMult = 1;
    }else{
      yMult = -1;
    }
    float yFactor = yMult / ( sqrt(pow(slopeGrade, 2) + 1));
    float yTranslation = yFactor * this.speed;
    this.yPos += yTranslation;

     
    // Same but with sin(arctan(x) => x / sqrt(x^2 + 1^2)
    int xMult;
    if(targetPos.get("x") - this.xPos >= 0){
      xMult = 1;
    }else{
      xMult = -1;
    }
    float xFactor = xMult * abs(slopeGrade) / ( sqrt(pow(slopeGrade, 2) + 1));
    float xTranslation = xFactor * this.speed;
    this.xPos += xTranslation;
   }
   
   
   protected Object shootProjectile(int x, int y, Creep target){
     this.target = target;
     this.xPos = x - this.sprite.width / 2;
     this.yPos = y - this.sprite.height / 2;
     
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
    
   
}