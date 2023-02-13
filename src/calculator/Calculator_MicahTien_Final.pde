//Micah Tien | Oct 26 2022 to | Calculator
//A calculator application with the 4 basic operations plus a few more.

Button[] buttons;
float number1;
String string1;
char operation;
float number2;
String string2;
int entryMode;
boolean degreeMode;
Button degreeModeChanger;

void setup() {
  size(340, 600);
  buttons = new Button[22];
  buttons[0] = new Button(100.0, 440.0, 60.0, 60.0, '0');
  buttons[1] = new Button(20.0, 360.0, 60.0, 60.0, '1');
  buttons[2] = new Button(100.0, 360.0, 60.0, 60.0, '2');
  buttons[3] = new Button(180.0, 360.0, 60.0, 60.0, '3');
  buttons[4] = new Button(20.0, 280.0, 60.0, 60.0, '4');
  buttons[5] = new Button(100.0, 280.0, 60.0, 60.0, '5');
  buttons[6] = new Button(180.0, 280.0, 60.0, 60.0, '6');
  buttons[7] = new Button(20.0, 200.0, 60.0, 60.0, '7');
  buttons[8] = new Button(100.0, 200.0, 60.0, 60.0, '8');
  buttons[9] = new Button(180.0, 200.0, 60.0, 60.0, '9');
  buttons[10] = new Button(20.0, 440.0, 60.0, 60.0, '±');
  buttons[11] = new Button(100.0, 120.0, 60.0, 60.0, '÷');
  buttons[12] = new Button(180.0, 120.0, 60.0, 60.0, 'x');
  buttons[13] = new Button(260.0, 120.0, 60.0, 60.0, '-');
  buttons[14] = new Button(260.0, 200.0, 60.0, 140.0, '+');
  buttons[15] = new Button(20.0, 120.0, 60.0, 60.0, 'C');
  buttons[16] = new Button(180.0, 440.0, 60.0, 60.0, '.');
  buttons[17] = new Button(260.0, 360.0, 60.0, 140.0, '=');
  buttons[18] = new Button(20.0, 520.0, 60.0, 60.0, '√');
  buttons[19] = new Button(100.0, 520.0, 60.0, 60.0, '^');
  buttons[20] = new Button(180.0, 520.0, 60.0, 60.0, 's');
  buttons[21] = new Button(260.0, 520.0, 60.0, 60.0, 'c');
  degreeModeChanger = new Button(20.0, 90.0, 140.0, 20.0, 'd');
  number1 = 0;
  string1 = "0";
  operation = ' ';
  number2 = 0;
  string2 = "0";
  entryMode = 1;
  degreeMode = false;
  /*
  1 means entering normal digits in num1
  2 means entering a decimal in num1
  3 means entering normal digits in num2
  4 means entering a decimal in num2
  */
}

void draw() {
  updateDisplay();
}

