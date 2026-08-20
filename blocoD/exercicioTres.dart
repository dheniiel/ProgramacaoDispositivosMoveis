void conversorHectaresParaAlqueirosGoianos(){
  for (int i = 10; i <= 100; i+= 10){
    double hectares = i / 4.84;
    print("${i} hectares equivalem a ${hectares.toStringAsFixed(2)} alqueires goianos");
  }
}
void main(){
  conversorHectaresParaAlqueirosGoianos();
}