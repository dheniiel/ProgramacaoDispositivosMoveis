import 'package:flutter/material.dart';

void main() => runApp(const ComparadorApp());

class ComparadorApp extends StatelessWidget{
  const ComparadorApp({super.key});

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Comparador de propostas de venda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5631)),
        useMaterial3: true,
      ),
      home: const TelaComparador(),
    );
  } 
}

class Proposta {
  final String comprador;
  final double precoSaca;
  final int prazoPagamento;

  Proposta({
    required this.comprador,
    required this.precoSaca,
    required this.prazoPagamento,
  });
}

class TelaComparador extends StatefulWidget{
  const TelaComparador({super.key});

  @override
  State<TelaComparador> createState() => _TelaComparadorState();
}

class _TelaComparadorState extends State<TelaComparador>{
  final _compradorController = TextEditingController();
  final _precoSacaController = TextEditingController();
  final _prazoPagamentoController = TextEditingController();

  final List<Proposta> _propostas = [];
  String? _erro;

  void _adicionarProposta(){
    final comprador = _compradorController.text.trim();
    final precoSaca = double.tryParse(_precoSacaController.text.replaceAll(',','.'));
    final prazoPagamento = int.tryParse(_prazoPagamentoController.text.replaceAll(",","."));

    setState((){
      if (comprador.isEmpty || precoSaca == null || prazoPagamento == null){
        _erro = "Preencha os três campos!";
      }
      else if (precoSaca <= 0 || prazoPagamento <= 0){
        _erro = "Os valores precisam ser maiores que zero.";
      } else{
        _erro = null;
        _propostas.add(Proposta(
          comprador: comprador,
          precoSaca: precoSaca,
          prazoPagamento: prazoPagamento,
        ));
        _propostas.sort((a, b) => b.precoSaca.compareTo(a.precoSaca));
        _compradorController.clear();
        _precoSacaController.clear();
        _prazoPagamentoController.clear();
      }
    });
  }

  void _limpar(){
    _compradorController.clear();
    _precoSacaController.clear();
    _prazoPagamentoController.clear();

    setState((){
      _erro = null;
    });
  }
  
  @override
  void dispose (){
    _compradorController.dispose();
    _precoSacaController.dispose();
    _prazoPagamentoController.dispose();
    
    super.dispose();
  }

  String _reais(double valor) {
    final fixo = valor.toStringAsFixed(2);
    final partes = fixo.split('.');
    final inteira = partes[0];
    final decimal = partes[1];
    final buffer = StringBuffer();
    for (int k = 0; k < inteira.length; k++) {
      if (k > 0 && (inteira.length - k) % 3 == 0) buffer.write('.');
      buffer.write(inteira[k]);
    }
    return 'R\$ ${buffer.toString()},$decimal';
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparação de Propostas'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text (
              'Faça a comparação entre as propostas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            
            const Text (
              'Informe os dados da proposta e toque em Inserir.',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 24),

            _CampoTexto(
              controlador: _compradorController,
              rotulo: 'Nome completo do comprador',
              icone: Icons.person,
            ),

            const SizedBox(height: 24),

            _CampoNumero(
              controlador: _precoSacaController,
              rotulo: 'Preço da saca (em R\$)',
              icone: Icons.attach_money_outlined,
            ),

            const SizedBox(height: 24),

            _CampoNumero(
              controlador: _prazoPagamentoController,
              rotulo: 'Prazo de pagamento (em dias)',
              icone: Icons.hourglass_bottom_rounded,
            ),

            const SizedBox(height: 24),

            Row (
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _adicionarProposta,
                    icon: const Icon(Icons.add),
                    label: const Text('Inserir'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5631),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    )
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _limpar,
                  child: const Text("Limpar"),
                )
              ],
            ),

            const SizedBox(height: 24),

            _Resultado(
                propostas: _propostas,
                erro: _erro,
                formatar: _reais
            ),
          ],
        )
      )
    );
  }
}
class _CampoNumero extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final IconData icone;

  const _CampoNumero({
    required this.controlador,
    required this.rotulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: rotulo,
        prefixIcon: Icon(icone, color: const Color(0xFF1E5631)),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final IconData icone;

  const _CampoTexto({
    required this.controlador,
    required this.rotulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        prefixIcon: Icon(icone, color: const Color(0xFF1E5631)),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
class _Resultado extends StatelessWidget {
  final List<Proposta> propostas;
  final String? erro;
  final String Function(double) formatar;

  const _Resultado({
    required this.propostas,
    required this.erro,
    required this.formatar,
  });

  @override
  Widget build(BuildContext context) {
    if (erro != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDECEA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFB3261E)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(erro!,
                  style: const TextStyle(color: Color(0xFFB3261E))),
            ),
          ],
        ),
      );
    }

    if (propostas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFD5F5E3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text( 'Propostas (ordernada por preço)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, color: Colors.black54), 
          ),
          const SizedBox(height: 8),
          for (final proposta in propostas)
            ListTile(
              title: Text(proposta.comprador,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(formatar(proposta.precoSaca),
                style: const TextStyle(fontSize: 18),
              ),
              trailing: Text('${proposta.prazoPagamento} dias',
                style: const TextStyle(fontSize: 18),
                ),
            ),
        ],
      ),
    );
  }
}