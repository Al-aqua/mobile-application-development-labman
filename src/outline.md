# Mobile Application Development with Flutter

## Personal Finance Tracker Course Outline

### **Lab 1: Introduction to Flutter and Setting Up the Environment**

**Objectives:**

- Install Flutter SDK and development environment
- Create first Flutter project
- Understand project structure
- Build and run a simple "Hello World" app

**Project Component:**

- Create the base Personal Finance Tracker project
- Set up app name, icon, and basic configuration
- Run the app on emulator/device

**Key Concepts:**

- Flutter architecture overview
- Dart basics
- Hot reload and hot restart
- Project structure (lib, pubspec.yaml, etc.)

---

### **Lab 2: Flutter Widgets and Layout Fundamentals**

**Objectives:**

- Master core widgets: Container, Column, Row, Text, Icon
- Understand layout principles and widget tree
- Create responsive layouts
- Style widgets with colors, padding, and margins

**Project Component:**

- Design the main dashboard UI
- Create expense/income summary cards
- Build basic navigation structure with AppBar and BottomNavigationBar

**Key Concepts:**

- Stateless vs Stateful widgets
- Widget composition
- Layout widgets (Column, Row, Stack, Expanded)
- Styling and theming basics

---

### **Lab 3: Lists and Basic User Interface Components**

**Objectives:**

- Implement ListView and ListTile widgets
- Create static forms and input fields
- Understand basic widget interactions
- Build reusable UI components

**Project Component:**

- Create static transaction list view with mock data
- Build "Add Transaction" form UI (without functionality)
- Design transaction cards/tiles
- Add floating action button (UI only)

**Key Concepts:**

- ListView.builder for dynamic lists
- TextField widgets (without controllers yet)
- Basic form layouts
- UI composition and reusable widgets

---

### **Lab 4: State Management with setState and Controllers**

**Objectives:**

- Understand state management concepts
- Master setState() for local state
- Work with TextEditingController
- Handle form data and user interactions

**Project Component:**

- Connect TextEditingControllers to form fields
- Implement transaction addition with setState
- Add form validation and error handling
- Make the transaction list dynamic

**Key Concepts:**

- StatefulWidget lifecycle
- TextEditingController management
- setState() for updating UI
- Form controllers and data handling
- Input validation

---

### **Lab 5: Advanced State Management with Provider**

**Objectives:**

- Understand limitations of setState
- Implement Provider pattern
- Create data models and services
- Separate business logic from UI

**Project Component:**

- Create Transaction model class
- Implement TransactionProvider for state management
- Refactor existing code to use Provider
- Add category management functionality

**Key Concepts:**

- Provider package setup
- ChangeNotifier and Consumer widgets
- Model classes and data structures
- Separation of concerns

---

### **Lab 6: Navigation and Multi-Screen Apps**

**Objectives:**

- Implement navigation between screens
- Pass data between routes
- Create tabbed interfaces
- Handle back navigation and app lifecycle

**Project Component:**

- Create separate screens: Dashboard, Transactions, Categories, Settings
- Implement bottom navigation
- Add transaction detail screen
- Create settings screen with user preferences

**Key Concepts:**

- Navigator and routing
- MaterialPageRoute and named routes
- Passing data with route arguments
- TabBar and TabBarView

---

### **Lab 7: Local Data Persistence with SQLite**

**Objectives:**

- Set up SQLite database
- Create database schema
- Implement CRUD operations
- Handle database migrations

**Project Component:**

- Create database helper class
- Implement transaction storage and retrieval
- Add data persistence for categories
- Implement search and filtering functionality

**Key Concepts:**

- sqflite package
- Database design and SQL basics
- Async/await and Future handling
- Data access layer pattern

---

### **Lab 8: Working with RESTful APIs**

**Objectives:**

- Understand HTTP requests and responses
- Implement API integration
- Handle network errors and loading states
- Parse JSON data

**Project Component:**

- Integrate currency exchange rate API
- Add expense categorization with external API
- Implement data synchronization
- Add network connectivity checks

**Key Concepts:**

- http package and API calls
- JSON serialization/deserialization
- Error handling and try-catch
- FutureBuilder widget
- Loading indicators and user feedback

---

### **Lab 9: Firebase Integration and Cloud Storage**

**Objectives:**

- Set up Firebase project
- Implement user authentication
- Store data in Firestore
- Handle real-time data updates

**Project Component:**

- Add user registration and login
- Sync transactions to cloud
- Implement multi-device data access
- Add backup and restore functionality

**Key Concepts:**

- Firebase setup and configuration
- Firebase Auth for user management
- Firestore database operations
- StreamBuilder for real-time updates

---

### **Lab 10: App Polish, Testing, and Deployment**

**Objectives:**

- Add app icons and splash screens
- Implement error handling and user feedback
- Write basic unit tests
- Prepare app for deployment

**Project Component:**

- Add data visualization (charts/graphs)
- Implement export functionality (CSV/PDF)
- Add app theming and dark mode
- Create app store-ready build

**Key Concepts:**

- App deployment process
- Testing strategies
- Performance optimization
- User experience best practices

---
