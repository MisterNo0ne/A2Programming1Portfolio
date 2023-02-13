class WaveData {
  int rocks;
  int momentum;
  float sizeLowerBound;
  float sizeHigherBound;
  float sendSpeed;
  WaveData(int trocks, float tss, int tmomentum, float tslb, float tshb) {
    rocks = trocks;
    sendSpeed = tss; //in seconds
    momentum = tmomentum;
    sizeLowerBound = tslb;
    sizeHigherBound = tshb;
  }
}
