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
  
