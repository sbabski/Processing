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
