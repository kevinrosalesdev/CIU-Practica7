class Controller {

  Person person;
  Piano piano;
  boolean[] pianoKeysPressed = new boolean[13];
  boolean[] pianoKeysReleased = new boolean[13];
  char[] pianoKeys = {'º', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '\'', '¡'};
  AudioIn IN;
  Amplitude level;
  Practica7 p7;

  Controller(Practica7 p7, Person person, Piano piano) {
    this.person = person;
    this.piano = piano;
    this.p7 = p7;
    
    IN = new AudioIn(this.p7, 0);
    level = new Amplitude(this.p7);
    level.input(IN);
    IN.start();
    
    for (int i = 0; i < pianoKeysReleased.length; i++) pianoKeysReleased[i] = true;
  }

  void playPianoKeysPressed() {
    for(int i = 0; i < pianoKeysPressed.length; i++){
      if (pianoKeysPressed[i]){
        piano.playSound(i);
        if (!isMenu){
          if (i == piano.pianoSheet[piano.pianoSheetIndex]) {
            if (piano.changeIndex() == -1){
              p7.bigMessage = "Última puntuación: " + int(100 - person.status) + "/100";
              p7.isMenu = true;
              p7.person = new Person();
              p7.piano = new Piano(p7);
              p7.controller = new Controller(p7, person, piano);
            }
            person.changeStatus(-4);
          }else{
            person.changeStatus(7.5);
          }
        }
        pianoKeysPressed[i] = false;
      }
    }
  }

  void manageKeysPressed(char key, boolean isPressed) {
    for (int i = 0; i < pianoKeys.length; i++){
      if (key == pianoKeys[i] && pianoKeysReleased[i]) pianoKeysPressed[i] = isPressed;
      if (key == pianoKeys[i]) pianoKeysReleased[i] = !isPressed;
    }
  }
  
  float capturePuff(){
    return level.analyze();
  }
}
