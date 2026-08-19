double valorMonetario = 5000.0;

void main(){
  print(valorMonetario.toStringAsFixed(2).replaceAll('$valorMonetario', 'R\$ $valorMonetario'));
}