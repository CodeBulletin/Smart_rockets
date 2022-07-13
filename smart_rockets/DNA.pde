public class DNA {
  PVector genes[];
  DNA() {
    genes = new PVector[lifeSpan];
    for (int i = 0; i< lifeSpan; i++) {
      genes[i] = PVector.random2D();
      genes[i].setMag(maxvel);
    }
  }
  DNA(PVector dna[]) {
    genes = dna;
  }
  public DNA crossover(DNA partner) {
    PVector newdna[] = new PVector[lifeSpan];
    int mid = (int)random(genes.length);
    for (int i = 0; i < genes.length; i++) {
      if (i > mid) {
        newdna[i] = genes[i];
      } else {
        newdna[i] = partner.genes[i];
      }
    }
    return new DNA(newdna);
  }
  public void mutation(){
    for(int i = 0; i<lifeSpan; i++){
      if(random(1) < mutationval){
        genes[i] = PVector.random2D();
        genes[i].setMag(maxvel);
      }
    }
  }
}
