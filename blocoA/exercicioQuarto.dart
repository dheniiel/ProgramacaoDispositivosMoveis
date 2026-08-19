double areaTotal = 15;
double alqueiroGoiano = 4.84;

double conversorHectareAlqueiro(){
  return areaTotal * alqueiroGoiano;
}

void main(){
  print(conversorHectareAlqueiro().toStringAsFixed(2));
}
