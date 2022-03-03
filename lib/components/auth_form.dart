// ignore_for_file: slash_for_doc_comments
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

import '../models/sign_mode.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _signMode = SignMode(state: SignState.signIn);
  final Map<String, String> _authData = {'email': '', 'password': ''};
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _showErrorDialog(
      {String title = 'Ocorreu um Erro', required String msg}) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Ok!'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      setState(() => _isLoading = true);
      _formKey.currentState?.save();
      final auth = Provider.of<Auth>(context, listen: false);
      try {
        if (_signMode.isSignIn) {
          await auth.signIn(
            email: _authData['email']!,
            password: _authData['password']!,
          );
        } else {
          await auth.signUp(
            email: _authData['email']!,
            password: _authData['password']!,
          );
        }
      } on AuthException catch (ex) {
        _showErrorDialog(msg: ex.toString());
      } catch (ex) {
        _showErrorDialog(msg: 'Erro Inesperado!');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _switchAuthMode() {
    setState(() {
      _signMode.isSignIn ? _signMode.toSignUp() : _signMode.toSignIn();
    });
  }

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
        height: _signMode.isSignIn ? 320 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
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
              if (_signMode.isSignUp)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: _signMode.isSignIn
                      ? null
                      : (_password) {
                          final password = _password ?? '';
                          return password != _passwordController.text
                              ? 'As senhas informadas não conferem!'
                              : null;
                        },
                ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: _signMode.isSignIn
                          ? const Text('ENTRAR')
                          : const Text('CADASTRAR-SE'),
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
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(_signMode.isSignIn
                    ? 'DESEJA CADASTRAR-SE?'
                    : 'JÁ POSSUI CADASTRO?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
