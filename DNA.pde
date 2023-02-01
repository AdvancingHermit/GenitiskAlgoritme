class DNA {
  int[] info = new int[itemList.size() -1];
  int fitness;
  int weight;

  void fitness () {
    fitness = 0;
    weight = 0;
    for (int i = 0; i < info.length; i++) {
      if (info[i] == 1) {
        fitness += itemList.get(i).price;
        weight += itemList.get(i).weight;
      }
    }
    if (weight > 5000) {
      fitness = 0;
    }
  }
  DNA createChild(DNA partner) {
    DNA child = new DNA();
    for (int i = 0; i < info.length; i++) {
      int rand = int(random(0, 2));
      if (rand == 1) {
        child.info[i] = partner.info[i];
      } else {
        child.info[i] = info[i];
      }
    }
    return child;
  }

  void getInfo(float infCreation) {
    for (int i = 0; i < info.length; i++) {
      if (random(1) < infCreation) {
        info[i] = int(random(0, 2));
      }
    }
  }

  DNA() {
    for (int i = 0; i < info.length; i++) {
      info[i] = int(random(0, 2));
    }
  }
}
