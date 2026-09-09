# Aula 03 — Widgets de Layout: construindo telas

> **Programação para Dispositivos Móveis** · 6º período — Bacharelado em Sistemas de Informação
> Instituto Federal Goiano — Campus Ceres · Prof. Dr. Paulo César Ferreira Melo

Nesta aula saímos do "o que é um widget" para o "como se monta uma tela".
Ao final, você terá construído — de verdade — a primeira tela do
**Caderno de Campo do Vale**, o aplicativo que evolui ao longo do semestre.

**Esta é a primeira aula que roda no VS Code, com o app de verdade.** As
aulas anteriores (Dart) cabiam no DartPad; widgets de layout pedem ver a
tela e usar o *hot reload*. Se o seu ambiente ainda não está instalado,
veja a seção [Antes de começar](#antes-de-começar).

---

## O que tem nesta pasta

| Pasta | O que é | Quando usar |
|---|---|---|
| [`exercicios/`](exercicios/) | Os quatro ciclos como arquivos `.dart` soltos | Para **estudar** cada ciclo isolado e para o **plano B** no DartPad |
| [`projeto-inicial/`](projeto-inicial/) | Projeto Flutter **no estado zero** | É **aqui que a aula acontece**: você constrói a tela dentro dele, no VS Code |
| [`projeto-gabarito/`](projeto-gabarito/) | O mesmo projeto com a tela **pronta** | Conferência, **liberado após a aula** |

> **Por que duas formas do mesmo código?**
> Um `.dart` solto é ótimo para ler e para colar no DartPad, mas **não é um
> projeto Flutter** — não abre no VS Code nem roda com hot reload. O projeto
> completo é onde a aula acontece. Os dois se complementam.

---

## Antes de começar

Você precisa do ambiente Flutter instalado (Flutter SDK, VS Code com as
extensões Flutter e Dart, e o Android configurado). Os tutoriais de
instalação para **Windows**, **macOS** e **Linux** estão na raiz do
repositório, na pasta `ambiente/`.

Confirme que está tudo certo rodando, no terminal:

```bash
flutter doctor
```

Você deve ver `[✓]` em **Flutter** e no **Android toolchain**. Se algo
estiver com `[!]` ou `[✗]`, resolva **antes** da aula — chegar com o
ambiente quebrado faz você perder o começo do encontro.

### Plano B (se o ambiente não subir a tempo)

Não fique parado. Todos os quatro ciclos rodam no **[dartpad.dev](https://dartpad.dev)**
no **modo Flutter** (seletor no topo da página): cole o arquivo do ciclo da
pasta [`exercicios/`](exercicios/), rode e acompanhe a aula. Você resolve a
instalação depois, com calma.

---

## Como rodar o projeto (VS Code)

O repositório **não versiona** as pastas nativas (`android/`, `ios/`…),
porque elas são geradas por máquina e mudam de um computador para outro.
Por isso, ao abrir o projeto pela primeira vez, você as gera localmente com
um comando. É rápido e só se faz uma vez por projeto.

1. Abra a pasta [`projeto-inicial/`](projeto-inicial/) no VS Code
   (**Arquivo → Abrir Pasta**).

2. No terminal integrado (**Terminal → Novo Terminal**), dentro da pasta do
   projeto, rode:

   ```bash
   flutter create .      # gera android/, ios/ e demais pastas nativas
   flutter pub get       # baixa as dependências do pubspec.yaml
   ```

3. Escolha um dispositivo no canto inferior direito do VS Code (emulador,
   celular por cabo, ou `chrome`/`windows` como alternativa) e rode:

   ```bash
   flutter run
   ```

4. **Deixe o app rodando.** A partir daí, sempre que você salvar um arquivo,
   o **hot reload** aplica a mudança na hora, sem reiniciar o app. É o melhor
   da experiência Flutter — e a razão de rodarmos local nesta aula.

> No terminal onde o app está rodando: `r` força um hot reload, `R` reinicia
> o app do zero (hot restart) e `q` encerra.

---

## O roteiro da aula — quatro ciclos

Cada ciclo tem uma explicação curta (nos slides) e uma atividade. Você
trabalha **em dupla**, dentro do `projeto-inicial`. Os arquivos soltos em
[`exercicios/`](exercicios/) trazem os mesmos códigos comentados, para
estudo e para o DartPad.

### Ciclo 1 — O alfabeto do layout
`Column`, `Row`, `Container`, `Padding`, `SizedBox`.
Você monta o **cabeçalho** da propriedade (nome, cidade, área).
Arquivo de estudo: `exercicios/ciclo1_layout.dart`.

### Ciclo 2 — Restrições e o overflow amarelo
A regra de ouro: *as restrições descem, os tamanhos sobem, o pai decide a
posição.* Você conserta uma tela que **estoura** usando `Expanded` e
`Flexible`.
Arquivo de estudo: `exercicios/ciclo2_overflow.dart`.

### Ciclo 3 — Listas
`ListView.builder` transformando a lista de **talhões** (a mesma dos
exercícios de Dart) em uma lista rolável na tela.
Arquivo de estudo: `exercicios/ciclo3_listas.dart`.

### Ciclo 4 — Juntando tudo
Os três ciclos se encontram na **tela de resumo**: cabeçalho + três números
+ lista. É a primeira tela de produto do app.
Arquivo de estudo: `exercicios/ciclo4_tela_resumo.dart`.

> **Armadilha que vale conhecer:** um `ListView` dentro de uma `Column`
> precisa de um `Expanded` em volta, senão o app nem roda — a `Column`
> oferece "a altura que sobra" e o `ListView` pede altura infinita. É a
> regra de ouro do Ciclo 2 aparecendo de novo, na vertical.

---

## Entrega

Ao final, faça um commit do seu `projeto-inicial` com a tela construída:

```bash
git add .
git commit -m "Aula 03: tela de resumo do Caderno de Campo"
git push
```

Como o `.gitignore` já ignora as pastas nativas e o `build/`, o commit sobe
só o que interessa: seu `lib/` e o `pubspec.yaml`.

---

## Para explorar depois

- **Catálogo visual de widgets:** <https://docs.flutter.dev/ui/widgets> — um
  exemplo de cada widget que existe.
- **Widget of the Week:** vídeos curtos, um widget por vez.
- No **próximo encontro**, esta tela ganha vida: vamos fazê-la responder ao
  toque, com estado (`setState`) e um formulário para registrar uma
  atividade no talhão.
