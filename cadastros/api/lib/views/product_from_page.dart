import 'package:api/controllers/protuct.controller.dart';
import 'package:api/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFromPage extends StatefulWidget {
  final Product? product;
  const ProductFromPage({super.key, this.product});

  @override
  State<ProductFromPage> createState() => _ProductFromPagestate();
}

class _ProductFromPagestate extends State<ProductFromPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _image = TextEditingController();

  final _controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _title.text = widget.product!.title;
      _price.text = widget.product!.price.toString();
      _description.text = widget.product!.description;
      _category.text = widget.product!.category;
      _image.text = widget.product!.image;
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id,
        title: _title.text,
        price: double.parse(_price.text),
        description: _description.text,
        category: _category.text,
        image: _image.text,
      );
      if (widget.product == null) {
        _controller.addProduct(product);
      } else {
        _controller.updateProduct(product);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(widget.product == null ?' Novo Produto': 'Alterar produto')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: 'titulo',
                  hintText: 'Informe o nome do produto',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o titulo' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _price,
                decoration: InputDecoration(
                  labelText: 'preço',
                  hintText: 'Informe o preço do produto',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o preço' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _category,
                decoration: InputDecoration(
                  labelText: 'categoria',
                  hintText: 'Informe o categoria do produto',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o categoria' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _description,
                decoration: InputDecoration(
                  labelText: 'descrição',
                  hintText: 'Informe o descrição do produto',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o descrição' : null,
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: _image,
                decoration: InputDecoration(
                  labelText: 'URL Imagem',
                  hintText: 'Informe o URL Imagem do produto',
                ),
                validator: (v) => v!.isEmpty ? 'Informe o URL Imagem' : null,
              ),
              SizedBox(height: 25),
              ElevatedButton(onPressed: _save, child:  Text(widget.product == null ? 'salvar':'Atualizar')),
            ],
          ),
        ),
      ),
    );
  }
}
