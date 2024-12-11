import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
        title: const Text(
          'Вход Supabase',
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
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/register_page');
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Вы ещё не зарегистрированы?',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _supabaseAuth.signInWithPassword(
                    email: _email.text,
                    password: _password.text,
                  );
                  if (context.mounted) {
                    Navigator.of(context).pushNamed('/main_page');
                  }
                } catch (e) {
                  _statusOfRegister = e.toString();
                  setState(() {});
                }
              },
              child: const Text('Войти'),
            ),
            const SizedBox(
              height: 30,
            ),
            if (_statusOfRegister == 'успешно')
              _succesfullulyLogIn()
            else if (_statusOfRegister.isNotEmpty)
              _unsuccesfullulyLogIn(),
          ],
        ),
      ),
    );
  }
}

Widget _succesfullulyLogIn() {
  return const Text(
    'Успешная вход!',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );
}

Widget _unsuccesfullulyLogIn() {
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
