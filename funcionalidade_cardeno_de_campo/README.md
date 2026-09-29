# 🌾 Comparador de Propostas de Venda

Aplicativo Flutter para **comparar propostas de compra de sacas** (ex.: soja, milho, café). O usuário cadastra as ofertas recebidas e o app as organiza automaticamente, **da maior para a menor oferta de preço**.

## O que o app faz

- **Cadastra propostas** com três informações: nome do comprador, preço da saca (R$) e prazo de pagamento (dias).
- **Valida os dados em tempo real**, mostrando mensagens de erro enquanto o usuário digita. O botão **Inserir** só é habilitado quando tudo está correto.
- **Ordena as propostas pelo melhor preço** a cada nova inserção.
- **Exibe os valores no padrão brasileiro** (`R$ 1.250,50`) e aceita vírgula ou ponto na digitação.
- **Permite excluir** propostas pelo ícone de lixeira e **limpar** o formulário com o botão Limpar.

> As propostas ficam apenas em memória: ao fechar o app, a lista é apagada.

## Como rodar

**Pré-requisito:** [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (verifique com `flutter doctor`).

```bash
# 1. Crie o projeto
flutter create comparador_propostas
cd comparador_propostas

# 2. Substitua o conteúdo de lib/main.dart pelo código deste repositório

# 3. Rode em um emulador, celular conectado ou navegador
flutter run
```

Não há dependências externas: o app usa apenas o pacote `flutter/material.dart`.

## Estrutura do código

Todo o código está em `lib/main.dart`:

| Classe | Responsabilidade |
|---|---|
| `ComparadorApp` | Configura o app (título, tema verde, Material 3). |
| `Proposta` | Modelo de dados: comprador, preço da saca e prazo. |
| `TelaComparador` | Tela principal. Guarda a lista de propostas, valida os campos e trata as ações de inserir, limpar e excluir. |
| `_CampoTexto` / `_CampoNumero` | Campos de entrada reutilizáveis (teclado de texto ou numérico). |
| `_Resultado` | Cartão que lista as propostas ordenadas, com opção de exclusão. |

## Regras de validação

| Campo | Regra |
|---|---|
| Comprador | Obrigatório, mínimo de 3 caracteres. |
| Preço da saca | Número maior que zero (aceita `,` ou `.`). |
| Prazo | Número inteiro de dias, maior que zero. |
