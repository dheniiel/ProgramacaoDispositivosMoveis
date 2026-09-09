// CICLO 4 — JUNTANDO TUDO
// A tela de resumo da propriedade — a primeira tela "de verdade" do app
// Programação para Dispositivos Móveis · IF Goiano — Campus Ceres
//
// A META
// Compor, em uma tela só, tudo dos ciclos anteriores:
//   - um cabeçalho com nome da propriedade e área (Ciclo 1);
//   - uma faixa com três números lado a lado, sem overflow (Ciclo 2);
//   - a lista de talhões, rolável (Ciclo 3).
//
// Este arquivo já vem com a ESTRUTURA montada e alguns trechos faltando,
// marcados com // COMPLETE. Preencha-os usando o que praticou nos ciclos.

import 'package:flutter/material.dart';

class Talhao {
  final String nome;
  final double areaHa;
  final String cultura;
  const Talhao({required this.nome, required this.areaHa, required this.cultura});
}

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
      home: const TelaResumo(),
    );
  }
}

class TelaResumo extends StatelessWidget {
  const TelaResumo({super.key});

  @override
  Widget build(BuildContext context) {
    // Área total calculada a partir da lista (revisão dos exercícios de Dart).
    final areaTotal =
        talhoes.fold<double>(0, (soma, t) => soma + t.areaHa);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caderno de Campo do Vale'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- CABEÇALHO (Ciclo 1) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFD5F5E3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fazenda Santa Rita do Vale',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Ceres — GO · ${areaTotal.toStringAsFixed(1)} ha no total'),
              ],
            ),
          ),

          // ---- TRÊS NÚMEROS (Ciclo 2) ----
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // COMPLETE: envolva cada _CardNumero em um Expanded para que
                // os três dividam a largura sem overflow. Há um SizedBox de
                // 8 de largura entre eles.
                _CardNumero(titulo: 'Talhões', valor: '${talhoes.length}'),
                const SizedBox(width: 8),
                _CardNumero(titulo: 'Atividades', valor: '14'),
                const SizedBox(width: 8),
                _CardNumero(titulo: 'Último', valor: 'há 3d'),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Talhões da propriedade',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),

          // ---- LISTA (Ciclo 3) ----
          // COMPLETE: a lista precisa ocupar todo o espaço que sobra na tela.
          // Dentro de uma Column, um ListView precisa ser envolvido em
          // Expanded, senão dá erro de altura infinita. Envolva o
          // ListView.builder abaixo em um Expanded.
          ListView.builder(
            itemCount: talhoes.length,
            itemBuilder: (context, indice) {
              final talhao = talhoes[indice];
              return ListTile(
                leading: const Icon(Icons.grass, color: Color(0xFF1E5631)),
                title: Text(talhao.nome),
                subtitle: Text(
                    '${talhao.areaHa.toStringAsFixed(1).replaceAll('.', ',')} ha — ${talhao.cultura}'),
              );
            },
          ),
        ],
      ),
      // Botão flutuante de nova atividade — sem função ainda.
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E5631),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Novo registro (em breve)')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _CardNumero extends StatelessWidget {
  final String titulo;
  final String valor;
  const _CardNumero({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF7F1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1E8449)),
      ),
      child: Column(
        children: [
          Text(valor,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(titulo, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 (COMPLETE) — Faça os três cards de número dividirem a largura
//            sem overflow (Expanded em cada um).
//
// TAREFA 2 (COMPLETE) — Faça a lista ocupar o espaço restante da tela
//            (Expanded no ListView.builder). Sem isso, o app nem roda.
//
// TAREFA 3 — Faça a tela sua: aplique aqui as duas decisões de interface
//            que você justificou lá na primeira tela do Caderno de Campo
//            (contraste alto, alvo de toque generoso, número em destaque),
//            pensando em quem usa o app de luvas, sob sol, no talhão.
//
// DESAFIO — Torne o botão flutuante útil: ao tocar, mostre um AlertDialog
//            listando as culturas distintas da propriedade.
