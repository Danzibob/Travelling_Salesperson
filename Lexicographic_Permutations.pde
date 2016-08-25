boolean advComb(int[] vals){
  //STEP 1
  int largestX = -1;
  for(int x = 0; x < vals.length-1; x++){
    if(vals[x] < vals[x+1]){
      largestX = x;
    }
  }
  
  if(largestX == -1){
    return false;
  }
  //STEP 2
  int largestY = -1;
  for(int y = 0; y < vals.length; y++){
    if(vals[largestX] < vals[y]){
      largestY = y;
    }
  }
  //STEP 3
  swapInt(vals,largestX, largestY);
  //STEP 4
  reverseSection(vals,largestX+1, vals.length-1);
  return true;
}
 //<>// //<>// //<>//
void swapInt(int[] l, int a, int b){
  int temp = l[b];
  l[b] = l[a];
  l[a] = temp;
}

void reverseSection(int[] l, int a, int b){
  int sectLen = abs(b-a);
  for(int i=0; i<floor(sectLen/2); i++){
    swapInt(l, a+i, b-i);
  }
}