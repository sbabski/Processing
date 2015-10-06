/*
 * Abstract class for all buttons.
 */

public abstract class Button {
  private String s;
  private float x;
  private float y;
  private final float W;
  private final float H;
  private final color TCOL = color(0);
  private final color HCOL = #0AA81D;
  private color c = TCOL;
  private boolean active;
  
  public Button(String is, float ix, float iy, boolean a, float iw, float ih) {
    W = iw;
    H = ih;
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
  
  //Gets the button's string value
  public String getName() {
    return s;
  }
  
  //Sets the button's string value
  public void setName(String ss) {
    s = ss;
  }
  
  //Determines if the mouse is hovering over the button
  public boolean mouseOver() {
    if(mouseX >= x && mouseX <= x + W && mouseY >= y && mouseY <= y + H) {
      return true;
    } else {
      return false;
    }
  }
  
  //Determines if a click can be accomplished
  public boolean canClick() {
    if(mouseOver()) {
      return active;
    } else {
      return false;
    }
    //this.mouseOver() && this.getActive();
  }
  
  //Draws the button to the screen
  public void render() {
    if(canClick()) {
      c = HCOL;
    } else {
      c = TCOL;
    }
    textAlign(CENTER, CENTER);
    fill(c);
    text(s, x + W / 2, y + H / 2 - 5);
  }
}
    
  
