class Piano{
  
  Minim minim;
  AudioOutput out;
  
  SinOsc osc;
  Env env;
  
  String[] musicalNotes = { "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5" };
  int[] pianoSheet = {2, 2, 3, 2, 5, 4,
                      2, 2, 3, 2, 6, 5,
                      2, 2, 3, 7, 5, 4, 3,
                      7, 5, 6, 5};
                      
  int pianoSheetIndex = 0;
  
  public Piano(Practica7 p7){
    minim = new Minim(p7);
    out = minim.getLineOut();
  }
  
  int changeIndex(){
    if (pianoSheetIndex + 1 == pianoSheet.length){
      return -1;
    }else{
      pianoSheetIndex++;
      return pianoSheetIndex;
    }
  }
  
  void playSound(int pianoKeyPressed){
    out.playNote(0, 0.9, new SineInstrument(Frequency.ofPitch(musicalNotes[pianoKeyPressed]).asHz()));
  }
  
  class SineInstrument implements Instrument{
  
    Oscil wave;
    Line ampEnv;
    
    SineInstrument (float frequency){
      wave = new Oscil(frequency, 0, Waves.SINE);
      ampEnv = new Line();
      ampEnv.patch(wave.amplitude);
    }
    
    void noteOn(float duration){
      ampEnv.activate(duration, 0.5f, 0);
      wave.patch(out);
    }
    
    void noteOff(){
      wave.unpatch(out);
    }
  }
}
