class Graph {
  ArrayList<PVector> points;
  int w;
  int h;
  float maxX = 0;
  float maxY = 0;
  Graph(int wid, int hei){
    //Initialises with a width and height
    w = wid;
    h = hei;
    points = new ArrayList<PVector>();
  }
  
  void addPoint(float x, float y){
    //Adds a point to the points list
    PVector p = new PVector(x,y);
    points.add(p);
    if(x > maxX){maxX = x;}
    if(y > maxY){maxY = y;}
  }
  
  void show(){
    //Draw Data
    strokeWeight(1);
    float Xscale = w/maxX;
    float Yscale = h/maxY;
    if(points.size() > 2){
      for(int i = 0; i < points.size()-1; i++){
        float x1 = points.get(i).x * Xscale;
        float y1 = h - (points.get(i).y * Yscale);
        float x2 = points.get(i+1).x * Xscale;
        float y2 = h - (points.get(i+1).y * Yscale);
        line(x1,y1,x2,y2);
      }
    }
    
    //Draw Axes
    strokeWeight(2);
    stroke(255);
    line(0,0,0,h);
    line(0,h,w,h);
  }
}