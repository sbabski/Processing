/*
 * Class for each answer option
 */
 
public class QOption extends Button {
  
  public QOption(float ix, float iy) {
    super("", ix, iy, true, 250, 75);
  }
  
  void render(String ss) {
    setName(ss);
    super.render();
  }
}  
