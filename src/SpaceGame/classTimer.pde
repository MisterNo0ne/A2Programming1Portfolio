//Daniel Shiffman | Example 10-5: Object-oriented Timer
//Taken from http://learningprocessing.com/examples/chp10/example-10-10-rain-catcher-game
class Timer {
  float savedTime; // When Timer started
  float totalTime; // How long Timer should last
  Timer(float tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }

  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    float passedTime = millis()- savedTime;
    return (passedTime > totalTime);
  }
}
