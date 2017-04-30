//used to get the return from the query.
class Score{
    public String NAME;
    public int SCORE;
    
    public String toString()
    {
        return String.format("%s           %d", NAME, SCORE);
    }
    
    public void display(int x, int y){
      Label l = new Label(x, y,32, 255 ,this.NAME);
      Label l2 = new Label(x + 150, y,32, 255 ,Integer.toString(this.SCORE));
      l.display();
      l2.display();
    }
}