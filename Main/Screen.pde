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
