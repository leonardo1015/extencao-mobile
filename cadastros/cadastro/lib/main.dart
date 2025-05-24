import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Clientes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FormularioPage(),
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  //text
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nomefantasiaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _datanacimentoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  //select
  bool _isPessoaFisica = true;
  bool _aceitoTermo = false;
  String estadoCivil = 'solteiro';
  double _rendaMensal = 0.0;
  String _sexo = 'Masculino';
  bool _notificacao = true;
  List<Map<String, dynamic>> dadosFormulario = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cadastro de Clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isPessoaFisica,
                  onChanged: (value) {
                    setState(() {
                      _isPessoaFisica = value!;
                    });
                  },
                ),
                const Text('Pessoa Física'),
                const Spacer(),
                Radio(
                  value: false,
                  groupValue: _isPessoaFisica,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPessoaFisica = value!;
                    });
                  },
                ),
                const Text('Pessoa Jurídica'),
              ],
            ),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite seu nome completo',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Digite seu email',
              ),
            ),
            TextField(
              controller: _telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                hintText: 'Digite seu telefone',
              ),
            ),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                hintText: 'Digite seu endereço',
              ),
            ),
            CheckboxListTile(
              title: const Text('Aceito os termos e condições'),
              value: _aceitoTermo,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  _aceitoTermo = value!;
                });
              },
            ),
            if (_isPessoaFisica) ...[
              TextField(
                controller: _datanacimentoController,
                decoration: const InputDecoration(
                  labelText: 'Data de Nascimento',
                  hintText: 'Digite sua data de nascimento',
                ),
              ),
              TextField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Digite seu CPF',
                ),
              ),
              const Text('Sexo'),
              Row(
                children: [
                  Radio(
                    value: 'Masculino',
                    groupValue: _sexo,
                    onChanged: (String? value) {
                      setState(() {
                        _sexo = value!;
                      });
                    },
                  ),
                  const Text('Masculino'),
                  Radio(
                    value: 'Feminino',
                    groupValue: _sexo,
                    onChanged: (String? value) {
                      setState(() {
                        _sexo = value!;
                      });
                    },
                  ),
                  const Text('Feminino'),
                ],
              ),
            ],
            if (!_isPessoaFisica) ...[
              TextField(
                controller: _nomefantasiaController,
                decoration: const InputDecoration(
                  labelText: 'Nome Fantasia',
                  hintText: 'Digite seu nome fantasia',
                ),
              ),
              TextField(
                controller: _cnpjController,
                decoration: const InputDecoration(
                  labelText: 'CNPJ',
                  hintText: 'Digite seu CNPJ',
                ),
              ),
            ],
            SwitchListTile(
              title: const Text('Estado Civil'),
              subtitle: const Text('Casado ?'),
              value: estadoCivil == 'casado' ? true : false,
              onChanged: (bool value) {
                setState(() {
                  estadoCivil = value ? 'casado' : 'solteiro';
                });
              },
            ),
            SwitchListTile(
              title: const Text('Receber Notificações'),
              subtitle: const Text('Deseja receber notificações ?'),
              value: _notificacao,
              onChanged: (bool value) {
                setState(() {
                  _notificacao = value;
                });
              },
            ),
            Text('renda mensal (de 0 a 10.000): $_rendaMensal'),
            Slider(
              value: _rendaMensal,
              min: 0,
              max: 10000.00,
              divisions: 100,
              label: _rendaMensal.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _rendaMensal = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_nomeController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _telefoneController.text.isEmpty ||
                    _enderecoController.text.isEmpty ||
                    (_isPessoaFisica &&
                        (_datanacimentoController.text.isEmpty ||
                            _cpfController.text.isEmpty)) ||
                    (!_isPessoaFisica &&
                        (_nomefantasiaController.text.isEmpty ||
                            _cnpjController.text.isEmpty)) ||
                    !_aceitoTermo) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, preencha todos os campos.'),
                    ),
                  );
                } else {
                  setState(() {
                    dadosFormulario.add({
                      'nome': _nomeController.text,
                      'email': _emailController.text,
                      'telefone': _telefoneController.text,
                      'endereco': _enderecoController.text,
                      'isPessoaFisica': _isPessoaFisica,
                      'datanacimento': _datanacimentoController.text,
                      'cpf': _cpfController.text,
                      'nomefantasia': _nomefantasiaController.text,
                      'cnpj': _cnpjController.text,
                      'estadoCivil': estadoCivil,
                      'sexo': _sexo,
                      'rendaMensal': _rendaMensal,
                      'notificacao': _notificacao,
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cadastro realizado com sucesso!'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Enviar cadastro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}