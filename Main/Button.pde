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
    
  
