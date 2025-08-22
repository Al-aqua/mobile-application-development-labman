# Lab 6: Navigation - Personal Finance Tracker

## Objectives

By the end of this lab, students will:

- Understand different types of **navigation** in Flutter
- Learn how to navigate between screens using **Navigator**
- Implement **bottom navigation bar** for app sections
- Create a **transaction detail screen**
- Understand the **navigation stack** concept
- Learn how to **pass data** between screens

---

## Prerequisites

- Completed **Lab 5** (forms and input)
- Understanding of StatefulWidget and setState()
- Familiarity with the Transaction model and form implementation

---

## 1. Understanding Navigation in Flutter

### 1.1 What is Navigation?

Navigation is how users move between different screens (pages) in your app. Think of it like turning pages in a book or switching between tabs in a web browser.

### 1.2 The Navigation Stack

Flutter uses a **stack-based navigation system**. Imagine a stack of cards:

- **Push**: Add a new screen on top of the stack
- **Pop**: Remove the current screen and go back to the previous one

```
┌─────────────────┐
│   Detail Screen │ ← Current screen (top of stack)
├─────────────────┤
│   Home Screen   │ ← Previous screen
├─────────────────┤
│   Login Screen  │ ← Bottom of stack
└─────────────────┘
```

### 1.3 Types of Navigation

#### 1. Push Navigation (Forward)

Moving to a new screen:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

#### 2. Pop Navigation (Back)

Going back to the previous screen:

```dart
Navigator.pop(context);
```

#### 3. Replace Navigation

Replace current screen with a new one:

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

#### 4. Named Routes

Navigate using route names (like URLs):

```dart
Navigator.pushNamed(context, '/details');
```

---

## 2. Basic Navigation Example

Let's start with a simple example:

```dart
// Screen 1
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreen()),
            );
          },
          child: Text('Go to Details'),
        ),
      ),
    );
  }
}

// Screen 2
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Go back
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

## 3. Passing Data Between Screens

### 3.1 Passing Data Forward (Push)

```dart
// From Screen A to Screen B
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(data: 'Hello World'),
  ),
);

// Screen B receives the data
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});
  final String data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Received: $data'),
    );
  }
}
```

### 3.2 Passing Data Back (Pop)

```dart
// Screen B sends data back
Navigator.pop(context, 'Result from Screen B');

