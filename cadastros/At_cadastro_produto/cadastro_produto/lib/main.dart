import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Produto {
  final String nome;
  final double precoCompra;
  final double precoVenda;
  final int quantidade;
  final String categoria;
  final String descricao;
  final String imagemUrl;
  final bool ativo;
  final bool promocao;
  final double desconto;

  Produto({
    required this.nome,
    required this.precoCompra,
    required this.precoVenda,
    required this.quantidade,
    required this.categoria,
    required this.descricao,
    required this.imagemUrl,
    required this.ativo,
    required this.promocao,
    required this.desconto,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Produto> _produtos = [];

  void _addProduto(Produto produto) {
    setState(() {
      _produtos.add(produto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produto',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: ListaProdutosScreen(produtos: _produtos, onAdd: _addProduto),
    );
  }
}

class ListaProdutosScreen extends StatelessWidget {
  final List<Produto> produtos;
  final Function(Produto) onAdd;

  const ListaProdutosScreen({
    super.key,
    required this.produtos,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome: ${produto.nome}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Preço de compra: ${produto.precoCompra.toStringAsFixed(2)}',
                  ),
                  Text(
                    'Preço de venda: ${produto.precoVenda.toStringAsFixed(2)}',
                  ),
                  Text('Quantidade: ${produto.quantidade}'),
                  Text('Categoria: ${produto.categoria}'),
                  Text('Descrição: ${produto.descricao}'),
                  const SizedBox(height: 8),
                  if (produto.imagemUrl.isNotEmpty)
                    Image.network(
                      produto.imagemUrl,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 60),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        produto.ativo ? Icons.check_circle : Icons.cancel,
                        color: produto.ativo ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text('Produto Ativo: ${produto.ativo ? "Sim" : "Não"}'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        color: produto.promocao ? Colors.orange : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text('Em Promoção: ${produto.promocao ? "Sim" : "Não"}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.percent, color: Colors.deepPurple),
                      const SizedBox(width: 4),
                      Text('Desconto: ${produto.desconto.toStringAsFixed(0)}%'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final novoProduto = await Navigator.push<Produto>(
            context,
            MaterialPageRoute(builder: (_) => const CadastroProdutoScreen()),
          );
          if (novoProduto != null) {
            onAdd(novoProduto);
          }
        },
      ),
    );
  }
}

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoCompraController = TextEditingController();
  final _precoVendaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemUrlController = TextEditingController();
  String? _categoriaSelecionada;
  bool _ativo = true;
  bool _promocao = false;
  double _desconto = 0.0;

  final List<String> _categorias = [
    'Eletrônicos',
    'Roupas',
    'Alimentos',
    'Livros',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informações do Produto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  prefixIcon: Icon(Icons.inventory_2),
                ),
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _precoCompraController,
                decoration: const InputDecoration(
                  labelText: 'Preço de compra',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _precoVendaController,
                decoration: const InputDecoration(
                  labelText: 'Preço de venda',
                  prefixIcon: Icon(Icons.price_change),
                ),
                keyboardType: TextInputType.number,
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quantidadeController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade em Estoque',
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description),
                ),
                validator:
                    (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _categoriaSelecionada,
                items:
                    _categorias
                        .map(
                          (cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)),
                        )
                        .toList(),
                onChanged: (v) => setState(() => _categoriaSelecionada = v),
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  prefixIcon: Icon(Icons.category),
                ),
                validator:
                    (v) =>
                        v == null || v.isEmpty
                            ? 'Selecione uma categoria'
                            : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _imagemUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL da Imagem',
                  prefixIcon: Icon(Icons.image),
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text('Produto Ativo'),
                value: _ativo,
                onChanged: (v) => setState(() => _ativo = v),
                activeColor: Colors.deepPurple,
              ),
              SwitchListTile(
                title: const Text('Produto em Promoção'),
                value: _promocao,
                onChanged: (v) => setState(() => _promocao = v),
                activeColor: Colors.deepPurple,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Desconto (%)'),
                  Expanded(
                    child: Slider(
                      value: _desconto,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: '${_desconto.round()}%',
                      onChanged: (v) => setState(() => _desconto = v),
                      activeColor: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final produto = Produto(
                        nome: _nomeController.text,
                        precoCompra:
                            double.tryParse(_precoCompraController.text) ?? 0,
                        precoVenda:
                            double.tryParse(_precoVendaController.text) ?? 0,
                        quantidade:
                            int.tryParse(_quantidadeController.text) ?? 0,
                        categoria: _categoriaSelecionada ?? '',
                        descricao: _descricaoController.text,
                        imagemUrl: _imagemUrlController.text,
                        ativo: _ativo,
                        promocao: _promocao,
                        desconto: _desconto,
                      );
                      Navigator.pop(context, produto);
                    }
                  },
                  child: const Text('Cadastrar Produto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
