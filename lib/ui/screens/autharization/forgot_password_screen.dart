import 'package:flutter/material.dart';
import 'package:scenario_maker_up/services/helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController
  _emailController; // Контроллер для поля email

  final _formKey = GlobalKey<FormState>(); // Ключ формы для валидации

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(); // Инициализация контроллера email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Поле для ввода email с валидацией
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      validateEmail, // Валидация email через функцию из helpers
                ),
                const SizedBox(height: 20),
                // Кнопка отправки ссылки для сброса пароля
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    // Здесь стоит добавить вызов метода для отправки письма восстановления пароля
                    // Например:
                    // if (_formKey.currentState!.validate()) {
                    //   Auth().repairPassword(email: _emailController.text);
                    // }
                  },
                  child: const Text("Send Reset Link"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
