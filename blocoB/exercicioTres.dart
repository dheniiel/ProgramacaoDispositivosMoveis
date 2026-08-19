double? chuvaMn = 15;

String quantidadeChuva(double? chuvaMn){
  
  var situacao;
  
  if(chuvaMn == null){
    situacao = "Sem registro";
  }
  else if(chuvaMn < 20){
    situacao = "Seca";
  }
  else{
    situacao = "Normal";
  }
  return situacao;
}

void main(){
  print(quantidadeChuva(chuvaMn));
}