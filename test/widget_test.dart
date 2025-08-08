import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/utils/theme_provider.dart';

void main() {
  test('ThemeProvider toggles themeMode correctly', () {
    final themeProvider = ThemeProvider();

    // Initially it should be light mode
    expect(themeProvider.isDarkMode, false);

    // Toggle to dark mode
    themeProvider.toggleTheme(true);
    expect(themeProvider.isDarkMode, true);

    // Toggle back to light mode
    themeProvider.toggleTheme(false);
    expect(themeProvider.isDarkMode, false);
  });
}
