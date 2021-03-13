import de.bezier.guido.*;
  public final static int NUM_ROWS = 80;
  public final static int NUM_COLS = 80;
  //Declare and initialize constants NUM_ROWS and NUM_COLS = 20
  private Life[][] buttons; //2d array of Life buttons each representing one cell
  private boolean[][] buffer; //2d array of booleans to store state of buttons array
  private boolean running = true; //used to start and stop program

  public void setup () {
    size(800, 800);
    frameRate(6);
    // make the manager
    Interactive.make( this );
    buttons = new Life[NUM_ROWS][NUM_COLS];
    //your code to initialize buttons goes here
    for(int r = 0; r < NUM_ROWS; r++)
      for(int c = 0; c < NUM_COLS; c++)
        buttons[r][c] = new Life(r,c);
    //your code to initialize buffer goes here
    buffer = new boolean[NUM_ROWS][NUM_COLS];
  }
public void draw () {
  background( 0 );
  if (running == false) //pause the program
      return;
    copyFromButtonsToBuffer();
    for(int r = 0; r < NUM_ROWS; r++)
    {
      for(int c = 0; c < NUM_COLS; c++)
      {
        if(countNeighbors(r, c) == 3 )
        {
          buffer[r][c] = true;
        }
        else if(countNeighbors(r, c) == 2 && buttons[r][c].getLife()==true)
        {
          buffer[r][c] = true;
        }
        else
        {
          buffer[r][c] = false;
        }
      buttons[r][c].draw();
      }
    }
    copyFromBufferToButtons();
  }
public void keyPressed() {
  if(key == ' '){
    running = !running;
  }
  if(key == 'c'){
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLife(false);
      }
    }
  }
}
public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}
public void copyFromButtonsToBuffer() {
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}
public boolean isValid(int r, int c) {
  if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0){
    return true;
    }
  else{
    return false;
  }
  
  public int countNeighbors(int row, int col) {
  int neighbors = 0;
    if(isValid(row-1,col-1) == true && buttons[row-1][col-1].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row-1, col) == true && buttons[row-1][col].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row-1,col+1) == true && buttons[row-1][col+1].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row,col+1) == true && buttons[row][col+1].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row+1,col+1) == true && buttons[row+1][col+1].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row+1,col) == true && buttons[row+1][col].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row+1,col-1) == true && buttons[row+1][col-1].getLife() == true)
  {
    neighbors++;
  }
  if(isValid(row,col-1) == true && buttons[row][col-1].getLife() == true)
  {
    neighbors++;
  }
  return neighbors;
}
  public class Life {
    private int myRow, myCol;
    private float x, y, width, height;
    private boolean alive;

    public Life (int row, int col) {
      width = 800/NUM_COLS;
      height = 800/NUM_ROWS;
      myRow = row;
      myCol = col; 
      x = myCol*width;
      y = myRow*height;
      alive = Math.random() < .5;
      Interactive.add( this ); 
    }
    public void mousePressed () {
      alive = !alive;
    }
    public void draw () {    
      if (alive != true)
        fill(0);
      else 
      fill( 150 );
      rect(x, y, width, height);
    }
    public boolean getLife() {
      return alive;
  }
    public void setLife(boolean living) {
      alive = living;
    }
  }
