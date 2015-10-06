/**
 * You play a hungry character who tries to eat the blobs that are 
 * smaller than it, but is killed by the blobs that are larger than it.
 */

private final static int WID = 800;
private final static int HEI= 800;
private final static int SCRHEI = 700;
private PFont f;

private Screen screen = new Screen(WID, SCRHEI);
private Start start = new Start(SCRHEI + 25);
private Reset reset = new Reset(SCRHEI + 25);

private float loseAngle = 0;
private float loseChange = 0.01;
 
public void setup() {
  size(800, 800, P2D);
  f = createFont("Haettenschweiler", 32);
  textFont(f);
 }
 
public void draw() {
  //MOVE
  if(screen.getStatus() == 1) {
    screen.addBlob();
    screen.update();
  }

  //RENDER
  background(100);
  screen.render();
  if(screen.getStatus() == 2) {
    loseCircles();
    renderLose();
  } else {
    screen.renderChars();
  }
  renderMenu();
  start.render();
  reset.render();
  renderScore();
}

//Controls the Start and Reset buttons
public void mouseClicked() {
  if(start.mouseOver() && start.getActive()) {
    startGame();
  }
  if(reset.mouseOver() && reset.getActive()) {
    resetGame();
  }
}

//Controls the movement of the player
public void keyPressed() {
  if(screen.getStatus() == 1) {
    screen.moveHero();
  }
}  

//Makes the game start
public void startGame() {
  screen.setStatus(1);
  start.setActive(false);
  reset.setActive(true);
}

//Resets all characters and the score
public void resetGame() {
  screen.setStatus(1);
  screen.reset();
  screen.setScore(0);
}

//Renders the menu with the buttons and score
public void renderMenu() {
  noStroke();
  fill(50);
  rect(0, SCRHEI, WID, HEI - SCRHEI);
}

//Renders the player's score
public void renderScore() {
  textAlign(CENTER, CENTER);
  fill(200);
  text("Score: "+screen.getScore(), 400, HEI - 55);
}

//Renders the losing message
public void renderLose() {
  textAlign(CENTER, CENTER);
  fill(100);
  textSize(50);
  text("You Lose.", WID / 2, SCRHEI / 2);
  textSize(32);
}

//Renders the losing animation
public void loseCircles() {
  pushMatrix();
  translate(WID / 2, SCRHEI / 2);
    scale(0.35);
  rotate(loseAngle);
  loseAngle += loseChange;
  screen.renderChars();
  popMatrix();
}