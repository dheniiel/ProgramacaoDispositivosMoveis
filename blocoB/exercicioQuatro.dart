double? sacasporHectare(double sacas, double hectares){
  var resultado;
  
  if(hectares <= 0){
    resultado = null;
  }

  else{
    resultado = sacas / hectares;
  }
  
  return resultado;
}
void main(){
  print(sacasporHectare(100, 0));
}