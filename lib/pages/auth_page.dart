import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/google_signin_api.dart';
import '../models/api_response.dart';
import '../pages/account_page.dart';
import '../services/user_service.dart';
import '../notes/notes_home_page.dart';
import '../providers/auth_provider.dart';
import '../pages/settings_page.dart';
import '../constants.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Duly Noted $kVersion'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsPage.routeName);
                },
                icon: const Icon(Icons.settings)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Login'),
            Tab(text: 'Register'),
          ]),
        ),
        body: const TabBarView(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: AuthLoginForm(),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: AuthRegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthRegisterForm extends ConsumerStatefulWidget {
  const AuthRegisterForm({super.key});

  @override
  ConsumerState<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends ConsumerState<AuthRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    Future register() async {
      ref.watch(authProvider.notifier).register(
            name: 'adf',
            username: 'ad',
            email: 'adf',
            password: 'sd',
          );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Please fill your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Please fill valid username.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Please fill your email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: !_obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Password is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              elevation: 4,
            ),
            child: const Text(
              'Create Account',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthLoginForm extends ConsumerStatefulWidget {
  const AuthLoginForm({super.key});

  @override
  ConsumerState<AuthLoginForm> createState() => _AuthLoginFormState();
}

class _AuthLoginFormState extends ConsumerState<AuthLoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isLoading = false;

  var username = '';
  String password = '';

  Future<void> singInWithGoogle() async {
    try {
      final user = await GoogleSignInApi.login();
      if (user == null) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in failed')),
        );
      } else {
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => AccountPage(user: user)),
        );
      }
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      ApiResponse response = await login(username, password);
      setState(() {
        _isLoading = false;
      });
      if (response.error == null) {
        if (!context.mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const NotesHomePage(),
          ),
          (route) => false,
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response.error}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username or Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Please fill valid username or email.';
              }
              setState(() {
                username = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length <= 1) {
                return 'Password is required';
              }
              setState(() {
                password = value;
              });
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              elevation: 4,
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          ElevatedButton(
            onPressed: singInWithGoogle,
            child: const Text('Continue with Google'),
          ),
        ],
      ),
    );
  }
}