void mouseReleased() {
  boolean notDoneYet = true;
  for (int i=0; i<buttons.length && notDoneYet; i++) {
    if (mouseIn(buttons[i].x, buttons[i].y, buttons[i].w, buttons[i].h)) {
      if (entryMode == 1) {//haven't pressed the equals sign
        if ((i >= 11 && i <= 14) || (i >= 18)) { //8 ops +, -, *, /, ^, √, sin, and cos
          entryMode = 3; //start entering digits in num2
          operation = buttons[i].c;
        } else if (i == 10) { //the plus minus button
          number1 *= -1;
          if (number1 == int(number1)) {
            string1 = str(int(number1));
          } else {
            string1 = str(number1);
          }
        } else if (i == 15) { //the clear button
          number1 = 0;
          string1 = "0";
          entryMode = 1;
        } else if (i == 16) { //the . button
          entryMode = 2;
        } else if (i != 17) { //an actual digit
          if (string1 != "0") {
            string1 += buttons[i].c;
          } else {
            string1 = str(buttons[i].c);
          }
          number1 = float(string1);
        }
      } else if (entryMode == 2 && (i <= 10 || i == 16)) {
        if (i == 10) { //the plus minus button
          number1 *= -1;
          string1 = str(int(number1));
        } else if (i == 16) { //the point button
          //get rid of the point
          entryMode = 1;
        } else {
          string1 += '.';
          string1 += buttons[i].c;
          number1 = float(string1);
          entryMode = 1;
        }
      } else if (entryMode == 3) {
        if ((i >= 11 && i <= 14) || (i >= 18)) { //8 ops +, -, *, /, ^, √, sin, and cos
          if (string2 != "0") {
            performCalculation();
            entryMode = 3; //start entering digits in num2
            operation = buttons[i].c;
          }
        } else if (i == 10) { //the plus minus button
          number2 *= -1;
          if (number2 == int(number2)) {
            string2 = str(int(number2));
          } else {
            string2 = str(number2);
          }
        } else if (i == 15) { //the clear button
          if (number2 == 0) {
            number1 = 0;
            string1 = "0";
            operation = ' ';
            entryMode = 1;
          }
          number2 = 0;
          string2 = "0";
        } else if (i == 16) { //the point button
          entryMode = 4;
        } else if (i == 17) { //the equals sign button
          performCalculation();
          entryMode = 1;
        } else { //an actual digit
          if (string2 != "0") {
            string2 += buttons[i].c;
          } else {
            string2 = str(buttons[i].c);
          }
          number2 = float(string2);
        }
      } else {
        if (i == 10) { //the plus minus button
          number2 *= -1;
          string2 = str(int(number2));
        } else if (i == 16) { //the point button
          //get rid of the point
          entryMode = 3;
        } else {
          string2 += '.';
          string2 += buttons[i].c;
          number2 = float(string2);
          entryMode = 3;
        }
      }
      notDoneYet = false;
    }
  }
  if (mouseIn(degreeModeChanger.x, degreeModeChanger.y, degreeModeChanger.w, degreeModeChanger.h)) {
    degreeMode = !degreeMode;
  }
}

void updateDisplay() {
  background(200);
  
  //display background
  fill(240);
  stroke(0);
  strokeWeight(3);
  rect(17.5, 17.5, 310, 60);
  
  //display type
  textAlign(RIGHT);
  textSize(50);
  fill(0);
  String displayValue;
  if (entryMode == 1) {
    displayValue = string1;
  } else if (entryMode == 2) {
    displayValue = string1 + '.';
  } else if (entryMode == 3) {
    if (string2 != "0") {
      if (operation == '√' && number1 == 0) {
        displayValue = operation + " " + string2;
      } else if (operation == 's') {
        displayValue = string1 + " sin " + string2;
      } else if (operation == 'c') {
        displayValue = string1 + " cos " + string2;
      } else {
        displayValue = string1 + " " + operation + " " + string2;
      }
    } else {
      if (operation == '√' && number1 == 0) {
        displayValue = operation + " ";
      } else if (operation == 's') {
        displayValue = string1 + " sin ";
      } else if (operation == 'c') {
        displayValue = string1 + " cos ";
      }  else {
        displayValue = string1 + " " + operation + " ";
      }
    }
  } else {
    displayValue = string1 + " " + operation + " " + string2 + '.';
  }
  if (textWidth(displayValue) > 300) {
    textSize(50*(300/textWidth(displayValue)));
  }
  text(displayValue, 320, 62);
  
  //buttons
  textSize(32);
  textAlign(CENTER);
  stroke(0);
  for (int i=0; i<buttons.length; i++) {
    buttons[i].display();
  }
  
  //degree/radians
  degreeModeChanger.display();
  fill(180);
  rect(180, 90, 140, 20, 5);
  fill(0);
  text((degreeMode)?"Degree Mode On":"Radian Mode On", 250, 104);
}

