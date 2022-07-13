public class rocket {
  PVector pos, vel, acc;
  DNA dna;
  int countm;
  float fitness;
  boolean compleate, crashed;
  rocket() {
    pos = new PVector(start.x, start.y);
    vel = new PVector();
    acc = new PVector();
    countm = lifeSpan;
    compleate = false;
    crashed = false;
    fitness = 0;
    dna = new DNA();
  }
  rocket(DNA _dna) {
    pos = new PVector(start.x, start.y);
    vel = new PVector();
    acc = new PVector();
    countm = lifeSpan;
    compleate = false;
    crashed = false;
    fitness = 0;
    dna = _dna;
  }
  public void applyForce(PVector force) {
    acc.add(force);
  }
  public void calFitness() {
    float d = dist(pos.x, pos.y, target.x, target.y);
    fitness = map(d, 0, width, 4, -1);
    fitness *= ((map(countm, 0, lifeSpan, 2, 0))+1);
    if(compleate){
      fitness*=2;
    } else if(crashed){
      if(fitness < 0){
        fitness*=10;
      }
      else{
        fitness*=0.01;
      }
    }
    fitness = pow(fitness, fitness);
  }
  public void update() {
    float d = dist(pos.x, pos.y, target.x, target.y);
    if (d < 20 && !compleate) {
      compleate = true;
      countm = count;
      pos = target.copy();
    }
    if((pos.x < 0 || pos.y < 0|| pos.x > width || pos.y > height) && !crashed){
      crashed = true;
    }
    for(obstacle ob: obs){
      if((pos.x > ob.pos.x-ob.l/2 && pos.x < ob.pos.x+ob.l/2) && (pos.y > ob.pos.y - ob.b/2 && pos.y < ob.pos.y + ob.b/2)){
        crashed = true;
      }
      if(crashed){
        break;
      }
    }
    if (!compleate && !crashed) {
      applyForce(dna.genes[count]);
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
    }
  }
  public void show() {
    push();
    noStroke();
    if(!bestmode){
      fill(255, 150);
    } else {
      fill(255);
    }
    translate(pos.x, pos.y);
    rotate(vel.heading());
    rect(0, 0, 50, 10);
    pop();
  }
}
