# Lab 5: Forms and Input - Personal Finance Tracker

## Objectives

By the end of this lab, students will:

- Understand **TextEditingController** and how to manage form input
- Learn **form validation** techniques in Flutter
- Implement **dropdown menus** for category selection
- Add **date picker** functionality
- Create a **complete transaction entry form** with proper validation
- Understand the difference between **controlled** and **uncontrolled** inputs

---

## Prerequisites

- Completed **Lab 4** (basic state management)
- Understanding of `setState()` and StatefulWidget
- Familiarity with the Transaction model

---

## 1. Understanding Form Input in Flutter

In Flutter, there are **two main ways** to handle form input:

### 1.1 Using onChanged (Uncontrolled)

```dart
String title = '';

TextField(
  decoration: InputDecoration(labelText: 'Title'),
  onChanged: (value) => title = value,
)
```

- The widget **doesn't control** the input value
- We just **listen** to changes and store them in a variable

### 1.2 Using TextEditingController (Controlled)

```dart
final TextEditingController _titleController = TextEditingController();

TextField(
  controller: _titleController,
  decoration: InputDecoration(labelText: 'Title'),
)

// To get the value:
String title = _titleController.text;
```

- The widget **controls** the input value
- We can **read, write, and clear** the input programmatically
- **Better for validation** and complex forms

---

## 2. TextEditingController Deep Dive

### 2.1 What is TextEditingController?

A `TextEditingController` is like a **remote control** for a text field. It allows you to:

- **Read** the current text: `controller.text`
- **Set** the text: `controller.text = 'new value'`
- **Clear** the text: `controller.clear()`
- **Listen** to changes: `controller.addListener(() => print(controller.text))`

