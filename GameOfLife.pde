import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons;
private boolean[][] buffer; 
private boolean running = true; 

public void setup () {
  size(400, 400);
  frameRate(6);
  Interactive.make( this )
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      buttons[r][c] = new Life(r, c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background(0);
  if (running == false) {
    return;
  }
  copyFromButtonsToBuffer();
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      if(countNeighbors(r,c) == 3)
      {
        buffer[r][c] = true;
      } else if(countNeighbors(r,c) == 2 && buttons[r][c].getLife() == true)
      {
        buffer[r][c] = true;
      } else {
        buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(key == ' ')
  {
    running = !running;
  }
  if(key == 'c')
  {
    for(int r = 0; r < NUM_ROWS; r++)
    {
      for(int c = 0; c < NUM_COLS; c++)
      {
        buttons[r][c].setLife(false);
      }
    }
  }
}

public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  //your code here
  if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
  {
    return true;
  }
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
  private int myRow, myCol, myColor;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    myColor = color((int)(Math.random()*30)+200, (int)(Math.random()*40)+140, (int)(Math.random()*150)+200);
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; 
    Interactive.add( this );
  }
  public void mousePressed () {
    alive = !alive;
  }
  public void draw () {  
    stroke(249, 250, 230);
    if (alive != true){
      fill(17, 14, 36);
    }
    else{
      fill(myColor);
    }
    rect(x, y, width, height);
  }
  public boolean getLife() {
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
