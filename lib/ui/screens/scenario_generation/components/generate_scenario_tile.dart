import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenerateScenarioTile extends StatefulWidget {
  const GenerateScenarioTile({
    required this.backgroundColor, // Цвет фона плитки
    required this.iconBackgroundColor, // Цвет фона иконки
    required this.assetPath, // Путь к SVG-иконке
    required this.title, // Заголовок плитки
    required this.description, // Описание опции
    this.onTap, // Коллбек по нажатию
    super.key,
  }); // ... параметры класса

  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final String assetPath;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  State<GenerateScenarioTile> createState() => _GenerateScenarioTileState();
}

class _GenerateScenarioTileState extends State<GenerateScenarioTile> {
  bool isPressed = false; // Состояние для анимации нажатия
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Обработка нажатия
      onTapDown:
          (_) => setState(() {
            isPressed = true;
          }), // Анимация при нажатии
      onTapUp:
          (_) => setState(() {
            isPressed = false;
          }),
      onTapCancel:
          () => setState(() {
            isPressed = false;
          }),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: isPressed ? 0.95 : 1.0, // Эффект "нажатия"
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:
                isPressed
                    ? widget.backgroundColor?.withValues(alpha: 0.7)
                    : widget.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Круглая иконка
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.iconBackgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      widget.assetPath,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Текстовая часть
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
