import 'package:flutter/material.dart';
import 'package:scenario_maker_up/ui/screens/saved_scenarios/saved_scenarios_screen.dart';
import 'package:scenario_maker_up/ui/screens/scenario_generation/platform_selection_screen.dart';

// Главный экран приложения с нижней навигацией между выбором платформы и сохранёнными сценариями
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Индекс выбранной вкладки
  late final PageController _pageController; // Контроллер для PageView

  // Список экранов для отображения в PageView
  final List<Widget> _screens = [
    const PlatformSelectionScreen(), // Экран выбора платформы генерации
    const SavedScenariosScreen(), // Экран сохранённых сценариев
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
    ); // Инициализация контроллера
  }

  @override
  void dispose() {
    _pageController.dispose(); // Освобождаем ресурсы контроллера
    super.dispose();
  }

  // Обработчик нажатия на элемент нижней навигации
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Меняем выбранный индекс
    });
    _pageController.animateToPage(
      _selectedIndex, // Перелистываем PageView на нужную страницу
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController, // Контроллер для управления страницами
        physics: const NeverScrollableScrollPhysics(), // Отключаем свайпы
        children: _screens, // Список экранов
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _bottomNavigationBarItem(Icons.home, 'Home', 0), // Кнопка "Home"
              _bottomNavigationBarItem(
                Icons.bookmark,
                'Saved',
                1,
              ), // Кнопка "Saved"
            ],
            currentIndex: _selectedIndex, // Текущий выбранный индекс
            selectedItemColor: Colors.blue[600], // Цвет активной иконки
            unselectedItemColor: Colors.grey[400], // Цвет неактивной иконки
            iconSize: 28,
            showUnselectedLabels:
                false, // Показывать подписи только для выбранной
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped, // Обработчик нажатия
          ),
        ),
      ),
    );
  }

  // Генерация элемента нижней навигации с анимацией увеличения активной иконки
  BottomNavigationBarItem _bottomNavigationBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    bool isSelected = index == _selectedIndex;
    return BottomNavigationBarItem(
      icon: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Icon(
              icon,
              color: isSelected ? Colors.blue[600] : Colors.grey[400],
            ),
          );
        },
      ),
      label: label,
    );
  }
}
