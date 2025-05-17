import 'package:flutter/material.dart';

void main() {
  runApp(const CarrinhoApp());
}

class CarrinhoApp extends StatelessWidget {
  const CarrinhoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de Compras',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CarrinhoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Produto {
  final String nome;
  final double preco;
  final String imagemUrl;
  Produto(this.nome, this.preco, this.imagemUrl);
}

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  final List<Produto> produtos = [
    Produto("Camiseta", 49.90, "https://static.vecteezy.com/system/resources/previews/012/628/220/non_2x/plain-black-t-shirt-on-transparent-background-free-png.png"),
    Produto("Calça", 89.90, "https://placehold.co/150x100/FFFF00/000000/png"),
    Produto("Tênis", 199.90, "https://placehold.co/150x100/FFA500/FFFFFF/png"),
    Produto("Boné", 29.90, "https://placehold.co/150x100/F5DEB3/000000/png"),
    Produto("Meia", 9.90, "https://placehold.co/150x100/FFFFFF/000000/png"),
    Produto("Café", 15.00, "https://placehold.co/150x100/6F4E37/FFFFFF/png"),
  ];

  double total = 0.0;

  void adicionarAoCarrinho(double preco) {
    setState(() {
      total += preco;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho de Compras'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: produtos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        produto.imagemUrl,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        produto.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "R\$ ${produto.preco.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => adicionarAoCarrinho(produto.preco),
                        child: const Text("Adicionar"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.blue.shade50,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "R\$ ${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}