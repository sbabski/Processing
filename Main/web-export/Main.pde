/**
 * You play a hungry character who tries to eat the blobs that are 
 * smaller than it, but is killed by the blobs that are larger than it.
 */

private final static int WID = 800;
private final static int HEI= 800;
private final static int SCRHEI = 700;
private PFont f;

private Screen screen = new Screen(WID, SCRHEI);
private Start start = new Start(SCRHEI + 25);
private Reset reset = new Reset(SCRHEI + 25);

private float loseAngle = 0;
private float loseChange = 0.01;
 
public void setup() {
  size(WID, HEI, P2D);
  f = createFont("Haettenschweiler", 32);
  textFont(f);
 }
 
public void draw() {
  //MOVE
  if(screen.getStatus() == 1) {
    screen.addBlob();
    screen.update();
  }

  //RENDER
  background(100);
  screen.render();
  if(screen.getStatus() == 2) {
    loseCircles();
    renderLose();
  } else {
    screen.renderChars();
  }
  renderMenu();
  start.render();
  reset.render();
  renderScore();
}

//Controls the Start and Reset buttons
public void mouseClicked() {
  if(start.mouseOver() && start.getActive()) {
    startGame();
  }
  if(reset.mouseOver() && reset.getActive()) {
    resetGame();
  }
}

//Controls the movement of the player
public void keyPressed() {
  if(screen.getStatus() == 1) {
    screen.moveHero();
  }
}  

//Makes the game start
public void startGame() {
  screen.setStatus(1);
  start.setActive(false);
  reset.setActive(true);
}

//Resets all characters and the score
public void resetGame() {
  screen.setStatus(1);
  screen.reset();
  screen.setScore(0);
}

//Renders the menu with the buttons and score
public void renderMenu() {
  noStroke();
  fill(50);
  rect(0, SCRHEI, WID, HEI - SCRHEI);
}

//Renders the player's score
public void renderScore() {
  textAlign(CENTER, CENTER);
  fill(200);
  text("Score: "+screen.getScore(), 400, HEI - 55);
}

//Renders the losing message
public void renderLose() {
  textAlign(CENTER, CENTER);
  fill(100);
  textSize(50);
  text("You Lose.", WID / 2, SCRHEI / 2);
  textSize(32);
}

//Renders the losing animation
public void loseCircles() {
  pushMatrix();
  translate(WID / 2, SCRHEI / 2);
    scale(0.35);
  rotate(loseAngle);
  loseAngle += loseChange;
  screen.renderChars();
  popMatrix();
}
/**
 * Class for blobs that either feed or kill the player.
 */
 
public class Blob {
  private float x;
  private float y;
  private color c = color(100, 205, 10);
  private float speed;
  private final float maxSize = 100;
  private int size;
  private PVector v;
  
  public Blob(int r) {
    size = (int(random(maxSize / 5)) + 1) * 5;
    speed = (float(int(random(4)) + 1)) / 2;
    switch(r) {
      case 0:
        //Top
        v = new PVector(0, speed);
        x = random(screen.getW());
        y = 0 - size;
        break;
      case 1:
        //Left
        v = new PVector(speed, 0);
        x = 0 - size;
        y = random(screen.getH());
        break;
      case 2:
        //Bottom
        v = new PVector(0, 0 - speed);
        x = random(screen.getW());
        y = screen.getH() + size;
        break;
      case 3:
        //Right
        v = new PVector(0 - speed, 0);
        x = screen.getW() + size;
        y = random(screen.getH());
        break;
      default:
        break;
    }
  }
  
  //Gets the x coordinate of the blob
  public float getX() {
    return x;
  }
  
  //Gets the y coordinate of the blob
  public float getY() {
    return y;
  }
  
  //Gets the size of the blob
  public int getSize() {
    return size;
  }
    
  //Returns true if the blob is within the coordinates
  //from 0 to the x or y value, respectively
  public boolean within(float xx, float yy) {
    return x >= (0 - size) && x <= (xx + size) && y >= (0 - size) && y <= (yy + size);
  }
  
  //Moves the blob by its velocity
  public void move() {
      x += v.x;
      y += v.y;
  }
  
  //Draws the blob to the screen
  public void render() {
    noStroke();
    fill(c);
    ellipse(x, y, size, size);
  }
}
/**
 * Abstract class for the Reset and Start buttons.
 */

public abstract class Button {
  private String s;
  private float x;
  private float y;
  private final static float W = 100;
  private final static float H = 50;
  private final color NCOL = color(0);
  private final color HCOL = color(50);
  private color col = NCOL;
  private boolean active;
  
  public Button(String is, float ix, float iy, boolean a) {
    x = ix;
    y = iy;
    s = is;
    active = a;
  }
  
  //Determines if the button is active
  public boolean getActive() {
    return active;
  }
  
  //Sets the button's active value
  public void setActive(boolean aa) {
    active = aa;
  }
  
