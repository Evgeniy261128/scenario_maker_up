import 'package:flutter/material.dart';
import 'package:scenario_maker_up/services/auth.dart';
import 'package:scenario_maker_up/services/helpers.dart';
import 'package:scenario_maker_up/ui/screens/autharization/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController; // Контроллер email
  late final TextEditingController _passwordController; // Контроллер пароля
  final _formKey = GlobalKey<FormState>(); // Ключ формы
  final authService = Auth(); // Сервис аутентификации

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(); // Инициализация контроллеров
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Wellcome!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Ввод email с валидацией
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                // Ввод пароля
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Кнопки входа и регистрации
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Вход пользователя
                          authService.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Регистрация пользователя
                          authService.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Переход на экран восстановления пароля
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text("Forgot password ?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
