String culturas = ' soja , milho , sorgo ';

void main(){
  List<String> listaCulturas = culturas.split(',').map((item) => item.trim().toUpperCase()).toList();
  print(listaCulturas);
}