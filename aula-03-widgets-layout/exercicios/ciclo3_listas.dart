// CICLO 3 — LISTAS
// ListView e ListView.builder — a lista de talhões do Caderno de Campo
// Programação para Dispositivos Móveis · IF Goiano — Campus Ceres
//
// A IDEIA
// Você já tem a classe Talhao dos exercícios de Dart. Agora vamos
// transformar uma LISTA de talhões em uma LISTA NA TELA, rolável.
//
// ListView          -> quando há poucos itens fixos, escritos à mão.
// ListView.builder  -> quando os itens vêm de uma coleção. Constrói cada
//                      item sob demanda (só o que está visível). É o que
//                      se usa de verdade.
//
// COMO FAZER
// Cole no dartpad.dev (modo Flutter), rode e siga as tarefas.

import 'package:flutter/material.dart';

// A mesma classe Talhao que você já conhece dos exercícios de Dart.
class Talhao {
  final String nome;
  final double areaHa;
  final String cultura;
  const Talhao({required this.nome, required this.areaHa, required this.cultura});
}

// Os dados da propriedade — a mesma lista dos exercícios.
const List<Talhao> talhoes = [
  Talhao(nome: 'Talhão 1', areaHa: 38.0, cultura: 'soja'),
  Talhao(nome: 'Talhão 2', areaHa: 24.5, cultura: 'milho'),
  Talhao(nome: 'Talhão 3', areaHa: 42.0, cultura: 'milho'),
  Talhao(nome: 'Talhão 4', areaHa: 31.2, cultura: 'soja'),
  Talhao(nome: 'Talhão 5', areaHa: 12.8, cultura: 'sorgo'),
  Talhao(nome: 'Talhão 6', areaHa: 19.4, cultura: 'milho'),
];

void main() => runApp(const CadernoApp());

class CadernoApp extends StatelessWidget {
  const CadernoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5631)),
        useMaterial3: true,
      ),
      home: const TelaTalhoes(),
    );
  }
}

class TelaTalhoes extends StatelessWidget {
  const TelaTalhoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talhões'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      // ListView.builder percorre a lista e cria um item para cada talhão.
      // itemCount: quantos itens existem.
      // itemBuilder: uma função que recebe o índice e devolve o widget
      //              daquele item.
      body: ListView.builder(
        itemCount: talhoes.length,
        itemBuilder: (context, indice) {
          final talhao = talhoes[indice];
          // ListTile: um item de lista pronto, com título, subtítulo e ícones.
          return ListTile(
            leading: const Icon(Icons.grass, color: Color(0xFF1E5631)),
            title: Text(talhao.nome),
            subtitle: Text('${talhao.areaHa} ha — ${talhao.cultura}'),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 — Acrescente dois talhões à lista 'talhoes' e confirme que eles
//            aparecem na tela SEM você mexer no ListView. Esse é o ganho do
//            builder: a tela se adapta aos dados.
//
// TAREFA 2 — No subtítulo, formate a área no padrão brasileiro (vírgula no
//            lugar do ponto). Dica: talhao.areaHa.toStringAsFixed(1)
//            .replaceAll('.', ',').
//
// TAREFA 3 — Troque o ícone conforme a cultura: espiga para milho, folha
//            para soja, e um ícone genérico para o resto. Dica: um if ou um
//            switch que devolve o IconData antes de montar o ListTile.
//
// TAREFA 4 — Envolva cada ListTile em um Card para dar destaque visual a
//            cada talhão. O que muda na aparência da lista?
//
// PERGUNTA: por que ListView.builder é melhor que escrever 6 ListTile na
// mão? Pense em uma propriedade com 200 talhões.
