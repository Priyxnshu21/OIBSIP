# Calculator App

A beautiful calculator built with Flutter. This app features a modern, clean UI, supporting basic arithmetic operations and a responsive layout for Android devices.

## Features
- Modern calculator UI (dark theme, rounded buttons)
- Supports addition, subtraction, multiplication, division, percentage, sign toggle, and clear
- Responsive layout for different screen sizes
- Calculation history display
- Built with Provider for state management
- Uses [math_expressions](https://pub.dev/packages/math_expressions) for expression parsing
- Customizable colors, styles, and dimensions

## Screenshots
<!-- Add screenshots here if available -->

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 3.8.1 or compatible

### Installation
1. Clone the repository:
   ```sh
   git clone <repo-url>
   cd calculator_app
   ```
2. Get dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

## Project Structure
- `lib/main.dart` - App entry point
- `lib/presentation/` - UI screens, widgets, styles, and dimensions
- `lib/core/calculator_service.dart` - Core calculation logic
- `lib/presentation/calculator_viewmodel.dart` - State management (Provider)
- `test/` - Widget and unit tests

## Customization
- **Colors:** Edit `lib/presentation/utils/app_colors.dart`
- **Text Styles:** Edit `lib/presentation/utils/app_styles.dart`
- **Dimensions:** Edit `lib/presentation/utils/app_dimens.dart`

## Running Tests
```sh
flutter test
```

## Credits
- [Flutter](https://flutter.dev/)
- [math_expressions](https://pub.dev/packages/math_expressions)
- [Google Fonts](https://pub.dev/packages/google_fonts)

---
Feel free to contribute or open issues for suggestions and improvements!
