import 'package:api/controllers/protuct.controller.dart';
import 'package:api/views/product_from_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPages extends StatelessWidget {
  ProductListPages({super.key});
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Produtos')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.products.isEmpty) {
          return const Center(child: Text('Nenhum produto encontrado'));
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return GestureDetector(
              onLongPress: () {
                Get.to(ProductFromPage(product: product));
              },
              child: ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.title),
                subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.deleteProduct(product.id!);
                      },
                      icon: const Icon(Icons.delete,color: Colors.redAccent,),
                    ),
                  ],
                ),
                onTap: () {
                  // Ação ao clicar no produto
                },
              ),
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 47, 244, 96),
        onPressed: () {
          Get.to(() => const ProductFromPage());
        },
        child: const Icon(Icons.add,color:Color.fromARGB(255, 64, 127, 252)),
      ),
    );
  }
}
