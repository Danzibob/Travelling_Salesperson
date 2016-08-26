class DNA implements Comparable<DNA> {
  int[] order = new int[N];
  float score;
  DNA(){
    //Creates a random order
    for(int i=0; i<N; i++){
      order[i] = i;
    }
    ShuffleArray(order);
  }
  DNA(int [] data){
    //Creates a genome with the oredr given
    order = data;
  }
  @Override
  public int compareTo(DNA other) {
    //Allows DNA[] to be sorted by score
    if(score < other.score){
      return -1;
    } else if(score > other.score){
      return 1;
    } else {
      return 0;
    }
  }
  DNA crossover(DNA other){
    //Generate 2 random non-equal pointers
    int a = floor(random(other.order.length));
    int b = a;
    while(b == a){
      b = floor(random(other.order.length));
    }
    if(a>b){
      int tmp = a;
      a = b;
      b = tmp;
    }
    
    //create a new empty array and fill it with -1
    int[] l = new int[N];
    Arrays.fill(l, -1);
    
    //take the section between the pointers from original array
    for(int i = a; i <= b; i++){
      l[i] = order[i];
    }
    
    //repurpose pointers
    a = 0;
    b = 0;
    
    //ugly bit
    while(b < N){
      if(l[b] == -1){
        if(!contains(l,other.order[a])){
          l[b] = other.order[a];
          b += 1;
        }
        a += 1;
      } else {
        b += 1;
      }
    }
    
    //Random mutation
    if(random(1) < 0.1){
      swapInt(l,floor(random(N)),floor(random(N)));
    }
    return new DNA(l);
  }
}



void ShuffleArray(int[] array)
{
    int index;
    for (int i = array.length - 1; i > 0; i--)
    {
        index = floor(random(i));
        if (index != i)
        {
            array[index] ^= array[i];
            array[i] ^= array[index];
            array[index] ^= array[i];
        }
    }
}

//Function I found didn't work so I wrote my own
boolean contains(int[] arr, int x){
  for(int i = 0; i < arr.length; i++){
    if(arr[i] == x){
      return true;
    }
  }
  return false;
}
