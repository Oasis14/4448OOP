class PathPoint {
  private float xPos;
  private float yPos;
  private PathPoint nextPath;
  private Boolean isBase;

  // Path Points will need to be created at the end and go back to beginning
  PathPoint(float x, float y, PathPoint nextPath){
    this.xPos = x;
    this.yPos = y;
    
    // The only PathPoint without a nextPath is the base
    if (nextPath == null){
      isBase = true;
    }
    else{
      this.nextPath = nextPath;
    }
  }
  
  /**
  * Function that returns the next pathPoint after this one
  * @return PathPoint next path point stored as instance variable
  **/
  public PathPoint getNextPoint(){
    return this.nextPath;
  }
  
  /**
  * Currently returns whether the pathpoint is within the hitbox, might want to change it so that the center is within the hitbox
  * @return Boolean whether the pathpoint is contained within the hitbox
  **/
  public Boolean collide(PShape hitbox) throws Exception{
    if( hitbox.getVertexCount() != 4){
      throw new Exception("Not a rectangle");
    }
    
    /** Vertex indices of rectangle
    * 0 -------- 1
    * |          |
    * 2 -------- 3
    **/
    // Checks x position
    if(this.xPos >= hitbox.getVertex(0).x && this.xPos <= hitbox.getVertex(1).x){
      // if x position is correct, check Y position
      if(this.yPos <= hitbox.getVertex(0).y && this.yPos >= hitbox.getVertex(3).y){
          return true;
      }
    }
    return false;
  }
  
  public float getX(){
    return this.xPos;
  }
  
  public float getY(){
    return this.yPos;
  }
  
  public Boolean isBase(){
    return this.isBase;
  }
}