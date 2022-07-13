public class rockets {
  rocket Rockets[], bestrocket;
  DNA bestdna;
  ArrayList<rocket> matingpool;
  int popsize;
  rockets() {
    bestdna = null;
    bestrocket = null;
    popsize = worldpopsize;
    Rockets = new rocket[popsize];
    for (int i = 0; i<popsize; i++) {
      Rockets[i] = new rocket();
    }
  }
  public void update() {
    for (int i = 0; i<popsize; i++) {
      Rockets[i].update();
    }
  }
  public void show(){
    for (int i = 0; i<popsize; i++) {
      Rockets[i].show();
    }
  }
  public boolean done(){
    boolean mx = true;
    for(int i = 0; i<popsize; i++){
      if(!(Rockets[i].crashed || Rockets[i].compleate)){
        mx = false;
      }
    }
    return mx;
  }
  public void evaluate() {
    float maxfit = 0;
    for (int i = 0; i<popsize; i++) {
      Rockets[i].calFitness();
      if (Rockets[i].fitness > maxfit) {
        bestdna = Rockets[i].dna;
        maxfit = Rockets[i].fitness;
      }
    }
    for (int i = 0; i < popsize; i++) {
      Rockets[i].fitness /= maxfit;
    }
    _maxfit = maxfit;
    matingpool = new ArrayList();
    for (int i = 0; i < popsize; i++) {
      float n = Rockets[i].fitness*10;
      for (int j = 0; j<n; j++) {
        matingpool.add(Rockets[i]);
      }
    }
    if(bestmode){
      bestrocket = new rocket(bestdna);
    }
  }
  public void selection() {
    rocket newRockets[] = new rocket[popsize];
    for (int i = 0; i<popsize; i++) {
      DNA ParrentA = matingpool.get((int)random(matingpool.size())).dna;
      DNA ParrentB = matingpool.get((int)random(matingpool.size())).dna;
      DNA child = ParrentA.crossover(ParrentB);
      child.mutation();
      newRockets[i] = new rocket(child);
    }
    Rockets = newRockets;
  }
}
