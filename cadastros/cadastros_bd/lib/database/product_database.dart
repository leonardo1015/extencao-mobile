import 'package:cadastros_bd/model/produto_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase {

  static final ProductDatabase _instance = ProductDatabase._internal();
  // Construtor que retorna a instância única
  factory ProductDatabase() => _instance;
  // Construtor privado
  ProductDatabase._internal();

  // Declare your database variable (replace 'Database' with the correct import if needed)
  Database? _db;
  //função para inicializar o banco de dados
  Future<Database> get database async {
    if (_db != null) return _db!;
    // Inicializa o banco de dados se ainda não estiver criado
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    // Define o caminho do banco de dados
    final dbCaminho = await getDatabasesPath();

    final caminhoCompreto = join(dbCaminho, 'produtos_bd.db');
    // Abre o banco de dados, criando-o se não existir
    return await openDatabase(
      caminhoCompreto,
      version: 1,
      onCreate: (db, version) async {
        // Cria a tabela de produtos
        await db.execute('''
          CREATE TABLE produtos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            preco_compra REAL NOT NULL,
            preco_venda REAL NOT NULL,
            quantidade INTEGER NOT NULL,
            descricao TEXT NOT NULL,
            categoria TEXT NOT NULL,
            imagem TEXT NOT NULL,
            ativo INTEGER DEFAULT 1,
            em_promocao INTEGER NOT NULL DEFAULT 0,
            data_cadastro TEXT NOT NULL DEFAULT (datetime('now')),
            desconto REAL NOT NULL DEFAULT 0.0
          )
        ''');
      },
      
    );

  }
  
  Future<int> insertProduct(ProdutoModel productModel) async {
    final db = await database;
    final map = productModel.toMap();
    // Insere um novo produto na tabela
    return await db.insert('produtos', map);
  }
  // Função para buscar todos os produtos
  Future<List<ProdutoModel>> findAPIProducts() async {
    final db = await database;
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      // Simula um atraso de 1 segundo e 500 milissegundos para simular uma chamada de API
    });
    // Busca todos os produtos da tabela
    List<Map<String,Object?>>listMap = await db.query('produtos');
    // Converte a lista de mapas em uma lista de modelos de produto
    return listMap.map((item) => ProdutoModel.fromMap(item)).toList();
  }
  Future<int> updateProduct(int id, ProdutoModel productModel) async {
    final db = await database;
    // Atualiza um produto existente na tabela
    return await db.update(
      'produtos',
      productModel.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteProduct(int id) async {
    final db = await database;
    // Deleta um produto da tabela
    return await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Função para fechar o banco de dados
}
