import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  void _validateAndSubmitForm() {
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;

      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      if (name.isEmpty) {
        _nameError = 'Campo obrigatório';
      }

      if (email.isEmpty) {
        _emailError = 'Campo obrigatório';
      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
        _emailError = 'E-mail inválido';
      }

      if (password.isEmpty) {
        _passwordError = 'Campo obrigatório';
      } else if (password.length < 6) {
        _passwordError = 'A senha deve ter pelo menos 6 caracteres';
      }

      if (_formKey.currentState!.validate()) {
        // Todos os campos são válidos, navegar para a tela de confirmação.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmationScreen(
              name: name,
              email: email,
              password: password,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              if (_nameError != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _nameError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              if (_emailError != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _emailError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              if (_passwordError != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _passwordError!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: _validateAndSubmitForm,
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;

  ConfirmationScreen({required this.name, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmação de Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Registro confirmado:'),
            Text('Nome: $name'),
            Text('E-mail: $email'),
            Text('Senha: $password'),
          ],
        ),
      ),
    );
  }
}
