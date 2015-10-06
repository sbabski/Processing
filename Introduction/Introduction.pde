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
