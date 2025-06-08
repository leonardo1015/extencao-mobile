import 'package:api/models/product.dart';
import 'package:api/sevices/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService _sevice = ProductService();
  var products = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      products.value = await _sevice.getALLProducts();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addProduct(Product p) async {
    try {
      final product = await _sevice.addProduct(p);
      if (product.id != null) {
        products.add(product);
      }
      fetchProducts();
      Get.back();
    } catch (e) {
      print('Erro ao cadastrar produto: $e');
    }
  }

  Future<void> updateProduct(Product p) async {
    try {
      final productAtualizado = await _sevice.updateProduct(p);
      final index = products.indexWhere((ele) => ele.id == p.id);
      if (index != -1) {
        products[index] = productAtualizado;
        products.refresh();
      }

      Get.back();
    } catch (e) {
      print('Erro ao cadastrar produto: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _sevice.deleteProduct(id);
      products.removeWhere((ele) => ele.id == id);
      products.refresh();

      
    } catch (e) {
      print('Erro ao Excluir produto: $e');
    }
  }
}
