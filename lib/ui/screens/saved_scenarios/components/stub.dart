import 'package:flutter/material.dart';

class Stub extends StatelessWidget {
  const Stub({
    required this.text,
    required this.icon,
    required this.iconColor,
    super.key,
  });

  final String text; // Текст заглушки
  final IconData icon; // Иконка
  final Color? iconColor; // Цвет иконки

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 72, color: iconColor), // Крупная иконка
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center, // Центрирование текста
          ),
        ],
      ),
    );
  }
}