### 2.2 Basic Usage

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // IMPORTANT: Always dispose controllers to prevent memory leaks
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        ElevatedButton(
          onPressed: () {
            print('Name: ${_nameController.text}');
            _nameController.clear(); // Clear the field
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
```

**Important**: Always call `dispose()` on controllers to prevent memory leaks!

---

## 3. Form Validation

### 3.1 Manual Validation

```dart
String? _validateTitle(String? value) {
  if (value == null || value.isEmpty) {
    return 'Title is required';
  }
  if (value.length < 3) {
    return 'Title must be at least 3 characters';
  }
  return null; // null means no error
}
```

### 3.2 Using Form Widget with GlobalKey

Flutter provides a `Form` widget that makes validation easier:

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField( // Note: TextFormField, not TextField
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, proceed
                print('Title: ${_titleController.text}');
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

---

## 4. Input Widgets Overview

### 4.1 TextField vs TextFormField

- **TextField**: Basic text input widget
- **TextFormField**: TextField + built-in validation support

### 4.2 Common Input Types

```dart
// Text input
TextFormField(
  decoration: InputDecoration(labelText: 'Name'),
)

// Number input
TextFormField(
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Amount'),
)

// Email input
TextFormField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(labelText: 'Email'),
)

// Password input
TextFormField(
  obscureText: true,
  decoration: InputDecoration(labelText: 'Password'),
)

// Multiline input
TextFormField(
  maxLines: 3,
  decoration: InputDecoration(labelText: 'Description'),
)
```

---

## 5. Implementing the Complete Transaction Form

Let's create a proper transaction form with validation. Create a new file `lib/widgets/add_transaction_form.dart`:

```dart
import 'package:flutter/material.dart';

class AddTransactionForm extends StatefulWidget {
  final Function(String, double, String, bool) onAddTransaction;

  const AddTransactionForm({super.key, required this.onAddTransaction});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text inputs
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Form state variables
  String _selectedCategory = 'Food';
  bool _isExpense = true;

  // Available categories
  final List<String> _categories = [
    'Food',
    'Shopping',
    'Transport',
    'Entertainment',
    'Utilities',
    'Salary',
    'Gift',
    'Other',
  ];

  @override
  void dispose() {
    // Clean up controllers
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Method to submit the form
  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return; // Form is not valid
    }

    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    widget.onAddTransaction(title, amount, _selectedCategory, _isExpense);

    Navigator.of(context).pop(); // Close the form
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Form title
            const Text(
              'Add New Transaction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Title input
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Transaction Title',
                hintText: 'e.g., Grocery Shopping',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                if (value.length < 3) {
                  return 'Title must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Amount input
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: '0.00',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null) {
                  return 'Please enter a valid number';
                }
                if (amount <= 0) {
                  return 'Amount must be greater than 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Category dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Income/Expense toggle
            Card(
              child: SwitchListTile(
                title: Text(_isExpense ? 'Expense' : 'Income'),
                subtitle: Text(
                  _isExpense ? 'Money going out' : 'Money coming in',
                ),
                value: _isExpense,
                onChanged: (value) {
                  setState(() {
                    _isExpense = value;
                  });
                },
                secondary: Icon(
                  _isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                  color: _isExpense ? Colors.red : Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Add Transaction',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
```

---

## 6. Updating the Dashboard to Use the New Form

Now let's update the `FinanceDashboard` to use our new form, update the `_FinanceDashboardState` class:

```dart
class _FinanceDashboardState extends State<FinanceDashboard> {
  String? _selectedCategory;

  // Add this method to the class
  List<Transaction> get _filteredTransactions {
    var filtered = _transactions;

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

  String _searchQuery = '';

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
    Transaction(
      id: 't4',
      title: 'Restaurant Dinner',
      amount: 35.50,
      date: DateTime.now().subtract(const Duration(days: 7)),
      category: 'Food',
      isExpense: true,
    ),
  ];

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

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

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return AddTransactionForm(onAddTransaction: _addTransaction);
      },
    );
  }

  // Calculate totals for summary cards
  double get _totalIncome {
    return _transactions
        .where((tx) => !tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get _totalExpenses {
    return _transactions
        .where((tx) => tx.isExpense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get _balance {
    return _totalIncome - _totalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            const Text(
              'My Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Balance Card
            BalanceOverviewCard(balance: _balance),
            const SizedBox(height: 24),

            // Income & Expenses Row
            const Text(
              'Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Income and Expense cards
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
                SizedBox(width: 16),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search transactions...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            // Recent Transactions Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String?>(
                  hint: const Text('All Categories'),
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
                    ...{..._transactions.map((tx) => tx.category)}.map(
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
              height: 400, // Fixed height for the list
              child: GroupedTransactionList(
                transactions: _filteredTransactions,
                onDeleteTransaction: _deleteTransaction,
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
```

---

## 7. Updating the Balance Overview Card

Update the `BalanceOverviewCard` to accept dynamic balance data. In your existing card widget:

```dart
class BalanceOverviewCard extends StatelessWidget {
  const BalanceOverviewCard({super.key, required this.balance});
  final double balance;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current Balance',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_upward, size: 14, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        '2.5%',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '\$400.00',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
```

---

## 8. Form Validation Best Practices

### 8.1 Common Validation Rules

```dart
// Required field
String? validateRequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

// Email validation
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

// Number validation
String? validateAmount(String? value) {
  if (value == null || value.isEmpty) {
    return 'Amount is required';
  }
  final amount = double.tryParse(value);
  if (amount == null) {
    return 'Please enter a valid number';
  }
  if (amount <= 0) {
    return 'Amount must be greater than 0';
  }
  return null;
}
```

### 8.2 Real-time Validation

You can validate as the user types:

```dart
TextFormField(
  controller: _titleController,
  decoration: InputDecoration(labelText: 'Title'),
  validator: validateRequired,
  autovalidateMode: AutovalidateMode.onUserInteraction,
)
```

---

## 9. Exercises

### Exercise 1: Add Amount Formatting

Format the amount input to show currency as the user types:

```dart
// Add this package: flutter pub add intl

TextFormField(
  controller: _amountController,
  decoration: const InputDecoration(
    labelText: 'Amount',
    prefixText: '\$ ',
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  onChanged: (value) {
    // Format the input as currency
    if (value.isNotEmpty) {
      final amount = double.tryParse(value);
      if (amount != null) {
        final formatted = NumberFormat.currency(symbol: '').format(amount);
        // Update controller without triggering onChanged again
      }
    }
  },
)
```

### Exercise 2: Add Form Reset

Add a "Clear Form" button that resets all fields:

```dart
void _clearForm() {
  _titleController.clear();
  _amountController.clear();
  setState(() {
    _selectedCategory = 'Food';
    _isExpense = true;
  });
}

// Add this button next to the submit button
OutlinedButton(
  onPressed: _clearForm,
  child: const Text('Clear Form'),
)
```

---

## 10. Common Issues and Troubleshooting

### 10.1 Controller Memory Leaks

**Problem**: Not disposing controllers
**Solution**: Always call `dispose()` in the State class

### 10.2 Form Not Validating

**Problem**: Using `TextField` instead of `TextFormField`
**Solution**: Use `TextFormField` with a `Form` widget

### 10.3 Keyboard Covering Input

**Problem**: Bottom sheet doesn't adjust for keyboard
**Solution**: Use `MediaQuery.of(context).viewInsets.bottom` in padding

### 10.4 Date Picker Not Updating

**Problem**: Forgetting to call `setState()` after date selection
**Solution**: Always wrap state changes in `setState()`

---

## 11. Key Takeaways

- **TextEditingController** gives you full control over text inputs
- **Form validation** prevents bad data from entering your app
- **TextFormField** + **Form** widget = easy validation
- **DropdownButtonFormField** for selecting from predefined options
- **Date pickers** require `showDatePicker()` and state management
- Always **dispose controllers** to prevent memory leaks
- **Real-time validation** improves user experience

---

## Next Steps

In the next lab, we'll implement **navigation** between different screens, create a transaction detail view, and add a bottom navigation bar to organize our app into multiple sections.
