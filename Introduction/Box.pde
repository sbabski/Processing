class Box {
  int w = 300;
  int h = w;
  int x;
  int y;
  int c = 102;
  
  Box(int wid, int hei) {
    x = wid / 2;
    y = hei / 2;
  }
  
  void render() {
    noStroke();
    fill(0);
    rect(x - w / 2, y - h / 2, w, h);
    textAlign(CENTER, CENTER);
    fill(c);
    text(fact, x - w / 2, y - h / 2, w, h);
  }
  
  boolean within(float xx, float yy, float r) {
    return xx + r > (width - w) / 2 && xx - r < (width + w) / 2 && yy + r > (height - h) / 2 && yy - r < (height + h) / 2;
  }
  
  void fade() {
    c -= 5;
  }
  
  void switchFact(int i) {
    switch(i) {
      case 1: fact = "I am studying Computer Science and Interactive Media.";
              break;
      case 2: fact = "I am from New York City.";
              break;
      case 3: fact = "I am nineteen years old.";
              break;
      case 4: fact = "I have a younger sister named Clare.";
              break;
      case 5: fact = "I have a plant named Mostafa II.";
              break;
      case 6: fact = "People say I have a weird taste in music.";
              break;
      case 7: fact = "They also say that my favorite TV show, The Mighty Boosh, is weird.";
              break;
      case 8: fact = "My other favorite TV show, Twin Peaks, is still surreal yet more accepted into mainstream media.";
              break;
      case 9: fact = "Sometimes I listen to zydeco music to motivate me while I program.";
              break;
      default: fact = "The end.";
    }
  }
}
