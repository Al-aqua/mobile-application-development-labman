# **Course Outline: Mobile Application Development with Flutter**

# **Lab 1: Introduction to Flutter and Setting Up the Environment**

- **Objective**: Familiarize students with Flutter, Dart, and the development environment.
- **Topics Covered**:
  - What is Flutter? Why use it for mobile development?
  - Installing Flutter SDK and setting up Android Studio/VS Code.
  - Creating a new Flutter project.
  - Overview of the Flutter project structure.
  - Running the app on an emulator or physical device.
- **Practical Task**:
  - Create a simple "Hello World" app.
  - Customize the app's theme (e.g., change colors, fonts).

---

## **Lab 2: Building the Basic UI for the Finance Tracker**

- **Objective**: Teach students how to build a basic user interface using Flutter widgets.
- **Topics Covered**:
  - Introduction to Flutter widgets (StatelessWidget, Scaffold, AppBar, etc.).
  - Layout basics: Column, Row, Container, ListView.
  - Adding input fields (TextField) and buttons (ElevatedButton).
- **Practical Task**:
  - Build a simple UI for the app:
    - A home screen with a title and a button to add a new transaction.
    - A placeholder list for transactions.

---

## **Lab 3: Understanding State Management (Part 1: setState)**

- **Objective**: Introduce state management using `setState` for simple state updates.
- **Topics Covered**:
  - Difference between StatelessWidget and StatefulWidget.
  - Managing state with `setState`.
  - Handling user input with controllers (TextEditingController).
- **Practical Task**:
  - Add functionality to the "Add Transaction" button:
    - Open a modal to input transaction details (e.g., title, amount).
    - Save the transaction and display it in the list.

---

## **Lab 4: Understanding State Management (Part 2: Provider)**

- **Objective**: Introduce `Provider` for more scalable state management.
- **Topics Covered**:
  - Why use `Provider`? Limitations of `setState`.
  - Setting up `Provider` in a Flutter app.
  - Creating and using a ChangeNotifier for managing app state.
- **Practical Task**:
  - Refactor the app to use `Provider` for managing the list of transactions.
  - Add a total balance display that updates dynamically.

---

## **Lab 5: Navigation and Routing**

- **Objective**: Teach students how to navigate between screens in Flutter.
- **Topics Covered**:
  - Using `Navigator` for screen transitions.
  - Passing data between screens.
  - Using named routes for cleaner navigation.
- **Practical Task**:
  - Add a "Transaction Details" screen:
    - Display detailed information about a selected transaction.
    - Navigate back to the home screen.

---

## **Lab 6: Working with RESTful APIs**

- **Objective**: Teach students how to fetch and send data using RESTful APIs.
- **Topics Covered**:
  - Introduction to HTTP requests in Flutter using the `http` package.
  - Fetching data from a REST API.
  - Sending POST requests to save data.
- **Practical Task**:
  - Simulate a backend API for transactions (e.g., using a mock API like JSONPlaceholder or Mockoon).
  - Fetch transactions from the API and display them in the app.
  - Add a feature to save new transactions to the API.

---

## **Lab 7: Local Data Storage with SQLite**

- **Objective**: Teach students how to store and retrieve data locally using SQLite.
- **Topics Covered**:
  - Introduction to local databases and the `sqflite` package.
  - Setting up SQLite in a Flutter app.
  - Performing CRUD operations (Create, Read, Update, Delete).
- **Practical Task**:
  - Save transactions locally in an SQLite database.
  - Load transactions from the database when the app starts.
  - Add a feature to delete a transaction.

---

## **Lab 8: Firebase Integration (Part 1: Authentication)**

- **Objective**: Introduce Firebase and implement user authentication.
- **Topics Covered**:
  - Setting up Firebase for the Flutter app.
  - Adding Firebase Authentication to the app.
  - Implementing email/password login and signup.
- **Practical Task**:
  - Add a login screen to the app.
  - Restrict access to the finance tracker to authenticated users only.

---

## **Lab 9: Firebase Integration (Part 2: Firestore Database)**

- **Objective**: Use Firebase Firestore for cloud-based data storage.
- **Topics Covered**:
  - Introduction to Firestore and its advantages.
  - Setting up Firestore in the Flutter app.
  - Performing CRUD operations with Firestore.
- **Practical Task**:
  - Save transactions to Firestore instead of SQLite.
  - Sync transactions across devices for the same user.

---

## **Lab 10: Finalizing and Deploying the App**

- **Objective**: Teach students how to polish and deploy their app.
- **Topics Covered**:
  - Adding app icons and splash screens.
  - Debugging and testing the app.
  - Building APKs for Android and preparing for iOS deployment.
  - Publishing the app to the Google Play Store (optional).
- **Practical Task**:
  - Finalize the Personal Finance Tracker app.
  - Add finishing touches (e.g., input validation, error handling).
  - Generate a release APK for the app.

---

# **Key Deliverables**

By the end of the course, students will:

1. Understand the basics of Flutter and Dart.
2. Be able to build fully functional mobile apps.
3. Learn state management techniques (`setState` and `Provider`).
4. Work with RESTful APIs and local databases (SQLite).
5. Integrate Firebase for authentication and cloud storage.
6. Deploy their app to a mobile device or app store.

---
