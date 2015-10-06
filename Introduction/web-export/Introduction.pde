/**
 * Personal Introduction for Sarah Babski
 *
 * Bubbles bounce off the walls and box.
 * Every 20 bounces, a different fact appears in the box. 
 */

int n = 100;
int count = 0;
int i = 0;
int w = 800;
int h = 800;
String fact = "Sarah Babski";
PFont f;

Bubble[] b = new Bubble[n];
Box box = new Box(w, h);

void setup() {
  size(w, h);
  for(int i = 0; i < n; i++) {
    b[i] = new Bubble(new PVector(random(width), random(height)), random(10,50));
    while(box.within(b[i].p.x, b[i].p.y, b[i].r)) {
         b[i].p = new PVector(random(width), random(height));
    }
  }
  f = createFont("Georgia", 32);
  textFont(f);
}

void draw() {
  //MOVE
  for(Bubble bubble : b) {
    bubble.atEdge();
    count += bubble.atBox();
    bubble.move();
  }
  if(count >= 20) {
   i++;
   box.switchFact(i);
   count = 0;
   box.c = 102;
  }
  
  //RENDER
  background(0);
  for(Bubble bubble : b) {
    bubble.render();
  }
  box.render();
}
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
class Bubble {
  PVector p;
  PVector v;
  float r;
  float d;
  float a;
  
  Bubble(PVector pos, float rad) {
    p = pos;
    v = PVector.random2D();
    r = rad;
    d = rad * 2;
    a = random(255) + 1;
  }
  
  void move() {
    p.add(v);
  }
  
  void atEdge() {
    if(p.x + r > width) {
      p.x = width - r;
      v.x *= -1;
    } else if(p.x - r < 0) {
      p.x = r;
      v.x *= -1;
    } else if(p.y + r > height) {
      p.y = height - r;
      v.y *= -1;
    } else if(p.y - r < 0) {
      p.y = r; 
      v.y *= -1;
    }
  }
  
  int atBox() {
    if(box.within(p.x, p.y, r)) {
      if(p.x < (width - box.w) / 2) {
        p.x = (width - box.w) / 2 - r;
        v.x *= -1;
      } else if(p.x > (width + box.w) / 2) {
        p.x = (width + box.w) / 2 + r;
        v.x *= -1;
      }
      if(p.y < (height - box.h) / 2) {
        p.y = (height - box.h) / 2 - r;
        v.y *= -1;
      } else if(p.y > (height + box.h) / 2) {
        p.y = (height + box.h) / 2 +  r;
        v.y *= -1;
      }
      box.fade();
      return 1;
    } else {
      return 0;
    }
 
    
    
  /*    
    if(box.within(p.y, p.x, r)) {
      if(box.withinY(p.y, 0)) {
        v.x *= -1;
      }
      if(box.withinX(p.x, 0)) {
        v.y *= -1;
      }
      return 1;
    } else {
     return 0;
    }
   */ 
  }

  void render() {
    noStroke();
    fill(200, a);
    ellipse(p.x,p.y,d,d);
  }
}

