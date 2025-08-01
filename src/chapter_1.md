# Lab 1: Introduction to Flutter - Personal Finance Tracker

## Objectives

- Set up Flutter development environment
- Create your first Flutter application
- Understand basic Flutter concepts and hot reload
- Build the initial shell of your finance tracker app

## Prerequisites

- Basic programming knowledge
- Computer with Windows, macOS, or Linux
- Minimum 8GB RAM recommended
- At least 10GB of free disk space

## Setup Instructions

### 1. Install Flutter SDK

#### For Windows:

1. Download the Flutter SDK from [flutter.dev/docs/get-started/install/windows](https://flutter.dev/docs/get-started/install/windows)
2. Extract the zip file to a location like `C:\src\flutter` (avoid spaces in the path)
3. Add Flutter to your PATH:
   - Search for "Environment Variables" in Windows search
   - Click "Edit the system environment variables"
   - Click "Environment Variables"
   - Under "System variables", find and select "Path"
   - Click "Edit" and add the path to `flutter\bin` directory
   - Click "OK" to save

#### For macOS:

1. Download the Flutter SDK from [flutter.dev/docs/get-started/install/macos](https://flutter.dev/docs/get-started/install/macos)
2. Extract the file to a location like `~/development`
3. Add Flutter to your PATH:
   - Open Terminal
   - Run `nano ~/.zshrc` or `nano ~/.bash_profile` (depending on your shell)
   - Add `export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/flutter/bin"`
   - Save and exit (Ctrl+X, then Y)
   - Run `source ~/.zshrc` or `source ~/.bash_profile`

#### For Linux:

1. Download the Flutter SDK from [flutter.dev/docs/get-started/install/linux](https://flutter.dev/docs/get-started/install/linux)
2. Extract to a location like `~/development/flutter`
3. Add Flutter to your PATH:
   - Run `nano ~/.bashrc`
   - Add `export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/flutter/bin"`
   - Save and exit (Ctrl+X, then Y)
   - Run `source ~/.bashrc`

### 2. Install an IDE

Choose one of the following:

#### Visual Studio Code (Recommended for beginners):

1. Download and install from [code.visualstudio.com](https://code.visualstudio.com/)
2. Open VS Code and install the Flutter extension:
   - Click on Extensions icon on the left sidebar
   - Search for "Flutter"
   - Click "Install" on the Flutter extension by Dart Code

#### Android Studio:

1. Download and install from [developer.android.com/studio](https://developer.android.com/studio)
2. Open Android Studio and install the Flutter plugin:
   - Go to Preferences/Settings > Plugins
   - Search for "Flutter"
   - Click "Install" and restart Android Studio when prompted

### 3. Set up an Emulator or Connect a Physical Device

#### Android Emulator:

1. Open Android Studio
2. Click on "AVD Manager" (Android Virtual Device Manager)
3. Click "Create Virtual Device"
4. Select a phone (like Pixel 8) and click "Next"
5. Download a system image (recommend API 30 or newer) and click "Next"
6. Name your emulator and click "Finish"

#### iOS Simulator (macOS only):

1. Install Xcode from the App Store
2. Open Xcode and accept the license agreement
3. Install additional components if prompted
4. Open Terminal and run `open -a Simulator`

#### Physical Device:

- For Android: Enable Developer Options and USB Debugging on your device
- For iOS: Register as an Apple Developer and set up your device in Xcode

### 4. Verify Installation

1. Open Terminal or Command Prompt
2. Run `flutter doctor`
3. Address any issues that appear with red X marks
4. When most items have green checkmarks, you're ready to proceed

## Creating Your First Flutter App

### 1. Create a New Flutter Project

1. Open Terminal or Command Prompt
2. Navigate to your desired project location
3. Run the following command:
   ```
   flutter create personal_finance_tracker
   ```
4. Wait for the project to be created
5. Navigate into the project directory:
   ```
   cd personal_finance_tracker
   ```

### 2. Explore the Project Structure

Open the project in your IDE and explore the key files:

- `lib/main.dart` - Main entry point of your application
- `pubspec.yaml` - Project configuration and dependencies
- `android/` and `ios/` - Platform-specific code

### 3. Run the Default App

1. Start your emulator or connect your physical device
2. In Terminal/Command Prompt (in your project directory), run:
   ```
   flutter run
   ```
3. Wait for the app to compile and launch
4. You should see the default Flutter counter app

### 4. Understand Hot Reload

1. With the app running, open `lib/main.dart` in your IDE
2. Find the text `'Flutter Demo'` and change it to `'My Finance Tracker'`
3. Save the file
4. Notice how the app updates immediately without restarting - this is hot reload!
5. Try changing the colors or counter text to experiment further

## Building the Finance Tracker Shell

Now that you understand the basics, let's create the initial shell for your finance tracker app.

### 1. Clean the Default App

Replace the entire content of `lib/main.dart` with this simplified code:

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
            Icon(Icons.account_balance_wallet, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Welcome to Your Finance Tracker!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Track your expenses and income',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Save and Run the App

1. Save the file
2. If the app is already running, it will hot reload
3. If not, run `flutter run` in the terminal

### 3. Understand the Code

Let's break down what this code does:

- `void main()` - The entry point of the app that runs our main app widget
- `PersonalFinanceApp` - A StatelessWidget that sets up the MaterialApp
  - `MaterialApp` - Provides the overall structure and theme
  - `title` - The title shown in recent apps on mobile devices
  - `theme` - The color scheme and visual properties
  - `home` - The main widget to display

- `DashboardScreen` - A StatelessWidget that creates our main screen
  - `Scaffold` - Provides the basic material design layout
  - `AppBar` - The top bar with the app title
  - `body` - The main content area

## Lab Exercises

### Exercise 1: Customize the App Theme

Change the primary color to a color of your choice. Try different colors from the `Colors` class, such as `Colors.blue`, `Colors.purple`, or `Colors.teal`.

### Exercise 2: Add an App Icon to the AppBar

Modify the AppBar to include an icon. Add this before the title:

```dart
leading: Icon(Icons.account_balance_wallet),
```

### Exercise 3: Add a Simple Action Button

Add a floating action button that will eventually be used to add transactions:

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Will implement this in future labs
    debugPrint('Button pressed!');
  },
  tooltip: 'Add Transaction',
  child: Icon(Icons.add),
),
```

### Exercise 4: Create a Simple Footer

Add a bottom navigation bar that will be expanded in future labs:

```dart
bottomNavigationBar: BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.pie_chart),
      label: 'Statistics',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ],
  currentIndex: 0,
  onTap: (index) {
    // Will implement navigation in future labs
    debugPrint('Tapped item $index');
  },
),
```

## Deliverables

By the end of this lab, you should have:

1. A working Flutter development environment
2. A basic understanding of Flutter project structure
3. Experience with hot reload
4. A simple app shell for your finance tracker with:
   - Customized app title
   - Basic theme
   - App bar
   - Floating action button
   - Bottom navigation bar

## Troubleshooting Common Issues

1. **Flutter Doctor Shows Errors**: Follow the suggestions provided by the `flutter doctor` command to resolve each issue.

2. **App Won't Run**: Ensure your emulator is running or device is connected and recognized by running `flutter devices`.

3. **Hot Reload Not Working**: Make sure you're saving the file and that there are no syntax errors.

4. **Missing Dependencies**: If you see errors about missing packages, run `flutter pub get` in your project directory.

## Next Steps

In the next lab, we'll expand our app by adding widgets and layouts to create a proper dashboard for our finance tracker.
