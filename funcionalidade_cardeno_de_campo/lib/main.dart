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
  String? _erroComprador;
  String? _erroPreco;
  String? _erroPrazo;

  String? _validarComprador(String valor){
    if (valor.trim().isEmpty){
      return 'Informe o nome do comprador';
    }
    if (valor.trim().length < 3){
      return 'Nome muito curto';
    }
    return null;
  }

  String? _validarPreco(String valor){
    if (valor.trim().isEmpty){
      return 'Informe o preço da saca';
    }

    final preco = double.tryParse(valor.replaceAll(',','.'));

    if (preco == null){
      return 'Digite um número válido';
    }

    if (preco <= 0){
      return 'O preço precisa ser maior que zero';
    }
    return null;
  }

  String? _validarPrazo (String valor){
    if (valor.trim().isEmpty){
      return 'Informe o prazo';
    }

    final prazo = int.tryParse(valor.trim());

    if(prazo == null){
      return 'Digite um número inteiro de dias';
    }

    if(prazo <= 0){
      return 'O prazo precisa ser maior que zero';
    }
    return null;
  }

  bool get _formularioValido => 
    _validarComprador(_compradorController.text) == null &&
    _validarPreco(_precoSacaController.text) == null &&
    _validarPrazo(_prazoPagamentoController.text) == null;

  void _adicionarProposta(){
    setState((){
      _erroComprador = _validarComprador(_compradorController.text);
      _erroPreco = _validarPreco(_precoSacaController.text);
      _erroPrazo = _validarPrazo(_prazoPagamentoController.text);

      if (_erroComprador != null || _erroPreco != null || _erroPrazo != null){
        return;
      }

      _propostas.add(Proposta(
        comprador: _compradorController.text.trim(),
        precoSaca: double.parse(_precoSacaController.text.replaceAll(',', '.')),
        prazoPagamento: int.parse(_prazoPagamentoController.text.trim()),
      ));

      _propostas.sort((a, b) => b.precoSaca.compareTo(a.precoSaca));

      _compradorController.clear();
      _precoSacaController.clear();
      _prazoPagamentoController.clear();
    });
  }

  void _limpar(){
    _compradorController.clear();
    _precoSacaController.clear();
    _prazoPagamentoController.clear();

    setState((){
      _erroComprador = null;
      _erroPreco = null;
      _erroPrazo = null;
    });
  }

  void _excluirProposta(Proposta proposta){
    setState((){
      _propostas.remove(proposta);
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
              erro: _erroComprador,
              onChanged: (valor) => 
                setState(() => _erroComprador = _validarComprador(valor)),
            ),

            const SizedBox(height: 24),

            _CampoNumero(
              controlador: _precoSacaController,
              rotulo: 'Preço da saca (em R\$)',
              icone: Icons.attach_money_outlined,
              erro: _erroPreco,
              onChanged: (valor) => 
                setState(() => _erroPreco = _validarPreco(valor)),
            ),

            const SizedBox(height: 24),

            _CampoNumero(
              controlador: _prazoPagamentoController,
              rotulo: 'Prazo de pagamento (em dias)',
              icone: Icons.hourglass_bottom_rounded,
              erro: _erroPrazo,
              onChanged: (valor) =>
                setState (() => _erroPrazo = _validarPrazo(valor)),
            ),

            const SizedBox(height: 24),

            Row (
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _formularioValido ? _adicionarProposta : null,
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
                formatar: _reais,
                onExcluir: _excluirProposta,
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
  final String? erro;
  final ValueChanged<String> onChanged;

  const _CampoNumero({
    required this.controlador,
    required this.rotulo,
    required this.icone,
    required this.erro,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: rotulo,
        errorText: erro,
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
  final String? erro;
  final ValueChanged<String> onChanged;

  const _CampoTexto({
    required this.controlador,
    required this.rotulo,
    required this.icone,
    required this.erro,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: rotulo,
        errorText: erro,
        prefixIcon: Icon(icone, color: const Color(0xFF1E5631)),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
class _Resultado extends StatelessWidget {
  final List<Proposta> propostas;
  final String Function(double) formatar;
  final void Function(Proposta) onExcluir;

  const _Resultado({
    required this.propostas,
    required this.formatar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
   
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
          const Text( 'Propostas',
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text (
                    '${proposta.prazoPagamento} dias',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Color(0xFFB3261E)),
                    tooltip: 'Excluir proposta',
                    onPressed: () => onExcluir(proposta),
                  ),
                ],
              )
            ),
        ],
      ),
    );
  }
}