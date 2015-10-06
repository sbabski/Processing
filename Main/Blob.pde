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
