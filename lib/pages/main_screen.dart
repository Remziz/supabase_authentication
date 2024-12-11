import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _supabaseAuth = Supabase.instance.client.auth;

  @override
  Widget build(BuildContext context) {
    final clientEmail = _supabaseAuth.currentSession?.user.email;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Выйти из аккаунта',
          onPressed: () async {
            await _supabaseAuth.signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushReplacementNamed('/login_page');
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Личный кабинет',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Привет,твоя почта:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '$clientEmail',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
