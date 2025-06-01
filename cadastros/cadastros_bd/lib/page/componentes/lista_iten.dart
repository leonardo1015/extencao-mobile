import 'package:cadastros_bd/database/product_database.dart';
import 'package:cadastros_bd/model/produto_model.dart';

import 'package:cadastros_bd/widgets/chip_info.dart';
import 'package:flutter/material.dart';

import '../product_form_page.dart.dart';

class ListaIten extends StatelessWidget {
  final ProdutoModel product;
  final VoidCallback onupdate;
  const ListaIten({super.key, required this.product, required this.onupdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nome
            Row(
              children: [
                const Icon(Icons.label, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    product.nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Imagem (se houver)
            if (product.imagem != null && product.imagem.toString().isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imagem!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Center(child: Text('Imagem não carregada')),
                ),
              ),
            if (product.imagem != null && product.imagem.toString().isNotEmpty)
              const SizedBox(height: 12),

            /// Preços e quantidade
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChipInfoWidget(
                    label: 'Compra R\$ ${product.precoCompra}',
                    icon: Icons.shopping_cart,
                  ),
                  const SizedBox(width: 8),
                  ChipInfoWidget(
                    label: 'Venda R\$ ${product.precoVenda}',
                    icon: Icons.attach_money,
                  ),
                  const SizedBox(width: 8),
                  ChipInfoWidget(
                    label: 'Qtd ${product.quantidade}',
                    icon: Icons.inventory,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// Categoria
            Row(
              children: [
                const Icon(Icons.category, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Categoria: ${product.categoria}',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 4),

            /// Descrição
            Row(
              children: [
                const Icon(Icons.description, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Descrição: ${product.descricao}',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Status
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(
                    product.ativo ? Icons.check_circle : Icons.cancel,
                    color: product.ativo ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product.ativo ? 'Ativo' : 'Inativo',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(width: 12),
                  // Informa se está em promoção
                  Icon(
                    product.emPromocao ? Icons.discount : Icons.price_check,
                    color: product.emPromocao ? Colors.orange : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    product.emPromocao ? 'Em Promoção' : 'Sem Promoção',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(width: 8),
                  const Icon(Icons.percent, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Desconto: ${product.desconto}%',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    final ProdutoModel? produtoAlterado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductFormPage(produto: product),
                      ),
                    );
                    if (produtoAlterado != null) {
                      final db = ProductDatabase();
                      await db.updateProduct(product.id!, produtoAlterado);
                      onupdate();
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 209, 66, 207),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final db = ProductDatabase();
                    await db.deleteProduct(product.id!, );
                    onupdate();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 176, 209, 66),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
