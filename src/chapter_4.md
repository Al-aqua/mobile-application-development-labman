# **Lab 4: State Management - Personal Finance Tracker**

## **Objectives**

By the end of this lab, students will:

- Understand the difference between **Stateless** and **Stateful** widgets
- Learn how to use the **`setState()`** method to update the UI
- Implement **adding and removing transactions** in the finance tracker
- See how **state changes** are reflected in the app instantly

---

## **Prerequisites**

- Completed **Lab 3** (transaction list implementation)
- Basic understanding of Dart classes and Flutter widgets
- Familiarity with the `Transaction` model from Lab 3

---

## **1. Understanding State in Flutter**

In Flutter, **state** means **data that can change over time**.

- If your widget **never changes** after it’s built → use a **StatelessWidget**
- If your widget **needs to change** (e.g., after a button press, form submission, or API call) → use a **StatefulWidget**

---

### **1.1 StatelessWidget**

A **StatelessWidget** is **immutable** — once it’s built, it cannot change its data.

Example:

```dart
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello, I never change!');
  }
}
```

- The text `"Hello, I never change!"` will **always** be the same.
- If you want to change it, you must **rebuild the whole widget** from outside.

---

### **1.2 StatefulWidget**

A **StatefulWidget** can **change its data** while the app is running.

Example:

```dart
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++; // Change the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $counter'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increase'),
        ),
      ],
    );
  }
}
```

Here’s what happens:

1. The widget starts with `counter = 0`
2. When the button is pressed, `_incrementCounter()` is called
3. Inside `_incrementCounter()`, we call **`setState()`**
4. `setState()` tells Flutter: **"Hey, my data changed — rebuild the UI"**
5. Flutter rebuilds the widget with the new value

---

## **2. The `setState()` Method**

`setState()` is **the simplest way** to update the UI in Flutter.

**Syntax:**

```dart
setState(() {
  // Change your variables here
});
```

**Rules for using `setState()`**:

- Only call it **inside a StatefulWidget’s State class**
- Keep the code inside `setState()` **short** — just update variables
- Flutter will **rebuild only the widget** where the state changed, not the whole app

---

## **3. Applying State Management to Our Finance Tracker**

In **Lab 3**, we had a **hardcoded list** of transactions.  
Now, we’ll make it **dynamic** — so students can **add and remove transactions**.

---

### **3.1 Updating the Dashboard to be Stateful**

In `main.dart`, make sure the `FinanceDashboard` is a `StatefulWidget`:

```dart
class FinanceDashboard extends StatefulWidget {
  const FinanceDashboard({super.key});

  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}
```

---

### **3.2 Adding State Variables**

Inside `_FinanceDashboardState`, we are storing our transactions in a **list**:

```dart
class _FinanceDashboardState extends State<FinanceDashboard> {
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
```

---

### **3.3 Adding a New Transaction**

We’ll create a method `_addTransaction()` in `_FinanceDashboardState`:

```dart
  void _addTransaction(String title, double amount, String category, bool isExpense) {
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
```

Note: We call `setState()` inside the method to update the UI as soon as we add a new transaction.

---

### **3.4 Removing a Transaction**

We already had this in Lab 3, but here’s the method again:

```dart
  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }
```

Note: removeWhere() is a **built-in method** in Dart that removes all elements
from a list that match a condition.

---

## **4. Creating a Simple Add Transaction Form**

We’ll make a **popup form** when the user taps the **Floating Action Button**.

---

### **4.1 The Form Widget**

Add this method inside `_FinanceDashboardState`:

```dart
  void _startAddTransaction(BuildContext context) {
    String title = '';
    String category = '';
    String amountStr = '';
    bool isExpense = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) => amountStr = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) => category = value,
              ),
              SwitchListTile(
                title: const Text('Is Expense?'),
                value: isExpense,
                onChanged: (value) {
                  setState(() {
                    isExpense = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (title.isEmpty || amountStr.isEmpty || category.isEmpty) {
                    return;
                  }
                  _addTransaction(
                    title,
                    double.parse(amountStr),
                    category,
                    isExpense,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        );
      },
    );
  }
```

---

### **4.2 Connecting the Floating Action Button**

In `DashboardScreen`, update the FAB:

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () => _startAddTransaction(context),
  tooltip: 'Add Transaction',
  child: const Icon(Icons.add),
),
```

But since the FAB is in `DashboardScreen` and `_startAddTransaction` is in `FinanceDashboard`,  
we can **move the FAB into FinanceDashboard** for simplicity in this lab.

---

## **5. Final FinanceDashboard with State**

Here’s the **simplified version**:

```dart
class FinanceDashboard extends StatefulWidget {
  const FinanceDashboard({super.key});

  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
  final List<Transaction> _transactions = [];

  void _addTransaction(String title, double amount, String category, bool isExpense) {
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

  void _startAddTransaction(BuildContext context) {
    String title = '';
    String category = '';
    String amountStr = '';
    bool isExpense = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) => amountStr = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) => category = value,
              ),
              SwitchListTile(
                title: const Text('Is Expense?'),
                value: isExpense,
                onChanged: (value) {
                  setState(() {
                    isExpense = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (title.isEmpty || amountStr.isEmpty || category.isEmpty) {
                    return;
                  }
                  _addTransaction(
                    title,
                    double.parse(amountStr),
                    category,
                    isExpense,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BalanceOverviewCard(),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Income',
                    amount: 0,
                    icon: Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SummaryCard(
                    title: 'Expenses',
                    amount: 0,
                    icon: Icons.arrow_downward,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: TransactionList(
                transactions: _transactions,
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

## **6. Key Takeaways**

- **StatelessWidget** → UI never changes after it’s built
- **StatefulWidget** → UI can change when data changes
- **`setState()`** → tells Flutter to rebuild the widget with new data
- Keep `setState()` **short** — only update variables inside it
- State is stored in the **State class**, not in the widget itself

---

## **7. Exercises**

1. **Exercise 1:** Add a validation message if the user enters a negative amount.
2. **Exercise 2:** Update the **Income** and **Expenses** summary cards to calculate totals from `_transactions`.
3. **Exercise 3:** Sort transactions so the newest appears first.

---
