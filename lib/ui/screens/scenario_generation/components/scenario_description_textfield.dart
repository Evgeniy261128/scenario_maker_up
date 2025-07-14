import 'package:flutter/material.dart';

class ScenarioDescriptionTextfield extends StatelessWidget {
  const ScenarioDescriptionTextfield({
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
    super.key,
  });

  final String title; // Заголовок поля (например, "Тема видео")
  final String hintText; // Подсказка внутри поля (например, "Введите тему")
  final TextEditingController controller; // Контроллер для управления текстом
  final String? Function(String?) validator; // Функция для валидации значения

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Выравнивание элементов по левому краю
      mainAxisSize:
          MainAxisSize.min, // Минимально необходимый размер по вертикали
      children: [
        Text(
          title, // Отображение заголовка поля
          style: const TextStyle(fontSize: 16), // Размер шрифта заголовка
        ),
        const SizedBox(height: 5), // Отступ между заголовком и полем ввода
        TextFormField(
          validator: validator, // Применение функции валидации к значению поля
          controller: controller, // Контроллер для доступа и управления текстом
          decoration: InputDecoration(
            labelText: hintText, // Подсказка внутри поля
            border: const OutlineInputBorder(), // Внешняя рамка поля
          ),
        ),
      ],
    );
  }
}
