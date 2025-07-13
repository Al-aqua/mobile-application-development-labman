# Lab 1: Introduction to Flutter and Setting Up the Environment

## Learning Objectives

By the end of this lab, students will be able to:

- Install Flutter SDK and set up the development environment
- Create their first Flutter project
- Understand the Flutter project structure
- Build and run a simple "Hello World" app
- Create the base Personal Finance Tracker project

---

## Prerequisites

- Basic programming knowledge (preferably Dart or similar language)
- Computer with at least 8GB RAM
- Stable internet connection for downloads

---

## Part 1: Environment Setup

### Step 1: Install Flutter SDK

#### For Windows:

1. Download Flutter SDK from [flutter.dev](https://flutter.dev)
2. Extract the zip file to `C:\flutter` (avoid spaces in path)
3. Add Flutter to your PATH:
   - Open System Properties → Advanced → Environment Variables
   - Add `C:\flutter\bin` to your PATH variable
4. Open Command Prompt and run:
   ```bash
   flutter doctor
   ```

#### For macOS:

1. Download Flutter SDK from [flutter.dev](https://flutter.dev)
2. Extract to your home directory: `~/flutter`
3. Add to PATH by editing `~/.zshrc` or `~/.bash_profile`:
   ```bash
   export PATH="$PATH:$HOME/flutter/bin"
   ```
4. Run:
   ```bash
   source ~/.zshrc
   flutter doctor
   ```

#### For Linux:

1. Download Flutter SDK
2. Extract to `~/flutter`
3. Add to PATH in `~/.bashrc`:
   ```bash
   export PATH="$PATH:$HOME/flutter/bin"
   ```
4. Run:
   ```bash
   source ~/.bashrc
   flutter doctor
   ```

### Step 2: Install Android Studio

1. Download Android Studio from [developer.android.com](https://developer.android.com/studio)
2. Install with default settings
3. Open Android Studio and install:
   - Android SDK
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Flutter plugin
   - Dart plugin

### Step 3: Set up Android Emulator

1. In Android Studio, go to Tools → AVD Manager
2. Create Virtual Device → Choose Pixel 4 → API 30 (Android 11)
3. Click Finish and launch the emulator

### Step 4: Verify Installation

Run the following command and ensure all items have checkmarks:

```bash
flutter doctor
```

**Expected Output:**

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows, locale en-US)
[✓] Android toolchain - develop for Android devices
[✓] Android Studio (version 2023.x)
[✓] Connected device (1 available)
[✓] Network resources
```

---

## Part 2: Creating Your First Flutter Project

### Step 1: Create a New Project

1. Open terminal/command prompt
2. Navigate to your desired directory
3. Create a new Flutter project:
   ```bash
   flutter create personal_finance_tracker
   ```
4. Navigate into the project:
   ```bash
   cd personal_finance_tracker
   ```

### Step 2: Open in IDE

**Option A: Android Studio**

1. Open Android Studio
2. File → Open → Select your project folder

**Option B: VS Code**

1. Install Flutter and Dart extensions
2. Open project folder in VS Code

### Step 3: Run the Default App

1. Start your emulator
2. Run the app:
   ```bash
   flutter run
   ```
3. You should see a counter app with a floating action button

---

## Part 3: Understanding Project Structure

### Key Files and Folders:

```
personal_finance_tracker/
├── android/                 # Android-specific files
├── ios/                    # iOS-specific files
├── lib/                    # Main Dart code
│   └── main.dart          # Entry point of the app
├── test/                   # Test files
├── pubspec.yaml           # Project configuration & dependencies
└── README.md              # Project documentation
```

### Important Files Explained:

#### `pubspec.yaml`

This is your project's configuration file:

```yaml
name: personal_finance_tracker
description: A new Flutter project.
version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  uses-material-design: true
```

#### `lib/main.dart`

The entry point of your Flutter app:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

---

## Part 4: Building Your Personal Finance Tracker Base

### Step 1: Modify main.dart

Replace the content of `lib/main.dart` with:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const PersonalFinanceApp());
}

class PersonalFinanceApp extends StatelessWidget {
  const PersonalFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Your Finance Tracker!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Track your expenses and income',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 2: Test Hot Reload

1. Save the file
2. In your terminal where the app is running, press `r` for hot reload
3. You should see the changes immediately without restarting

### Step 3: Understanding the Code

**Key Components:**

- `main()`: Entry point that runs the app
- `MaterialApp`: Root widget that provides Material Design
- `Scaffold`: Basic layout structure with AppBar and body
- `AppBar`: Top navigation bar
- `Center`: Centers its child widget
- `Column`: Arranges children vertically
- `Icon` and `Text`: UI elements for display

---

## Part 5: Flutter Architecture Overview

### Widget Tree Concept

Flutter uses a widget tree where everything is a widget:

```
PersonalFinanceApp
└── MaterialApp
    └── DashboardScreen
        └── Scaffold
            ├── AppBar
            │   └── Text
            └── Center
                └── Column
                    ├── Icon
                    ├── SizedBox
                    ├── Text
                    ├── SizedBox
                    └── Text
```

### Hot Reload vs Hot Restart

- **Hot Reload (r)**: Updates code changes while preserving app state
- **Hot Restart (R)**: Restarts the app completely, losing state

---

## Part 6: Practical Exercises

### Exercise 1: Customize the App

1. Change the app title in the AppBar
2. Modify the welcome message
3. Change the icon color to blue
4. Add your name to the subtitle

### Exercise 2: Add More Content

Add this after the existing Column children:

```dart
const SizedBox(height: 30),
Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(10),
  ),
  child: const Text(
    'Coming Soon: Track your daily expenses and manage your budget effectively!',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 14),
  ),
),
```

### Exercise 3: Experiment with Hot Reload

1. Change colors and see instant updates
2. Modify text content
3. Try changing the icon

---

### Next Lab Preview:

In Lab 2, we'll dive deeper into Flutter widgets and create the dashboard UI with expense/income cards and navigation structure.

---

## Homework Assignment

1. **Customize Your App**: Change the theme color, app title, and welcome message
2. **Experiment**: Try adding different icons and text styles

---

## Resources for Further Learning

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Flutter YouTube Channel](https://www.youtube.com/c/flutterdev)

**Remember:** Don't worry if everything doesn't make perfect sense yet. We'll build upon these concepts in each subsequent lab!
