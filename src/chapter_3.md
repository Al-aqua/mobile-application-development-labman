# Lab 3: Lists and UI Components - Personal Finance Tracker

## Objectives

- Understand different types of ListView widgets
- Create a transaction list using ListTile widgets
- Implement a custom transaction card design
- Build a scrollable transaction history list

## Prerequisites

- Completed Lab 2
- Basic understanding of Flutter widgets and layouts
- Familiarity with Dart classes and collections

## Understanding ListView in Flutter

### What is ListView?

ListView is a scrollable list of widgets arranged linearly. It's one of Flutter's most commonly used widgets for displaying a scrollable collection of children.

### Types of ListViews

#### 1. ListView

The basic ListView constructor creates a scrollable, linear array of widgets.

```dart
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)
```

This approach is good for a small, fixed number of children.

#### 2. ListView.builder

Creates a scrollable, linear array of widgets that are built on demand. This is more efficient for long lists because it only builds items that are currently visible.

```dart
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
)
```

Use this when you have a large or infinite list.

#### 3. ListView.separated

Similar to ListView.builder but allows you to specify a separator widget between each item.

```dart
ListView.separated(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
  separatorBuilder: (context, index) {
    return Divider();
  },
)
```

Good for lists where you need visual separation between items.

#### 4. ListView.custom

Provides the most customization options, allowing you to define custom child model objects.

```dart
ListView.custom(
  childrenDelegate: SliverChildBuilderDelegate(
    (context, index) => ListTile(title: Text('Item $index')),
    childCount: 100,
  ),
)
```

Reserved for advanced use cases.

### ListTile Widget

ListTile is a specialized row widget designed for items in a ListView.

**Key Properties:**

- `leading`: Widget to display before the title
- `title`: The primary content of the list item
- `subtitle`: Additional text displayed below the title
- `trailing`: Widget to display after the title
- `onTap`: Callback function when the tile is tapped
- `dense`: Whether to make the tile more compact
- `isThreeLine`: Whether the subtitle should be displayed on a third line

```dart
ListTile(
  leading: Icon(Icons.shopping_cart),
  title: Text('Groceries'),
  subtitle: Text('March 15, 2023'),
  trailing: Text('\$45.00'),
  onTap: () {
    print('Tile tapped!');
  },
)
```

## Implementing the Transaction List

Let's implement the transaction list for our finance tracker app:

### 1. Create a Transaction Model

First, let's create a model to represent a financial transaction. Create a new file `lib/models/transaction.dart`:

```dart
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final bool isExpense;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.isExpense,
  });
}
```

### 2. Create a Transaction List Widget

