String? telefone;

void main(){
  print(telefone?.length);
  
  //compileNewDDC
  //main.dart:4:18: Error: Property 'length' cannot be accessed on 'String?' because it is potentially null.
  //Try accessing using ?. instead.
  //print(telefone.length);
  //               ^^^^^^
}
