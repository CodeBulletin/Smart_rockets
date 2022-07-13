static final int worldpopsize = 1000;
static final float mutationval = 0.001;
static final int lifeSpan = 500;
static final float maxvel = 0.2;
static final ArrayList<obstacle> obs = new ArrayList();
static rockets population;
static boolean bestmode = false;
private static boolean showstatus = false;
private static boolean fastmode = true;
private static int u_fast;
private static int a_fast;

int count = 0;
private int zen = 0;
PVector target, start;
private boolean s0 = true, s1 = true, s2 = true;
float _maxfit;


public void setup() {
  fullScreen(P2D);
  setFrameRate();
  setStep();
  obs.add(new obstacle(new PVector(width/2, height/2+75), 350, 20));
  obs.add(new obstacle(new PVector(width/2-165, height/2+150), 20, 150));
  obs.add(new obstacle(new PVector(width/2+165, height/2+150), 20, 150));
  obs.add(new obstacle(new PVector(width/2-225, height/2+150), 20, 150));
  obs.add(new obstacle(new PVector(width/2+225, height/2+150), 20, 150));
  obs.add(new obstacle(new PVector(width/4, height/2), 20, height));
  obs.add(new obstacle(new PVector(3*width/4, height/2), 20, height));
  rectMode(CENTER);
}

public void draw() {
  background(0);
  textSize(24);
  if (s0) {
    push();
    textAlign(CENTER);
    text("Press S to start", width/2, height/2);
    pop();
    for (obstacle ob : obs) {
      ob.show();
    }
  } else if (s1) {
    for (obstacle ob : obs) {
      ob.show();
    }
    push();
    textAlign(CENTER);
    text("Click on screen to place Target or press x for default position", width/2, height/2);
    pop();
  } else if (s2) {
    for (obstacle ob : obs) {
      ob.show();
    }
    fill(255, 0, 0);
    ellipse(target.x, target.y, 40, 40);
    fill(255);
    push();
    textAlign(CENTER);
    text("Click on screen to place spawning point or press x to put it on default position", width/2, height/2);
    pop();
  } else {
    for (obstacle ob : obs) {
      ob.show();
    }
    if (showstatus) {
      fill(255);
      text("  FasteMode   : " + isthisactive(fastmode), 0, 105);
      text("  Mutation    : " + str(mutationval), 0, 80);
      text("  Batch size  : " + str(worldpopsize), 0, 55);
      text("World setings : ", 0, 30);
      text("  best mode : " + isthisactive(bestmode), 0, 130);
      text("  steps per frame : " + str(u_fast), 0, 155);
      text("Current Analytics : ", 0, 205); 
      if (bestmode) {
        if (population.bestrocket != null) {
          text("  best of genration " + str(zen), 0, 230);
          text("  Fitness(best) : " + str(_maxfit), 0, 255);
        } else {
          text("  calculating best", 0, 205);
        }
      } else {
        text("  current genration " + str(zen+1), 0, 230);
        text("  Max Fit(last gen) : " + str(_maxfit), 0, 255);
      }
    }
    fill(255, 0, 0);
    ellipse(target.x, target.y, 40, 40);
    fill(255, 50);
    ellipse(start.x, start.y, 40, 40);
    for (int i=0; i < u_fast; i++) {
      if (bestmode) {
        if (population.bestrocket != null) {
          population.bestrocket.update();
        }
      }
      population.update();
      count++;
      if (count == lifeSpan || population.done()) {
        population.evaluate();
        population.selection();
        zen++;
        count = 0;
      }
    }
    if (bestmode) {
      if (population.bestrocket != null) {
        population.bestrocket.show();
      }
    }
    if (!bestmode) {
      population.show();
    }
  }
}
public void mousePressed() {
  if (s0) {
  } else if (s1) {
    target=new PVector(mouseX, mouseY);
    s1 = false;
  } else if (s2) {
    start = new PVector(mouseX, mouseY);
    population = new rockets();
    s2 = false;
  }
}

public void keyPressed() {
  if (s0) {
    if (key == 's') {
      s0 = false;
    }
  }
  if (s1) {
    if (key == 'x') {
      target=new PVector(width/2, height/6);
      s1 = false;
    }
  } else if (s2) {
    if (key == 'x') {
      start = new PVector(width/2, height-10);
      population = new rockets();
      s2 = false;
    }
  }
  if (key == 'f') {
    fastmode =! fastmode;
    setFrameRate();
  }
  if (key == ' ') {
    bestmode =! bestmode;
    population.bestrocket = null;
  }
  if (key == 's' && !s0) {
    showstatus =! showstatus;
  }
  if(keyCode == UP){
    a_fast = (a_fast+1)%6;
    setStep();
  }
  if(keyCode == DOWN){
    if(a_fast > 0){
      a_fast--;
    } else {
      a_fast = 5;
    }
    setStep();
  }
}

private static void setStep(){
  if(a_fast == 0){
    u_fast = 1;
  } else if(a_fast>0){
    u_fast = (a_fast)*100;
  }
}

private static String isthisactive(boolean a) {
  if (a) {
    return "on";
  } else {
    return "off";
  }
}

private void setFrameRate() {
  if (fastmode) {
    frameRate(1000);
  } else {
    frameRate(60);
  }
}