  //Determines if the mouse is hovering over the button
  public boolean mouseOver() {
    if(mouseX >= x && mouseX <= x + W && mouseY >= y && mouseY <= y + H) {
      return true;
    } else {
      return false;
    }
  }
  
  //Draws the button to the screen
  public void render() {
    if(active) {
      if(mouseOver()) {
        col = HCOL;
      } else {
        col = NCOL;
      }
      noStroke();
      fill(col);
      beginShape();
      vertex(x, y);
      vertex(x + W, y);
      vertex(x + W, y + H);
      vertex(x, y + H);
      endShape();
      textAlign(CENTER, CENTER);
      fill(200);
      text(s, x + W / 2, y + H / 2 - 5);
    }
  }
}
    
  
/**
 * Class for the player-controlled character.
 */

public class Hero {
  float x;
  float y;
  final color COL = color(204, 102, 0);
  final static float SPEED = 5;
  float size = 20;
  
  public Hero(float ix, float iy) {
    x = ix;
    y = iy;
  }

  //Sets the position of the hero to the given values
  public void setPos(float sx, float sy) {
    x = sx;
    y = sy;
  }
  
  //Moves the hero given if it's going in a positive or negative 
  //direction, whether it is moving horizontally or vertically,
  //and the location at which it should wrap around the screen
  public void update(boolean dir, boolean xory, float loc) {
    float s;
    if(dir) {
      s = SPEED;
    } else {
      s = 0 - SPEED;
    }
    if(xory) {
      x += s;
      x = (x + loc) % loc;
    } else {
      y += s;
      y = (y + loc) % loc;
    }
  }
  
  //Increases the size of the hero by s
  public void grow(float s) {
    size += s;
  }
  
  //Returns true if this overlaps with the given blob
  public boolean overlap(Blob b) {
    return dist(x, y, b.getX(), b.getY()) <= (size + b.getSize()) / 2;
  }
  
  //Returns true if the hero can eat the given blob
  public boolean eat(Blob b) {
    return size >= b.getSize();
  }
  
  //Draws the hero to the screen
  public void render() {
    noStroke();
    fill(COL);
    ellipse(x, y, size, size); 
  }
}
  
/**
 * Class for the Reset button.
 */
 
public class Reset extends Button {
   
  public Reset(float iy) {
    super("Reset", 50, iy, false);
  }
}
/**
 * Class for the playable screen.
 */
 
public class Screen {
  private final float W;
  private final float H;
  
  private int score  = 0;
  //0 for not started, 1 for active, 2 for lost
  private int status = 0;
  
  private Hero hero = new Hero(WID/2, (HEI - 100) / 2);
  private ArrayList<Blob> blobs = new ArrayList<Blob>();
  
  public Screen(float iw, float ih) {
    W = iw;
    H = ih;
  }
  
  //Gets the width of the screen
  public float getW() {
    return W;
  }
  
  //Gets the height of the screen
  public float getH() {
    return H;
  }
  
  //Gets the player's score
  public int getScore() {
    return score;
  }
  
  //Sets the player's score
  public void setScore(int newScore) {
    score = newScore;
  }
  
  //Gets the status of the game
  public int getStatus() {
    return status;
  }
  
  //Sets the status of the game
  public void setStatus(int s) {
    status = s;
  }
  
  //Randomly adds a blob to the screen
  public void addBlob() {
    int r = int(random(200));
    if(r <= 3) {
      blobs.add(new Blob(r));
    }
  }
  
  //Moves all of the on-screen blobs and
  //removes the off-screen blobs
  public void update() {
    ArrayList<Blob> rem = new ArrayList<Blob>();
    for(Blob b : blobs) {
      if(b.within(W, H)) {
        b.move();
      } else {
        rem.add(b);
      }
      if(hero.overlap(b)) {
        if(hero.eat(b)) {
          score += b.getSize();
          hero.grow(b.getSize()/10);
          rem.add(b);
        } else {
          setStatus(2);
        }
      }
    }
    for(Blob b : rem) {
      blobs.remove(b);
    }
  }
  
  //Moves the hero according to the key pressed
  public void moveHero() {
    if(key == CODED) {
      switch(keyCode) {
        case UP: 
          hero.update(false, false, H);
          break;
        case DOWN:
          hero.update(true, false, H);
          break;
        case LEFT:
          hero.update(false, true, W);
          break;
        case RIGHT:
          hero.update(true, true, W);
          break;
        default:
          break;
      }
    }
  }
  
  //Resets the blobs and hero
  public void reset() {
    blobs.clear();
    hero.setPos(WID/2, (HEI - 100) /2);
  }
  
  //Draws the blobs and hero to the screen
  public void renderChars() {
    hero.render();
    for(Blob b : blobs) {
      b.render();
    }
  }
  
  //Draws the screen
  public void render() {
    noStroke();
    fill(0);
    rect(0, 0, W, H);
  }
}
/**
 * Class for the Start button.
 */
 
public class Start extends Button {
  
  public Start(float iy) {
    super("Start", 50, iy, true);
  }
  
}

