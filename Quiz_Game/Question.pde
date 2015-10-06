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
