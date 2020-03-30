import processing.sound.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

//import gifAnimation.*;

//GifMaker ficherogif;
//int frameCounter;

Piano piano;
Person person;
Controller controller;
PFont font, menuFont;
boolean isMenu = true;
String bigMessage = "¡Bienvenido al animador de personas!";

void setup() {
  size(800, 600);

  //ficherogif = new GifMaker(this, "animation.gif");
  //ficherogif.setRepeat(0);
  //ficherogif.addFrame();
  //frameCounter = 0;
  
  font = loadFont("LucidaBright-48.vlw");
  menuFont = loadFont("Corbel-Bold-48.vlw");
  person = new Person();
  piano = new Piano(this);
  controller = new Controller(this, person, piano);
}

void draw() {  
  //frameCounter++;
  //if(frameCounter == 10){
  //  ficherogif.addFrame();
  //  frameCounter = 0;
  //}
  
  background(255);
  drawPiano();
  drawPersonMoodImage();
  drawPersonMoodStatus();
  controller.playPianoKeysPressed();
  if (!isMenu){
    person.changeStatus(+0.1);
    if (controller.capturePuff() > 0.01 && controller.capturePuff() < 0.05) person.changeStatus(-0.25);
    else person.changeStatus(0.5);
  }
}

void drawPiano(){
  noStroke();
  
  for (int i = 0; i < 13; i++) {
    if (!controller.pianoKeysReleased[i]) fill(64);
    else if (i % 2 == 0) fill(255);
    else fill(0);
    rect(i*(width/13), (height*0.75), (width/13), height*0.25);
  }
  
  if (!isMenu && controller.pianoKeysReleased[piano.pianoSheet[piano.pianoSheetIndex]]){
    fill(255, 255, 0);
    rect(piano.pianoSheet[piano.pianoSheetIndex]*(width/13), (height*0.75), (width/13), height*0.25);
  }
  
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(0, (height*0.75), width, height*0.25);
  
  textFont(font, 15);
  fill(255, 0, 0);
  for(int i = 0; i < 13; i++) text(controller.piano.musicalNotes[i], i*width*((float) 1/13) + width*0.03, height*0.975);
  fill(128, 128, 255);
  for(int i = 0; i < 13; i++) text('\'' + str(controller.pianoKeys[i]) + '\'', i*width*((float) 1/13) + width*0.03, height*0.925);
}

void drawPersonMoodImage(){
  float personStatus = person.status;
  if (personStatus > 50) fill(255,map(personStatus, 51, 100, 255, 0), 0);
  else fill(map(personStatus, 0, 50, 0, 255), 255, 0);
  rect(0, 0, 0.75*width, 0.75*height);
  
  if (!isMenu) image(person.img[(int) map(personStatus, 0, 100, 0, 7.999)], 0.1*width, 0.1*height, 0.55*width, 0.55*height);
  else drawMenu();
  
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(0, 0, 0.75*width, 0.75*height);
}

void drawPersonMoodStatus(){
  fill(255, 255, 0);
  rect(0.75*width, 0, 0.25*width, 0.1*height);
  
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(0.75*width, 0, 0.25*width, 0.1*height);
  
  textFont(font, 22.5);
  fill(255, 0, 0);
  textAlign(CENTER);
  text("Estado de", 0.875*width, 0.04*height);
  text("ánimo", 0.875*width, 0.08*height);
  
  fill(255, 230, 147);
  rect(0.75*width, 0.1*height, 0.25*width, 0.65*height);
  
  float personStatus = person.status;
  if (personStatus > 50) fill(255,map(personStatus, 51, 100, 255, 0), 0);
  else fill(map(personStatus, 0, 50, 0, 255), 255, 0);
  rect(0.75*width, 0.75*height, 0.25*width, -map(personStatus, 0, 100, 0, 0.65)*height);
}

void keyPressed() {
  controller.manageKeysPressed(key, true);
  if (key == ENTER || key == RETURN){
    isMenu = !isMenu;
    person = new Person();
    piano = new Piano(this);
    controller = new Controller(this, person, piano);
  }
}

void keyReleased() {
  controller.manageKeysPressed(key, false);
}

void drawMenu(){
    textFont(font, 20);
    fill(255, 0, 0);
    textAlign(CENTER);
    text(bigMessage, 0.375*width, 0.1*height);
    fill(128, 0, 255);
    textFont(menuFont, 13.5);
    text("Tu objetivo será animar a la persona que sustituirá a este texto en cuanto le des a", 0.35*width, 0.175*height);
    text("Puedes pulsarlo de nuevo para volver a este menú y reiniciar la partida.", 0.375*width, 0.225*height);
    text("Para animarlo, deberás tocar el piano de abajo usando las teclas que se muestran encima de estas", 0.375*width, 0.3*height); 
    text("en azul. ¡Prueba a tocarlo antes de empezar! (fila de números de cualquier teclado).", 0.375*width, 0.35*height);
    text("Cuando comiences, las teclas de la partitura se marcarán en amarillo.", 0.375*width, 0.425*height);
    text("¡Síguela con buen ritmo para sacar buena puntuación!", 0.375*width, 0.475*height);
    text("Además, ¡deberás soplar suavemente el micrófono para darle una brisa agradable a la persona!", 0.375*width, 0.55*height);
    text("El estado de ánimo de la persona se irá actualizando en la barra de la derecha ->", 0.375*width, 0.6*height);
    textFont(menuFont, 17.5);
    text("¡Suerte!", 0.375*width, 0.7*height);
    textFont(menuFont, 13.5);
    fill(156, 159, 255);
    text("ENTER.", 0.685*width, 0.175*height);
}