Now, let's create a widget for the transaction list. Create a new file `lib/widgets/transaction_list.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this package with: flutter pub add intl
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onDeleteTransaction;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.onDeleteTransaction,
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
        );
      },
    );
  }
}
```

### 3. Implement a Custom Transaction Card

Next, let's create a custom card for displaying transactions. Add this class to the `transaction_list.dart` file:

```dart
class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function(String) onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: ListTile(
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

### 4. Update the Main Dashboard

Now let's update our dashboard to include the transaction list. Modify the `FinanceDashboard` class in `main.dart`:

```dart
class FinanceDashboard extends StatefulWidget {
  const FinanceDashboard({super.key});

  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          const Text(
            'My Balance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Balance Card
          const BalanceOverviewCard(),
          const SizedBox(height: 24),

          // Income & Expenses Row
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Income and Expense cards
          const Row(
            children: [
              Expanded(
                child: SummaryCard(
                  title: 'Income',
                  amount: 1250.00,
                  icon: Icons.arrow_upward,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: SummaryCard(
                  title: 'Expenses',
                  amount: 850.00,
                  icon: Icons.arrow_downward,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Transactions Header
          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Transaction List
          SizedBox(
            height: 400, // Fixed height for the list
            child: TransactionList(
              transactions: _transactions,
              onDeleteTransaction: _deleteTransaction,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 5. Add Grouped Transaction List (Advanced)

For a more polished look, let's create a version of the transaction list that groups transactions by date. Create a new file `lib/widgets/grouped_transaction_list.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class GroupedTransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onDeleteTransaction;

  const GroupedTransactionList({
    super.key,
    required this.transactions,
    required this.onDeleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    // Sort transactions by date (newest first)
    final sortedTransactions = List.of(transactions)
      ..sort((a, b) => b.date.compareTo(a.date));

    // Group transactions by date
    final Map<String, List<Transaction>> groupedTransactions = {};

    for (var tx in sortedTransactions) {
      final dateKey = DateFormat.yMMMd().format(tx.date);
      if (!groupedTransactions.containsKey(dateKey)) {
        groupedTransactions[dateKey] = [];
      }
      groupedTransactions[dateKey]!.add(tx);
    }

    // Convert to list of date-transactions pairs
    final groupList = groupedTransactions.entries.toList();

    return ListView.builder(
      itemCount: groupList.length,
      itemBuilder: (ctx, index) {
        final dateKey = groupList[index].key;
        final dateTransactions = groupList[index].value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                dateKey,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            ...dateTransactions.map((tx) {
              return TransactionCard(
                transaction: tx,
                onDelete: onDeleteTransaction,
              );
            }).toList(),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
```

To use this grouped list, replace the `TransactionList` widget in the dashboard with:

```dart
SizedBox(
  height: 400,
  child: GroupedTransactionList(
    transactions: _transactions,
    onDeleteTransaction: _deleteTransaction,
  ),
),
```

## Exercises

### Exercise 1: Implement a Transaction Filter

Add a dropdown button to filter transactions by category:

- Add this at the top of the `_FinanceDashboardState` class

```dart
String? _selectedCategory;

// Add this method to the class
List<Transaction> get _filteredTransactions {
  if (_selectedCategory == null) {
    return _transactions;
  }
  return _transactions.where((tx) => tx.category == _selectedCategory).toList();
}
```

- Add this above the transaction list

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      'Recent Transactions',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
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
```

- Update the `TransactionList` to use filtered transactions

```dart
SizedBox(
  height: 400,
  child: TransactionList(
    transactions: _filteredTransactions,
    onDeleteTransaction: _deleteTransaction,
  ),
),
```

### Exercise 2: Implement a Search Bar

Add a search bar to filter transactions by title:

- Add this to the `_FinanceDashboardState` class

```dart
String _searchQuery = '';
```

- Update the `_filteredTransactions` getter

```dart
List<Transaction> get _filteredTransactions {
  var filtered = _transactions;

  if (_selectedCategory != null) {
    filtered = filtered.where((tx) => tx.category == _selectedCategory).toList();
  }

  if (_searchQuery.isNotEmpty) {
    filtered = filtered.where(
      (tx) => tx.title.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  return filtered;
}
```

- Add this above the `dropdown` filter

```dart
Padding(
  padding: const EdgeInsets.only(bottom: 16),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Search transactions...',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
    ),
    onChanged: (value) {
      setState(() {
        _searchQuery = value;
      });
    },
  ),
),
```

## Common Issues and Troubleshooting

1. **List items not showing**: Ensure your ListView has a defined height or is inside a widget that constrains its height (like Expanded or SizedBox).

2. **Overflow errors in ListTile**: ListTile has a fixed height. For content that may overflow, consider using a custom layout instead.

3. **Performance issues with long lists**: Make sure you're using ListView.builder rather than the default ListView constructor for long lists.

4. **ListView inside Column causing errors**: ListView tries to be infinitely tall inside a Column. Wrap it in a SizedBox with a fixed height or an Expanded widget.

5. **Items disappearing when scrolling**: This might happen if your ListView.builder doesn't properly reuse widgets. Check your itemBuilder function.

## Next Steps

In the next lab, we'll focus on state management techniques in Flutter. We'll learn how to properly manage the state of our app, implement adding and removing transactions, and ensure UI updates correctly reflect these changes.

Don't forget to add the intl package to your project by running:

```
flutter pub add intl
```
