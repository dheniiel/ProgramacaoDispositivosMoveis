// Teste de widget básico do Caderno de Campo.
//
// Este arquivo vem junto do projeto porque o "flutter create" sempre gera
// um teste de exemplo. Ele confirma que o app sobe e mostra o título na
// barra superior. À medida que a tela evolui nos ciclos, este teste pode
// ser atualizado — testes de widget são assunto de um encontro mais à
// frente no semestre.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caderno_campo/main.dart';

void main() {
  testWidgets('O app sobe e mostra o título na AppBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CadernoApp());

    // O título deve aparecer na barra superior.
    expect(find.text('Caderno de Campo do Vale'), findsOneWidget);
  });
}
