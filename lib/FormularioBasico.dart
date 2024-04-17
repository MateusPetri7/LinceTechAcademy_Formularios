import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  bool _inativo = false;

  int? _idadeSalva;
  String? _nomeSalvo;
  bool? _inativoSalvo;

  bool get _isFormularioSalvo {
    return _idadeSalva != null && _nomeSalvo != null && _inativoSalvo != null;
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _nomeSalvo = _nomeController.text;
        _idadeSalva = int.tryParse(_idadeController.text) ?? 0;
        _inativoSalvo = _inativo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Formulário')),
          backgroundColor: Colors.yellow,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório.';
                    }
                    if (value.length < 3) {
                      return 'Nome precisa ter pelo menos 3 letras.';
                    }
                    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                      return 'Nome precisa começar com letra maiúscula.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _idadeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Idade",
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Idade obrigatória.";
                    }
                    final idade = int.tryParse(_idadeController.text) ?? 0;
                    if (idade < 18) {
                      return "Idade inválida, precisa ser maior ou igual a 18.";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _inativo,
                      onChanged: (checked) {
                        setState(() {
                          _inativo = !_inativo;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Inativo"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _enviarFormulario();
                  },
                  child: Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                ),
                SizedBox(height: 20.0),
                if (_isFormularioSalvo)
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: _inativoSalvo! ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome: ${_nomeSalvo!}'),
                        Text('Idade: ${_idadeSalva!}'),
                        Text(_inativoSalvo!
                            ? 'Status: Inativo'
                            : 'Status: Ativo'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
