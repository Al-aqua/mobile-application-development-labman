# **Chapter 1: Introduction to Flutter and Setting Up the Environment**

---

## **Objective**

By the end of this chapter, students will:

1. Understand what Flutter is and why it’s used for mobile app development.
2. Set up their development environment for Flutter.
3. Create and run their first Flutter app.
4. Understand the basic structure of a Flutter project.

---

## **1.1 What is Flutter?**

Flutter is an open-source UI software development kit (SDK) created by Google. It allows developers to build **natively compiled applications** for mobile (iOS and Android), web, and desktop from a **single codebase**.

### **Why Use Flutter?**

- **Cross-Platform Development**: Write one codebase and deploy it on multiple platforms.
- **Fast Development**: Hot reload allows you to see changes instantly.
- **Beautiful UI**: Flutter provides a rich set of customizable widgets.
- **High Performance**: Flutter apps are compiled to native machine code, ensuring smooth performance.

---

## **1.2 Setting Up the Development Environment**

### **Step 1: Install Flutter SDK**

1. Go to the official Flutter website: [https://flutter.dev](https://flutter.dev).
2. Download the Flutter SDK for your operating system (Windows, macOS, or Linux).
3. Extract the downloaded file to a location on your computer (e.g., `C:\flutter` on Windows).

### **Step 2: Add Flutter to Your System Path**

- **Windows**:
  1. Open the Start menu and search for "Environment Variables."
  2. Under "System Variables," find the `Path` variable and click "Edit."
  3. Add the path to the `bin` folder inside your Flutter directory (e.g., `C:\flutter\bin`).
- **macOS/Linux**:
  1. Open the terminal and edit your shell configuration file (e.g., `.bashrc`, `.zshrc`).
  2. Add the following line:
     ```bash
     export PATH="$PATH:/path-to-flutter/bin"
     ```
  3. Save the file and run `source ~/.bashrc` or `source ~/.zshrc`.

### **Step 3: Verify Installation**

1. Open a terminal or command prompt.
2. Run the following command:
   ```bash
   flutter doctor
   ```
3. This command checks your environment and lists any missing dependencies. Follow the instructions to fix any issues (e.g., installing Android Studio or Xcode).

> You can find a detailed guide on how to install Flutter [here](https://flutter.dev/docs/get-started/install).

---

### **Step 4: Install an IDE**

Flutter works well with the following IDEs:

- **Android Studio**:
  1. Download and install Android Studio from [https://developer.android.com/studio](https://developer.android.com/studio).
  2. Install the Flutter and Dart plugins:
     - Go to **File > Settings > Plugins**.
     - Search for "Flutter" and click "Install."
     - The Dart plugin will be installed automatically.
- **VS Code**:
  1. Download and install Visual Studio Code from [https://code.visualstudio.com](https://code.visualstudio.com).
  2. Install the Flutter and Dart extensions:
     - Open the Extensions view (`Ctrl+Shift+X` or `Cmd+Shift+X`).
     - Search for "Flutter" and click "Install."

---

### **Step 5: Set Up an Emulator or Physical Device**

- **Android Emulator**:
  1. Open Android Studio and go to **Tools > Device Manager**.
  2. Click "Create Device" and select a phone model.
  3. Follow the steps to configure the emulator and start it.
- **iOS Simulator** (macOS only):
  1. Install Xcode from the Mac App Store.
  2. Open Xcode and go to **Preferences > Locations** to set the Command Line Tools.
  3. Run the iOS Simulator from Xcode or use the terminal:
     ```bash
     open -a Simulator
     ```
- **Physical Device**:
  1. Enable Developer Mode on your phone.
  2. Connect your phone to your computer via USB.
  3. Run `flutter devices` to ensure the device is recognized.

---

## **1.3 Creating Your First Flutter App**

### **Step 1: Create a New Flutter Project**

1. Open a terminal or command prompt.
2. Run the following command:
   ```bash
   flutter create personal_finance_tracker
   ```
3. Navigate to the project directory:
   ```bash
   cd personal_finance_tracker
   ```

### **Step 2: Open the Project in Your IDE**

- Open the `personal_finance_tracker` folder in Android Studio or VS Code.

### **Step 3: Run the App**

1. Start your emulator or connect a physical device.
2. Run the following command in the terminal:
   ```bash
   flutter run
   ```
3. The default Flutter app (a counter app) will appear on your device or emulator.

---

## **1.4 Understanding the Flutter Project Structure**

Here’s an overview of the key files and folders in a Flutter project:

- **`lib/`**: This is where your app’s Dart code lives.
  - **`main.dart`**: The entry point of your Flutter app.
- **`pubspec.yaml`**: The configuration file for your project. It lists dependencies, assets, and metadata.
- **`android/` and `ios/`**: Platform-specific code for Android and iOS.
- **`test/`**: Contains test files for your app.

---

## **1.5 Modifying the Default App**

### **Step 1: Open `lib/main.dart`**

This file contains the default Flutter app code.

### **Step 2: Replace the Code**

Replace the default code with the following:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Finance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Text(
          'Welcome to the Personal Finance Tracker!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
```

### **Step 3: Run the App**

1. Save the file.
2. Run the app again using `flutter run`.
3. You should see a simple app with a title and a welcome message.

---

## **1.6 Summary**

In this chapter, you:

1. Learned what Flutter is and why it’s used.
2. Set up your development environment.
3. Created and ran your first Flutter app.
4. Modified the default app to display a custom message.

---

## **Homework**

1. Experiment with changing the app’s theme (e.g., change the primary color).
2. Add a new widget (e.g., a button) to the `HomeScreen`.
3. Do a research about **dart** syntax, data types and null safety

---
