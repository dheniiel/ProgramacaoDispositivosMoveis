double cotacaoUm = 15.5;
double cotacaoDois = 70;
double cotacaoTres = 20;

double descobrirMaior(){
  return (cotacaoUm > cotacaoDois && cotacaoUm > cotacaoTres) ? cotacaoUm : (cotacaoDois > cotacaoTres ? cotacaoDois : cotacaoTres);
}

double descobrirMenor(){
  return (cotacaoUm < cotacaoDois && cotacaoUm < cotacaoTres) ? cotacaoUm : (cotacaoDois < cotacaoTres ? cotacaoDois : cotacaoTres);
}

double descobrirMedia(){
  return (cotacaoUm + cotacaoDois + cotacaoTres) / 3;  
}

void main (){
  print('Maior cotação: ${descobrirMaior().toStringAsFixed(2)} \nMenor cotação: ${descobrirMenor().toStringAsFixed(2)} \nMédia das cotações: ${descobrirMedia().toStringAsFixed(2)}');
}
