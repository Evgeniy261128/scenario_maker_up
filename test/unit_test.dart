import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scenario_maker_up/services/helpers.dart';
import 'package:scenario_maker_up/ui/screens/scenario_generation/components/generate_scenario_tile.dart';

void main() {
  group('validateEmail', () {
    test('returns error when email is null', () {
      expect(validateEmail(null), 'Email cannot be empty');
    });
    test('returns error when email is empty', () {
      expect(validateEmail(''), 'Email cannot be empty');
    });
    test('returns error when email does not contain "@"', () {
      expect(
        validateEmail('example.com'),
        'Please enter a valid email address',
      );
    });
    test('returns error when email starts with "@"', () {
      expect(
        validateEmail('@example.com'),
        'Please enter a valid email address',
      );
    });
    test('returns error when email ends with "@"', () {
      expect(validateEmail('example@'), 'Please enter a valid email address');
    });
    test('returns null when email is valid', () {
      expect(validateEmail('test@example.com'), null);
    });
  });

  group('GenerateScenarioTile', () {
    testWidgets('triggers onTap callback when tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      // Не используем const, чтобы избежать конфликтов с переменными
      final backgroundColor = Colors.blue;
      final iconBackgroundColor = Colors.green;
      final assetPath =
          ''; // Для теста можно оставить пустым, чтобы не было ошибки asset
      final title = 'Test Title';
      final description = 'Test Description';

      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: GenerateScenarioTile(
              backgroundColor: backgroundColor,
              iconBackgroundColor: iconBackgroundColor,
              assetPath: assetPath,
              title: title,
              description: description,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Кликаем по всей плитке
      await tester.tap(find.byType(GenerateScenarioTile));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
