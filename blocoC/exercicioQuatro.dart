String culturas = ' soja , milho , sorgo ';

void main(){
  List<String> listaCulturas = culturas.trim().toUpperCase().split(',');
  print(listaCulturas);
}