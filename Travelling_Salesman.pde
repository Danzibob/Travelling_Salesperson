import java.util.Arrays;
import java.util.Comparator;

int N = 8;
int popSize = 100;
int[] vals = new int[N];
int[] order = new int[N];
int generation = 0;
PVector[] cities;
float DNARecord;
float BruteRecord;
float d;
int[] bestDNA;
int[] bestBrute;
DNA[] population = new DNA[popSize];

Graph genetic = new Graph(300,340);
Graph brute = new Graph(300,340);

void setup() {
  size(720,360);
  for(int i = 0; i < N; i++){
  order[i] = i;
  }
  cities = new PVector[N];
  for (int i = 0; i < N; i++){
    cities[i] = new PVector(random(width/2), random((height-10)/2));
    vals[i] = i;
  }
  for (int i = 0; i < popSize; i++){
    population[i] = new DNA();
  }
  d = calcDist(vals);
  DNARecord = d;
  BruteRecord = d;
  genetic.addPoint(generation, DNARecord);
  brute.addPoint(generation, BruteRecord);
  bestDNA = vals.clone();
  bestBrute = vals.clone();
}


void draw() {
  generation ++;
  frameRate(100);
  background(51);
  noFill();
  
  //Genetic Algorithm
  for(int i = 0; i < N; i++){
    for(int p = 0; p < popSize; p++){
      d = calcDist(population[p].order);
      population[p].score = d;
    }
  }
  Arrays.sort(population);
  if(population[0].score < DNARecord){
    bestDNA = population[0].order.clone();
    DNARecord = population[0].score;
  }
  int half = floor(popSize*0.4);
  for(int i = 0; i < half; i++){
    DNA x = population[floor(pow(random(half),2)/half)];
    DNA y = population[floor(pow(random(half),2)/half)];
    //DNA x = population[floor(random(half))];
    //DNA y = population[floor(random(half))];
    population[half+i] = x.crossover(y);
  }
  for(int i = 2*half; i < popSize; i++){
    population[i] = new DNA();
  }
  genetic.addPoint(generation, DNARecord);
  
  //Brute Force Algorithm
  for(int p = 0; p < popSize; p++){
    if(!advComb(vals)){
      noLoop();
      break;
    }
    d = calcDist(vals);
    if(d < BruteRecord){
      bestBrute = vals.clone();
      BruteRecord = d;
    }
  }
  brute.addPoint(generation, BruteRecord);
  
  //Draw Brute
  pushMatrix();
  translate(0,0);
  //textSize(16);
  //text(Arrays.toString(bestBrute),10,312);
  //text(Arrays.toString(vals),10,332);
  strokeWeight(2);
  stroke(255,128,128);
  beginShape();
  for (int i = 0; i < N; i++){
    vertex(cities[bestBrute[i]].x, cities[bestBrute[i]].y);
  }
  endShape();
  fill(255);
  noStroke();
  for (int i = 0; i < N; i++){
    ellipse(cities[i].x, cities[i].y,8,8);
  }
  popMatrix();
  
  //Draw Genetic
  pushMatrix();
  translate(0,(height-10)/2);
  //textSize(16);
  //text(Arrays.toString(bestDNA),210,332);
  strokeWeight(2);
  stroke(128,255,128);
  noFill();
  beginShape();
  for (int i = 0; i < N; i++){
    vertex(cities[bestDNA[i]].x, cities[bestDNA[i]].y);
  }
  endShape();
  fill(255);
  noStroke();
  for (int i = 0; i < N; i++){
    ellipse(cities[i].x, cities[i].y,8,8);
  }
  popMatrix();
  
  //Draw graphs
  pushMatrix();
  translate(width/2 + 10,10);
  stroke(255, 128, 128);
  brute.show();  
  stroke(128, 255, 128);
  genetic.show();
  popMatrix();
}


void swapVect(PVector[] a, int i, int j){
  PVector temp = a[i];
  a[i] = a[j];
  a[j] = temp;
}

float calcDist(int[] a){
  float total = 0;
  for (int i = 1; i < a.length; i++){
    total += dist(cities[a[i-1]].x, cities[a[i-1]].y, cities[a[i]].x, cities[a[i]].y);
  }
  return total;
}