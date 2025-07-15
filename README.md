# OIBSIP 

This repository contains three Flutter applications developed as part of your OIBSIP internship tasks:

1. **Calculator App**
2. **Quiz App**
3. **ToDo App**

---

## 1. Calculator App

A beautiful calculator built with Flutter, featuring a modern UI and supporting basic arithmetic operations.

**Features:**
- Modern calculator UI (dark theme, rounded buttons)
- Addition, subtraction, multiplication, division, percentage, sign toggle, and clear
- Responsive layout for different screen sizes
- Calculation history display
- State management with Provider
- Uses [math_expressions](https://pub.dev/packages/math_expressions) for expression parsing

**Getting Started:**
```sh
cd calculator
flutter pub get
flutter run
```

**Customization:**
- Colors: `lib/presentation/utils/app_colors.dart`
- Text Styles: `lib/presentation/utils/app_styles.dart`
- Dimensions: `lib/presentation/utils/app_dimens.dart`

---

## 2. Quiz App

A simple Flutter quiz application for practicing general knowledge questions in a multiple-choice format.

**Features:**
- Multiple choice questions
- Immediate feedback after each answer
- Final score at the end
- Clean, modern UI
- Easily extendable with your own questions

**Getting Started:**
```sh
cd "quiz app"
flutter pub get
flutter run
```

**Customizing Questions:**
- Edit `lib/data/questions.dart` to add or modify quiz questions.

---

## 3. ToDo App

A production-ready Flutter ToDo app with authentication, notes, dark mode, and a clean, modern UI.

**Features:**
- User authentication (sign up, login, logout)
- Personal ToDos and Notes (per user)
- SQLite local storage
- Responsive UI with dark mode
- Bottom navigation for ToDos and Notes

**Getting Started:**
```sh
cd "todo app"
flutter pub get
flutter run
```

**Customization:**
- Update theme colors in `main.dart`
- Add features or polish the UI as needed

---

## Requirements

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or later recommended)
- Dart 3.8.1 or compatible
- Android Studio, VS Code, or your preferred IDE
- Android emulator or physical device

---

## Project Structure

Each app follows a similar structure:
- `lib/` - Main source code
  - `screens/` or `presentation/` - UI screens
  - `database/` or `core/` - Logic and data helpers
  - `model/` or `models/` - Data models
  - `widgets/` or `components/` - Reusable UI components
- `assets/` - Images and other assets
- `test/` - Widget and unit tests

---

## Contributing

Feel free to contribute or open issues for suggestions and improvements! 
