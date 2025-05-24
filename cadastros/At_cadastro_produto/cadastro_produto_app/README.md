# Cadastro Produto App

Este é um aplicativo Flutter para cadastro de produtos, que permite aos usuários cadastrar, listar e visualizar detalhes de produtos de forma simples e intuitiva.

## Estrutura do Projeto

O projeto é organizado da seguinte forma:

```
cadastro_produto_app
├── lib
│   ├── main.dart                     # Ponto de entrada do aplicativo
│   ├── models
│   │   └── produto.dart              # Definição da classe Produto
│   ├── screens
│   │   ├── cadastro_produto_screen.dart  # Tela de cadastro de produtos
│   │   ├── lista_produtos_screen.dart    # Tela de listagem de produtos
│   │   └── detalhes_produto_screen.dart  # Tela de detalhes do produto
│   ├── widgets
│   │   ├── produto_form.dart          # Widget para o formulário de cadastro
│   │   ├── produto_item.dart          # Widget para exibir um item da lista de produtos
│   │   └── produto_detalhe_card.dart   # Widget para exibir detalhes do produto
│   └── utils
│       └── validators.dart            # Funções de validação para os campos do formulário
├── pubspec.yaml                       # Configuração do projeto Flutter
└── README.md                          # Documentação do projeto
```

## Instalação

1. Clone o repositório:
   ```
   git clone <URL_DO_REPOSITORIO>
   ```

2. Navegue até o diretório do projeto:
   ```
   cd cadastro_produto_app
   ```

3. Instale as dependências:
   ```
   flutter pub get
   ```

4. Execute o aplicativo:
   ```
   flutter run
   ```

## Uso

- **Tela de Cadastro**: Permite o cadastro de novos produtos com validação de campos.
- **Tela de Listagem**: Exibe todos os produtos cadastrados em uma lista.
- **Tela de Detalhes**: Mostra informações detalhadas sobre um produto selecionado.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.