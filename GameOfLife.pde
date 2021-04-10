import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      buttons[row][col] = new Life(row, col);
    }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      buffer[row][col] = false;
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (countNeighbors(row, col) == 3) {
        buffer[row][col] = true;
      } else if (countNeighbors(row, col) == 2) {
        if (buttons[row][col].getLife() == true) {
          buffer[row][col] = true;
        }
      } else {
        buffer[row][col] = false;
      }
      buttons[row][col].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if (running == false) {
    running = true;
  } else {
    running = false;
  }
}

public void copyFromBufferToButtons() {
  //your code here
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (buffer[row][col] == true) {
        buttons[row][col].setLife(true);
      } else {
        buttons[row][col].setLife(false);
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (buttons[row][col].getLife() == true) {
        buffer[row][col] = true;
      } else {
        buffer[row][col] = false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  if (r > 19 || c > 19 || r < 0 || c < 0) {
    return false;
  }
  return true;
}

public int countNeighbors(int row, int col) {
  int total = 0;
  if (isValid(row-1, col-1) == true && buttons[row-1][col-1].getLife() == true) {
    total++;
  }
  if (isValid(row-1, col) == true && buttons[row-1][col].getLife() == true) {
    total++;
  }
  if (isValid(row-1, col+1) == true && buttons[row-1][col+1].getLife() == true) {
    total++;
  }
  if (isValid(row, col-1) == true && buttons[row][col-1].getLife() == true) {
    total++;
  }
  if (isValid(row, col+1) == true && buttons[row][col+1].getLife() == true) {
    total++;
  }
  if (isValid(row+1, col-1) == true && buttons[row+1][col-1].getLife() == true) {
    total++;
  }
  if (isValid(row+1, col) == true && buttons[row+1][col].getLife() == true) {
    total++;
  }
  if (isValid(row+1, col+1) == true && buttons[row+1][col+1].getLife() == true) {
    total++;
  }
  return total;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    if (alive == true)
      return true;
    return false;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
