import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scenario_maker_up/redux/store.dart';
import 'package:scenario_maker_up/services/auth.dart';
import 'package:scenario_maker_up/ui/home_screen.dart';
import 'package:scenario_maker_up/ui/screens/autharization/login_screen.dart';

// Главная точка входа в приложение
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Гарантирует корректную инициализацию Flutter перед запуском
  await Firebase.initializeApp(); // Инициализация Firebase для работы с аутентификацией и БД
  runApp(const MyApp()); // Запуск приложения
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store:
          store, // Провайдер Redux-хранилища для управления состоянием приложения
      child: MaterialApp(
        title: 'Scenario Maker App', // Название приложения
        home: StreamBuilder<User?>(
          stream:
              Auth()
                  .getAuthStateChange, // Стрим для отслеживания состояния авторизации пользователя
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              // Если пользователь авторизован — показываем главный экран приложения
              return const HomeScreen();
            } else {
              // Если пользователь не авторизован — показываем экран логина
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
