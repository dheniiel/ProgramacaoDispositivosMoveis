// CICLO 2 — RESTRIÇÕES E O OVERFLOW AMARELO
// Expanded, Flexible e a regra de ouro do layout — caça ao bug
// Programação para Dispositivos Móveis · IF Goiano — Campus Ceres
//
// A REGRA DE OURO
// "As restrições descem, os tamanhos sobem, o pai decide a posição."
// O pai diz ao filho o espaço MÁXIMO que ele pode ocupar (a restrição).
// O filho escolhe seu tamanho dentro disso e devolve para o pai. O pai,
// então, posiciona o filho.
//
// Quando um filho tenta ser MAIOR que o espaço disponível, o Flutter
// mostra a faixa amarela e preta listrada — o famoso "overflow".
//
// COMO FAZER
// Cole no dartpad.dev (modo Flutter) e rode. Você VAI ver o overflow.
// Sua missão é consertar cada bug marcado. Trabalhem em dupla.

import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===================================================== BUG 1
            // Esta Row tenta colocar dois cards largos lado a lado, mas
            // eles somados passam da largura da tela -> overflow amarelo.
            // CONSERTE: envolva CADA card em um Expanded, para que dividam
            // o espaço disponível em vez de exigir a largura cheia.
            Row(
              children: [
                _CardNumero(titulo: 'Talhões cadastrados no total', valor: '6'),
                SizedBox(width: 12),
                _CardNumero(titulo: 'Atividades registradas no mês', valor: '14'),
              ],
            ),

            const SizedBox(height: 16),

            // ===================================================== BUG 2
            // Este texto é muito longo e, dentro de uma Row, tenta ocupar
            // uma largura infinita -> overflow.
            // CONSERTE: envolva o Text em um Expanded para que ele quebre
            // a linha dentro do espaço que sobra.
            Row(
              children: const [
                Icon(Icons.info_outline, color: Color(0xFF1E5631)),
                SizedBox(width: 8),
                Text(
                  'Última sincronização feita há três dias — verifique o sinal '
                  'antes de sair para a lavoura para não perder registros.',
                ),
              ],
            ),
          ],
        ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD5F5E3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(valor,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(titulo, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ============================ TAREFAS ============================
//
// TAREFA 1 (BUG 1) — Faça os dois cards caberem lado a lado usando Expanded.
//
// TAREFA 2 (BUG 2) — Faça o texto longo quebrar linha, sem overflow.
//
// TAREFA 3 — Depois de consertar, troque um dos Expanded do BUG 1 por
//            Flexible(flex: 2) e o outro por Flexible(flex: 1). O que muda
//            na proporção entre os dois cards? Anote em comentário.
//
// PERGUNTA PARA DISCUSSÃO: por que o overflow acontece na horizontal (Row)
// com muito mais frequência do que na vertical (Column) neste tipo de tela?
