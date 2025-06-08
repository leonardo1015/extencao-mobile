import 'dart:convert';


import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getALLProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((j) => Product.fromJson(j)).toList();
    } else {
      throw Exception('erro ao carregar produtos');
    }
  }

  Future<Product> addProduct(Product product) async {
    final Response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (Response.statusCode == 200 || Response.statusCode == 201) {
      return Product.fromJson(json.decode(Response.body));
    } else {
      throw Exception('Erro ao buscar os produtos');
    }
  }

  Future<Product> updateProduct(Product product) async {
    final Response = await http.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (Response.statusCode == 200 || Response.statusCode == 201) {
      return Product.fromJson(json.decode(Response.body));
    } else {
      throw Exception('Erro ao buscar os produtos');
    }
  }

  Future<void> deleteProduct(int id) async {
    final Response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (Response.statusCode != 200) {
      throw Exception('Erro ao Excluir produto');
    }
  }
}
