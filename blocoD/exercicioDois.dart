String classificarProdutividade(double valorSacaPorHectare){
  var classificacao;
  
  switch(valorSacaPorHectare){
    case < 50:
      classificacao = "Baixa";
      break;
    case >= 50 && <= 70:
      classificacao = "Média";
      break;
    default:
      classificacao = "Alta";
  }

  return classificacao;
}

void main(){
  double valorSacaPorHectare = 85;
  print(classificarProdutividade(valorSacaPorHectare));
}