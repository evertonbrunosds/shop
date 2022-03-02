// ignore_for_file: slash_for_doc_comments
import 'package:flutter/material.dart';

enum SignMode {
  /**
   * Refere-se ao valor de inscrição.
   */
  signUp,
  /**
   * Refere-se ao valor de entrada.
   */
  signIn,
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final SignMode _signMode = SignMode.signIn;
  final Map<String, String> _authData = {'email': '', 'password': ''};

  void _submit() {}

  @override
  Widget build(final BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          padding: const EdgeInsets.all(16),
          height: 320,
          width: deviceSize.width * 0.75,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  return (email.trim().isEmpty || !email.contains('@'))
                      ? 'Informe um email válido!'
                      : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onSaved: (password) => _authData['password'] = password ?? '',
                controller: _passwordController,
                validator: (_password) {
                  final password = _password ?? '';
                  return (password.isEmpty || password.length < 5)
                      ? 'Informe uma senha válida!'
                      : null;
                },
              ),
              if (_signMode == SignMode.signUp)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (_password) {
                    final password = _password ?? '';
                    return password != _passwordController.text
                        ? 'As senhas informadas não conferem!'
                        : null;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: _signMode == SignMode.signIn
                    ? const Text('ENTRAR')
                    : const Text('REGISTRAR'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
