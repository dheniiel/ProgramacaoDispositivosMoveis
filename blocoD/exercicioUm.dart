String classificarProdutividade(double valorSacaPorHectare){
  var classificacao;

  if(valorSacaPorHectare < 50){
    classificacao = "Baixa";
  }
  else if(valorSacaPorHectare >= 50 && valorSacaPorHectare <= 70){
    classificacao = "Média";
  }
  else{
    classificacao = "Alta";
  }
  return classificacao;
}

void main(){
  double valorSacaPorHectare = 65;
  print(classificarProdutividade(valorSacaPorHectare));
}