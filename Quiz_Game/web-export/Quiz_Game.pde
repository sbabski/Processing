/* 
 * Surrealist Quiz Game
 * Match the painting to its artist.
 * by Sarah Babski
 */

import java.util.Collections;

private String xmlFileName = "paintings.xml";
private XML quizInfo;
private ArrayList<Question> questions= new ArrayList<Question>();
private int numOfq;
private int score = 0;
private int cQuest = 0;
private int state = 0;
private PFont f, fb;
private int time = 0;
private float s = .95;
private color col = #0AA81D;
private color auxcol = #D60408;
private color scoreCol = 0;

private final static int WID = 1425;
private final static int HEI= 975;

private Question q;
private Start restart = new Start("Restart", 50, 50);
private Start start = new Start("Start", WID/2-75, HEI/2);

private QOption tL = new QOption(100, HEI-100);
private QOption tR = new QOption(425, HEI-100);
private QOption bL = new QOption(750, HEI-100);
private QOption bR = new QOption(WID-350, HEI-100);
private QOption[] answers = {tL, tR, bL, bR};

void setup(){
 size(WID, HEI);
 f = createFont("Verdana", 24);
 fb = createFont("Verdana Bold", 50);
 textFont(f);
 quizLoadInfo();
 q = questions.get(cQuest);
}

void draw(){
  background(200);
  q = questions.get(cQuest);
  switch(state) {
    case 0:
      imageMode(CENTER);
      image(loadImage("memory.jpg"), WID/2, HEI/2);
      fill(col);
      textSize(32);
      text("Match the Surrealist painting to its artist.", WID/2, HEI/2-50);
      textFont(fb);
      start.render();
      break;
    case 1:
      for(int i = 0; i < answers.length; i++) {
        answers[i].setActive(true);
      }
      imageMode(CENTER);
      image(loadImage(q.img), WID/2, HEI/2+30);
      renderQuest(q);
      break;
    case 2:
      imageMode(CENTER);
      image(loadImage("man.jpg"), WID/2, HEI/2);
      fill(col);
      textSize(32);
      text("Final score: "+score, WID/2, HEI/2-50);
      textFont(fb);
      start.render();
      break;
    case 3:
      for(int i = 0; i < answers.length; i++) {
        answers[i].setActive(false);
      }
      scoreCol = col;
      renderQuest(q);
      result("Correct!", col);
      break;
    case 4:      
      for(int i = 0; i < answers.length; i++) {
        answers[i].setActive(false);
      }
      scoreCol = auxcol;
      result("Incorrect!", auxcol);
      renderQuest(q);
      break;
    default:
      break;
  }   
}

void result(String t, int c) {
  fill(c);
  textFont(fb);
  textSize(50);
  text(t, WID/2, HEI/2);
  time++;
  textFont(f);
  if(time >= 40) {
    scoreCol = 0;
    time = 0;
    if(cQuest >= questions.size() - 1) {
      state = 2;
    } else {
      cQuest++;
      state = 1;
    }
  }
}

void renderQuest(Question q) {
  textSize(29);
  for(int i = 0; i < answers.length; i++) {
    answers[i].render(q.pAnswers[i]);
  }
  textAlign(CENTER, CENTER);
  fill(0);
  textFont(fb);
  text(q.qText, WID / 2, 100);
  textFont(f);
  fill(scoreCol);
  text("Score: "+score, WID - 105, 60);
  restart.render();
}
  

void mousePressed(){
  if(restart.canClick() || start.canClick()) {
    startGame();
  } else {
    for(QOption a : answers) {
      if(a.canClick()) {
        checkAnswer(a);
      }
    }
  }
}

void startGame() {
  score = 0;
  Collections.shuffle(questions);
  cQuest = 0;
  state = 1;
}

void checkAnswer(QOption ans){
  if(ans.getName().equals(q.answer)){
    score += q.score;
    state = 3;
  } else {
    state = 4;
  }
}

void quizLoadInfo(){
  quizInfo = loadXML(xmlFileName);
  numOfq = quizInfo.listChildren().length;
  
  for(int i = 1; i<numOfq; i+=2){
    XML newQ = quizInfo.getChild(i);
    Question newQuestion = new Question(newQ);
    questions.add(newQuestion);
  }
  
}

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
/*
 * Class for each question in the xml file.
 */

public class Question{
 String qText;
 String answer;
 String[] pAnswers;
 String img;
 int score;
 int id;
  
  
 public Question(XML qXML){
   XML qInfo = qXML.getChild("text");
   qText = qInfo.getContent();
   img = qInfo.getString("img");
   score = qInfo.getInt("score");
   
   XML aInfo = qXML.getChild("answer");
   answer = aInfo.getContent();
   String pAnsText = aInfo.getString("ans");

   pAnswers = split(pAnsText, ',');   
 } 
  
}
/*
 * Class for the Restart button
 */
 
public class Start extends Button {
  
  public Start(String is, float ix, float iy) {
    super(is, ix, iy, true, 150, 50);
  }
}  

