import 'package:cadastros_bd/model/produto_model.dart';

import 'package:flutter/material.dart';

import '../database/product_database.dart';
import 'componentes/lista_iten.dart';
import 'product_form_page.dart.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<ProdutoModel>> _carregarProdutos() async {
    final db = ProductDatabase();
    return await db.findAPIProducts();
  }

  Future<void> _updateList() async {
    await _carregarProdutos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista e Cadastro de Produto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: const [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
      body: FutureBuilder<List<ProdutoModel>>(
        future: _carregarProdutos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar produtos'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado'));
          }
          final listaProdutos = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 75),
            itemCount: listaProdutos.length,
            itemBuilder: (context, index) {
              final produto = listaProdutos[index];
              return ListaIten(
                product: produto,
                onupdate: _updateList,
                );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          ProdutoModel? produto = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductFormPage()),
          );
          if (produto != null) {
            final db = ProductDatabase();
            await db.insertProduct(produto);
            setState(() {});
          }
        },
        label: const Text(
          'Novo Produto',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
