import 'package:flutter/material.dart';
import 'package:scenario_maker_up/models/scenario_result_model.dart';

// Виджет для отображения одного сценария с возможностью раскрытия, удаления и шаринга
class ScenarioItem extends StatefulWidget {
  const ScenarioItem({
    required this.scenario,
    super.key,
    this.onShare,
    this.onDelete,
  });

  final ScenarioResultModel scenario; // Модель сценария для отображения
  final VoidCallback? onShare; // Коллбек для кнопки "поделиться"
  final VoidCallback? onDelete; // Коллбек для кнопки "удалить"

  @override
  State<ScenarioItem> createState() => _ScenarioItemState();
}

class _ScenarioItemState extends State<ScenarioItem> {
  bool _isExspended = false; // Состояние: раскрыт ли подробный вид

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Верхняя строка: заголовок и кнопка раскрытия
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.scenario.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isExspended = !_isExspended; // Переключаем раскрытие
                    });
                  },
                  icon: Icon(
                    _isExspended ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            // Анимированное раскрытие/сворачивание подробностей сценария
            AnimatedCrossFade(
              firstChild: Text(
                widget.scenario.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.scenario.body,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const Divider(color: Colors.grey, thickness: 0.8),
                  const SizedBox(height: 8),
                  // Детальная информация о сценарии
                  _buildDetailRow(
                    "Platform:",
                    widget.scenario.request.platform.name,
                  ),
                  _buildDetailRow("Theme:", widget.scenario.request.videoTheme),
                  _buildDetailRow(
                    "Target Audience:",
                    widget.scenario.request.targetAudience,
                  ),
                  _buildDetailRow(
                    "Call to Actions:",
                    widget.scenario.request.callToAction,
                  ),
                  const SizedBox(height: 16),
                  // Кнопки "поделиться" и "удалить"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: widget.onShare,
                        icon: const Icon(Icons.share, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              crossFadeState:
                  _isExspended
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
}

// Вспомогательный виджет для отображения пары "лейбл-значение"
Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(
          "$label ",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