// Screen A receives the data
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailScreen()),
);
print('Received back: $result');
```

---

## 4. Bottom Navigation Bar

### 4.1 What is Bottom Navigation Bar?

A bottom navigation bar allows users to switch between different sections of your app. It's like having multiple "tabs" at the bottom of the screen.

### 4.2 Basic Implementation

```dart
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomeScreen(), StatsScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('StatsScreen')));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('HomeScreen')));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('SettingsScreen')));
  }
}
```

---

## 5. Implementing Navigation in Our Finance Tracker

### 5.1 Create the Transaction Detail Screen

First, let's create a screen to show transaction details. Create a new file `lib/screens/transaction_detail_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: transaction.isExpense
                    ? Colors.red.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                transaction.isExpense ? 'EXPENSE' : 'INCOME',
                style: TextStyle(
                  color: transaction.isExpense ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Amount
            Text(
              '${transaction.isExpense ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: transaction.isExpense ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 32),

            // Details Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow(
                      Icons.title,
                      'Title',
                      transaction.title,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      Icons.category,
                      'Category',
                      transaction.category,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      Icons.calendar_today,
                      'Date',
                      DateFormat.yMMMMd().format(transaction.date),
                    ),
                    const Divider(),
                    _buildDetailRow(
                      Icons.access_time,
                      'Time',
                      DateFormat.jm().format(transaction.date),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement edit functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit feature coming soon!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Transaction'),
          content: const Text(
            'Are you sure you want to delete this transaction? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(transaction.id); // Return to previous screen with delete signal
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
```

### 5.2 Create a Statistics Screen

Create a new file `lib/screens/statistics_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const StatisticsScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final totalIncome = transactions
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);

    final totalExpenses = transactions
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);

    final balance = totalIncome - totalExpenses;

    // Group expenses by category
    final Map<String, double> expensesByCategory = {};
    for (var tx in transactions.where((tx) => tx.isExpense)) {
      expensesByCategory[tx.category] =
          (expensesByCategory[tx.category] ?? 0) + tx.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Income',
                    '\$${totalIncome.toStringAsFixed(2)}',
                    Colors.green,
                    Icons.arrow_upward,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Total Expenses',
                    '\$${totalExpenses.toStringAsFixed(2)}',
                    Colors.red,
                    Icons.arrow_downward,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildStatCard(
              'Net Balance',
              '\$${balance.toStringAsFixed(2)}',
              balance >= 0 ? Colors.green : Colors.red,
              balance >= 0 ? Icons.trending_up : Icons.trending_down,
            ),
            const SizedBox(height: 32),

            // Expenses by Category
            const Text(
              'Expenses by Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            if (expensesByCategory.isEmpty)
              const Center(
                child: Text(
                  'No expenses to show',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ...expensesByCategory.entries.map((entry) {
                final percentage = (entry.value / totalExpenses * 100);
                return _buildCategoryRow(
                  entry.key,
                  entry.value,
                  percentage,
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String category, double amount, double percentage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(width: 8),
                Text('${percentage.toStringAsFixed(1)}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 5.3 Create a Settings Screen

Create a new file `lib/screens/settings_screen.dart`:

```dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  String _currency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'john.doe@example.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Preferences Section
          const Text(
            'Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme'),
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                  secondary: const Icon(Icons.dark_mode),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Receive transaction alerts'),
                  value: _notifications,
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                  secondary: const Icon(Icons.notifications),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Currency'),
                  subtitle: Text('Current: $_currency'),
                  leading: const Icon(Icons.attach_money),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showCurrencyDialog();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Actions Section
          const Text(
            'Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Export Data'),
                  subtitle: const Text('Download your transaction data'),
                  leading: const Icon(Icons.download),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Export feature coming soon!')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Backup & Sync'),
                  subtitle: const Text('Sync data across devices'),
                  leading: const Icon(Icons.cloud_sync),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Backup feature coming soon!')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('About'),
                  subtitle: const Text('App version and info'),
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showAboutDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Currency'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['USD', 'EUR', 'GBP', 'JPY'].map((currency) {
              return RadioListTile<String>(
                title: Text(currency),
                value: currency,
                groupValue: _currency,
                onChanged: (value) {
                  setState(() {
                    _currency = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Personal Finance Tracker',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.account_balance_wallet),
      children: [
        const Text('A simple app to track your personal finances.'),
        const SizedBox(height: 16),
        const Text('Built with Flutter for educational purposes.'),
      ],
    );
  }
}
```

### 5.4 Update the Main App Structure

Now let's update our main app to use bottom navigation. Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/dashboard_screen.dart';
import 'models/transaction.dart';
import 'screens/statistics_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Sample transaction data
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Grocery Shopping',
      amount: 45.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Food',
      isExpense: true,
    ),
    Transaction(
      id: 't2',
      title: 'Monthly Salary',
      amount: 1500.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: 'Salary',
      isExpense: false,
    ),
    Transaction(
      id: 't3',
      title: 'New Headphones',
      amount: 99.99,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'Shopping',
      isExpense: true,
    ),
  ];

  void _addTransaction(
    String title,
    double amount,
    String category,
    bool isExpense,
  ) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: category,
      isExpense: isExpense,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(
        transactions: _transactions,
        onAddTransaction: _addTransaction,
        onDeleteTransaction: _deleteTransaction,
      ),
      StatisticsScreen(transactions: _transactions),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
```

and update the `DashboardScreen` in `lib/dashboard_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/models/transaction.dart';
import 'package:personal_finance_tracker/screens/transaction_detail_screen.dart';
import 'package:personal_finance_tracker/widgets/add_transaction_form.dart';
import 'package:personal_finance_tracker/widgets/transaction_list.dart';

class DashboardScreen extends StatefulWidget {
  final List<Transaction> transactions;
  final Function(String, double, String, bool) onAddTransaction;
  final Function(String) onDeleteTransaction;

  const DashboardScreen({
    super.key,
    required this.transactions,
    required this.onAddTransaction,
    required this.onDeleteTransaction,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedCategory;
  String _searchQuery = '';

  List<Transaction> get _filteredTransactions {
    var filtered = widget.transactions;

    if (_selectedCategory != null) {
      filtered = filtered
          .where((tx) => tx.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (tx) => tx.title.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return AddTransactionForm(onAddTransaction: widget.onAddTransaction);
      },
    );
  }

  void _navigateToTransactionDetail(Transaction transaction) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailScreen(transaction: transaction),
      ),
    );

    // If result is a transaction ID, it means user wants to delete it
    if (result != null && result is String) {
      widget.onDeleteTransaction(result);
    }
  }

  double get _totalIncome {
    return widget.transactions
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get _totalExpenses {
    return widget.transactions
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get _balance {
    return _totalIncome - _totalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: const Icon(Icons.account_balance_wallet),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            BalanceOverviewCard(balance: _balance),
            const SizedBox(height: 24),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Income',
                    amount: _totalIncome,
                    icon: Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SummaryCard(
                    title: 'Expenses',
                    amount: _totalExpenses,
                    icon: Icons.arrow_downward,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Filter and Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String?>(
                  hint: const Text('All'),
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('All Categories'),
                    ),
                    ...{...widget.transactions.map((tx) => tx.category)}.map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Transaction List
            SizedBox(
              height: 400,
              child: TransactionList(
                transactions: _filteredTransactions,
                onDeleteTransaction: widget.onDeleteTransaction,
                onTransactionTap: _navigateToTransactionDetail,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BalanceOverviewCard extends StatelessWidget {
  final double balance;

  const BalanceOverviewCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Balance',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: balance >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

```

### 5.5 Update the Transaction List Widget

Update your `TransactionList` widget to handle taps. In `lib/widgets/transaction_list.dart`, modify the `TransactionList` class:

```dart
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onDeleteTransaction;
  final Function(Transaction)? onTransactionTap;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onDeleteTransaction,
    this.onTransactionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No transactions yet!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        return TransactionCard(
          transaction: transactions[index],
          onDelete: onDeleteTransaction,
          onTap: onTransactionTap,
        );
      },
    );
  }
}
```

And update the `TransactionCard` class:

```dart
class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function(String) onDelete;
  final Function(Transaction)? onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: ListTile(
        onTap: onTap != null ? () => onTap!(transaction) : null,
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: transaction.isExpense
              ? Colors.red.shade100
              : Colors.green.shade100,
          child: Icon(
            getCategoryIcon(transaction.category),
            color: transaction.isExpense ? Colors.red : Colors.green,
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${transaction.category} • ${DateFormat.yMMMd().format(transaction.date)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${transaction.isExpense ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: transaction.isExpense ? Colors.red : Colors.green,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: () => onDelete(transaction.id),
            ),
          ],
        ),
      ),
    );
  }

  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'utilities':
        return Icons.receipt;
      case 'salary':
        return Icons.work;
      case 'gift':
        return Icons.card_giftcard;
      default:
        return Icons.attach_money;
    }
  }
}
```

---

## 6. Key Navigation Concepts

### 6.1 Navigation Stack

- **Push**: Add new screen on top
- **Pop**: Remove current screen and go back
- **Replace**: Replace current screen with new one

### 6.2 Passing Data

- **Forward**: Pass data when navigating to a new screen
- **Backward**: Return data when going back

### 6.3 Bottom Navigation

- Switches between different sections of the app
- Maintains separate navigation stacks for each tab
- Uses `setState()` to change the current index

---

## 7. Exercises

### Exercise 1: Add Navigation Animation

Customize the navigation animation:

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => TransactionDetailScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
        ),
        child: child,
      );
    },
  ),
);
```

### Exercise 2: Add a Search Screen

Create a dedicated search screen accessible from the app bar:

```dart
// Add to AppBar actions
actions: [
  IconButton(
    icon: const Icon(Icons.search),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    },
  ),
],
```

### Exercise 3: Implement Edit Transaction

Add edit functionality to the transaction detail screen that navigates to an edit form.

---

## 8. Common Issues and Troubleshooting

### 8.1 Navigator Context Issues

**Problem**: `Navigator.of(context)` returns null
**Solution**: Make sure you're using the correct BuildContext

### 8.2 Bottom Navigation Not Updating

**Problem**: Tapping bottom nav items doesn't change screens
**Solution**: Make sure you're calling `setState()` when changing `_currentIndex`

### 8.3 Data Not Passing Between Screens

**Problem**: Data is null in the destination screen
**Solution**: Check that you're passing data correctly in the constructor

### 8.4 Back Button Not Working

**Problem**: Custom back button doesn't work
**Solution**: Use `Navigator.pop(context)` or `Navigator.of(context).pop()`

---

## 9. Key Takeaways

- **Navigation** is how users move between screens in your app
- **Navigator.push()** goes forward, **Navigator.pop()** goes back
- **Bottom Navigation Bar** organizes your app into sections
- **Pass data** between screens using constructors and return values
- **setState()** is needed to update the UI when navigation state changes
- Always handle **null cases** when receiving data from navigation

---

## Next Steps

In the next lab, we'll implement **local storage** using SQLite to persist our transaction data. We'll learn how to save, retrieve, and manage data locally on the device so that transactions don't disappear when the app is closed.
