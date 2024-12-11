import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _statusOfRegister = '';

  final _email = TextEditingController();
  final _password = TextEditingController();

  final _supabaseAuth = Supabase.instance.client.auth;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            tooltip: 'Назад',
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: const Text(
          'Регистрация Supabase',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 25,
        ),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  labelText: 'Электронная почта:',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  labelText: 'Пароль:',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final res = await _supabaseAuth.signUp(
                    email: _email.text,
                    password: _password.text,
                  );
                  if (res.user != null) {
                    _statusOfRegister = 'успешно';
                    setState(() {});
                  }
                } catch (e) {
                  _statusOfRegister = e.toString();
                  setState(() {});
                }
              },
              child: const Text('Зарегистрироваться'),
            ),
            const SizedBox(
              height: 30,
            ),
            if (_statusOfRegister == 'успешно')
              _succesfullulyRegister()
            else if (_statusOfRegister.isNotEmpty)
              _unsuccesfullulyRegister(),
          ],
        ),
      ),
    );
  }
}

Widget _succesfullulyRegister() {
  return const Text(
    'Успешная регистрация!',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );
}

Widget _unsuccesfullulyRegister() {
  return const Text(
    'Произошла ошибка, попробуйте использовать другие данные',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );
}
