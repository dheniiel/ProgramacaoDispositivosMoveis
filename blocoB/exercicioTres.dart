double? chuvaMn;

double quantidadeChuva(double? chuvaMn){
  
  var situacao;
  
  if(chuvaMn == null){
    situacao = "Sem registro";
  }
  else if(chuvaMn < 20){
    situacao = "seca";
  }
  else{
    situacao = "normal";
  }
  return situacao;
}

void main(){
  print(quantidadeChuva(chuvaMn));
}