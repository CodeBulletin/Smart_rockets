public class obstacle{
  float l, b;
  PVector pos;
  obstacle(PVector _pos, float _l, float _b){
      pos = _pos;
      l = _l;
      b = _b;
  }
  public void show(){
    fill(255);
    noStroke();
    rect(pos.x, pos.y, l, b);
  }
};
