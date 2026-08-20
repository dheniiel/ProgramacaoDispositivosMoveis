int retirarEstoque(){
  var contadorDeDias = 0;

  for(int i = 5000; i >= 0; i -= 350){
    contadorDeDias++;
  }
  return contadorDeDias;
}
void main(){
  print("O estoque de 5000 unidades será retirado em ${retirarEstoque()} dias");
}