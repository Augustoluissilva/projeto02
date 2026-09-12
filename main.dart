// CÓDIGO FEITO POR Luis Augusto dos Santos Silva

import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
}

class ContadorApp extends StatelessWidget {
  const ContadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      home: const TelaContador(),
    );
  }
}

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  int _pecasAprovadas = 0;
  final _nomeController = TextEditingController();
  
  
  final List<String> _registros = [];

  void aprovarPeca() {
    
    setState(() {
      _pecasAprovadas += 1;
    });
  }

  void _registrarEZerar() {
    final nome = _nomeController.text.trim().isEmpty ? 'Sem nome' : _nomeController.text.trim();
    //operador ternario(condição ? valorverdadeiro : valorfalso)
    //.trim() remove espaços em branco do início e do fim da string
    //se, depois disso o texto estiver vazio, usamos não informado senão usamos o nome digitado.
    setState(() {
      //de novo toda a mudança do State entra no setState
      _registros.add('$nome - $_pecasAprovadas peças(s)');
      //Monta um registro com o nome e a quantidade de peças aprovadas
      //adiciona esse registro na lista de registros
      _pecasAprovadas = 0;
      //zera o contator, para o inspetor começar a contar o proximo.
    });
  }

  @override
  void dispose() {
    //dispose é chamado quando a tela é removida da arvore de widgets, quando o usuário sai da tela.
    _nomeController.dispose();
    //libera os recursos do controller, evita deixar a memoria alocada/ em uso.
    super.dispose();
    //chama a implementação original/nativa do dispose da classe pai.
  }

  @override
  Widget build(BuildContext context) {
    //Monta e devolve a árvore de widgets que representa a tela.
    //no estado Atual (com os valores atuais de pecasAprovadas, nomeController.text e _registros)
    return Scaffold(
      //esqueleto padrão de uma tela do Flutter
      appBar: AppBar(
        title: const Text('Inspeção de Peças'),
        //Título fixo na barra do topo da tela
      ),
      body: Padding(
        //corpo da tela com espaçamento interno ao redor de todos os elementos.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //organiza todo o conteúdo da tela em uma coluna vertical
          children: [
            TextField(
              //campo de texto onde o inspetor digita o nome dele
              controller: _nomeController,
              //liga este campo ao controller declarado lá em cima
              decoration: const InputDecoration(
                //aparencia do campo de texto
                labelText: 'Nome do Inspetor do Turno',
                border: OutlineInputBorder(),
                //desenha um cotorno ao redor da caixa de texto
              ),
              onChanged: (texto) {
                //onChanged é chamado toda vez que o usuário digita algo
                setState(() {
                  //chamamos setState para avisar que o estado da tela mudou
                });
              }
            ),
            const SizedBox(height: 16),
            //espaço vertical entre o campo de texto e a linha de "responsavel"
            Text(
              _nomeController.text.trim().isEmpty 
                  ? 'Responsável: Não Informado' 
                  : 'Responsável: ${_nomeController.text.trim()}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              '$_pecasAprovadas',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              //fonte grande e em negrito, para destacar a contagem de peças
            ),
            Row(
              //linha horizontal com os dois botões de ação
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  //estilo de botão já preenchido
                  onPressed: aprovarPeca,
                  icon: const Icon(Icons.add),
                  label: const Text('Aprovar Peça'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  //botão com apenas contorno sem preenchimento
                  onPressed: _registrarEZerar,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Registrar e Zerar'),
                ),
              ],
            ), 

            const SizedBox(height: 16), // Espaço antes do histórico

            const Align(
              //Align posiciona seus filhos dentro do espaço disponivel
              alignment: Alignment.centerLeft,
              child: Text(
                'Histórico do Turno',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            
            Expanded(
              //Força o espaço vertical disponivel/restante
              child: _registros.isEmpty
                  ? const Center(child: Text('Nenhum registro ainda.')) 
                  
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile( 
                            leading: const Icon(Icons.history),
                            title: Text(_registros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}