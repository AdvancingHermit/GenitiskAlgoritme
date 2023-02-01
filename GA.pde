import java.util.ArrayList;
import java.lang.Math;

ArrayList<Item> itemList = new ArrayList<>();
ArrayList<Integer> genFit = new ArrayList<>();
ArrayList<Bar> barList = new ArrayList<>();
DNA[] population = new DNA[100];
int totalPrice = 0;
float infCreation = 0.01;
int genFitCount = 0;
int gens = 1;
int count = 0;
int activeBar = -1;
boolean msg = false;
int rectX;
int rectY = 120;
int sizeX = 200;
int sizeY = 50;


void setup()
{
  size(1400, 800);
  String[] lines = loadStrings("items.txt");
  for (int i = 0; i < lines.length; i++) {
    String[] itemAtt = lines[i].split(",");
    itemList.add(new Item(itemAtt[0], Integer.parseInt(itemAtt[1]), Integer.parseInt(itemAtt[2])));
  }
  for (int i = 0; i < itemList.size(); i++) {
    totalPrice += itemList.get(i).price;
  }
  train();
  rectX = width - 1350;
}

void train() {
  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA();
  }
  genFit = new ArrayList<>();
  barList = new ArrayList<>();

  for (int run = 0; run < 100; run++) {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness();
    }
    ArrayList<DNA> infoPool = new ArrayList<DNA>();

    for (int i = 0; i < population.length; i++) {
      int n = int(float(population[i].fitness) / float(totalPrice) * 100);
      for (int j = 0; j < n; j++) {
        infoPool.add(population[i]);
      }
    }

    int bestFit = 0;

    for (int i = 0; i < population.length; i++) {
      if (population[i].fitness > population[bestFit].fitness) {
        bestFit = i;
      }
    }

    count++;
    if (count == gens) {
      count = 0;
      genFitCount += population[bestFit].fitness;
      println("Best last "+ gens + " avg: " + genFitCount / gens);
      genFit.add(genFitCount / gens);
      genFitCount = 0;
    } else {
      genFitCount += population[bestFit].fitness;
    }

    for (int i = 0; i < population.length; i++) {

      int a = int(random(infoPool.size()));
      ArrayList<DNA> poolB = new ArrayList<DNA>();
      for (int j = 0; j < infoPool.size(); j++) {
        if (infoPool.get(i) != infoPool.get(a)) {
          poolB.add(infoPool.get(i));
        }
      }
      int b = int(random(infoPool.size()));
      DNA parentA = infoPool.get(a);
      DNA parentB = infoPool.get(b);
      DNA child = parentA.createChild(parentB);
      child.getInfo(infCreation);
      population[i] = child;
    }
  }
  for (int i = 0; i < genFit.size(); i++) {
    barList.add(new Bar(13*i + 50, genFit.get(i)*-0.45, genFit.get(i)));
  }
}

void draw() {
  background(18, 30, 42);
  for (int i = 0; i < genFit.size(); i++) {
    barList.get(i).display();
  }
  fill(255);
  textSize(24);
  fill(51, 169, 254);
  rect(rectX, rectY, sizeX, sizeY, 15);
  fill(0);
  text("Kør Igen", rectX + 68, rectY + 33);

  //Axis Titles
  textSize(20);
  fill(88, 106, 127);
  text("Generation", width/2 - 10, height - 8);
  pushMatrix();
  translate( 40, height/2 + 30);
  rotate(-HALF_PI);
  text("Fitness / Value", 0, 0);
  popMatrix();
}

public boolean over(float posX, float posY, float sizeX, float sizeY) {
  if (mouseX >= posX && mouseX <= posX+sizeX &&
    mouseY >= posY && mouseY <= posY+sizeY) {
    return true;
  } else {
    return false;
  }
}

void mouseClicked() {
  if (over(rectX, rectY, sizeX, sizeY)) {
    train();
  }
}