void keyPressed() {
  int i = 0;
  if (keyCode == 12) i = 15;//Clear
  else if (keyCode == 111) i = 11;//Divide
  else if (keyCode == 106) i = 12;//Times
  else if (keyCode == 109) i = 13;//Minus
  else if (keyCode == 107) i = 14;//Plus
  else if (keyCode == 10) i = 17;//Enter
  else if (keyCode == 110) i = 16;//Dot
  else if (keyCode >= 96 && keyCode <= 105) i = keyCode-96;

  if (entryMode == 1) {//haven't pressed the equals sign
    if ((i >= 11 && i <= 14) || (i >= 18)) { //8 ops +, -, *, /, ^, √, sin, and cos
      entryMode = 3; //start entering digits in num2
      operation = buttons[i].c;
    } else if (i == 10) { //the plus minus button
      number1 *= -1;
      if (number1 == int(number1)) {
        string1 = str(int(number1));
      } else {
        string1 = str(number1);
      }
    } else if (i == 15) { //the clear button
      number1 = 0;
      string1 = "0";
      entryMode = 1;
    } else if (i == 16) { //the . button
      entryMode = 2;
    } else if (i != 17) { //an actual digit
      if (string1 != "0") {
        string1 += buttons[i].c;
      } else {
        string1 = str(buttons[i].c);
      }
      number1 = float(string1);
    }
  } else if (entryMode == 2 && (i <= 10 || i == 16)) {
    if (i == 10) { //the plus minus button
      number1 *= -1;
      string1 = str(int(number1));
    } else if (i == 16) { //the point button
      //get rid of the point
      entryMode = 1;
    } else {
      string1 += '.';
      string1 += buttons[i].c;
      number1 = float(string1);
      entryMode = 1;
    }
  } else if (entryMode == 3) {
    if ((i >= 11 && i <= 14) || (i >= 18)) { //8 ops +, -, *, /, ^, √, sin, and cos
      if (string2 != "0") {
        performCalculation();
        entryMode = 3; //start entering digits in num2
        operation = buttons[i].c;
      }
    } else if (i == 10) { //the plus minus button
      number2 *= -1;
      if (number2 == int(number2)) {
        string2 = str(int(number2));
      } else {
        string2 = str(number2);
      }
    } else if (i == 15) { //the clear button
      if (number2 == 0) {
        number1 = 0;
        string1 = "0";
        operation = ' ';
        entryMode = 1;
      }
      number2 = 0;
      string2 = "0";
    } else if (i == 16) { //the point button
      entryMode = 4;
    } else if (i == 17) { //the equals sign button
      performCalculation();
      entryMode = 1;
    } else { //an actual digit
      if (string2 != "0") {
        string2 += buttons[i].c;
      } else {
        string2 = str(buttons[i].c);
      }
      number2 = float(string2);
    }
  } else {
    if (i == 10) { //the plus minus button
      number2 *= -1;
      string2 = str(int(number2));
    } else if (i == 16) { //the point button
      //get rid of the point
      entryMode = 3;
    } else {
      string2 += '.';
      string2 += buttons[i].c;
      number2 = float(string2);
      entryMode = 3;
    }
  }
}

void performCalculation() {
  if (operation == '+') {
    number1 = number1 + number2;
  } else if (operation == '-') {
    number1 = number1 - number2;
  } else if (operation == '÷') {
    number1 = number1 / number2;
  } else if (operation == 'x') {
    number1 = number1 * number2;
  } else if (operation == '√') {
    number1 = (number1 == 0)?pow(number2, 0.5):number1 * pow(number2, 0.5);
  } else if (operation == '^') {
    number1 = pow(number1, number2);
  } else if (operation == 's') {
    number1 = number1 * sin((degreeMode)?radians(number2):number2);
  } else if (operation == 'c') {
    number1 = number1 * cos((degreeMode)?radians(number2):number2);
  }
  
  if (number1 == int(number1)) {
    string1 = str(int(number1));
  } else {
    string1 = str(number1);
  }
  operation = ' ';
  number2 = 0;
  string2 = "0";
}

boolean mouseIn(float xval, float yval, float wval, float hval) {
  return (mouseX > xval && mouseX < xval+wval && mouseY > yval && mouseY < yval+hval) ? true : false;
}

void epic() {
  println("epic");
  epic();
}
