# **Chapter 2: Building the Basic UI for the Finance Tracker**

---

## **Objective**

By the end of this chapter, students will:

1. Understand the basics of Flutter widgets and how to structure a user interface.
2. Learn how to use common layout widgets like `Column`, `Row`, `Container`, and `ListView`.
3. Build the basic UI for the **Personal Finance Tracker** app, including a home screen with a list of transactions and a button to add new transactions.

---

## **2.1 Introduction to Flutter Widgets**

In Flutter, everything is a **widget**. Widgets are the building blocks of your app's user interface. They describe what the app should look like and how it should behave.

### **Types of Widgets**

1. **StatelessWidget**:
   - A widget that does not change over time.
   - Example: A static text or an icon.
2. **StatefulWidget**:
   - A widget that can change its state during the app's lifecycle.
   - Example: A counter that updates when a button is pressed.

### **Common Widgets**

- **Scaffold**: Provides the basic structure of a screen (e.g., app bar, body, floating action button).
- **AppBar**: A toolbar at the top of the screen.
- **Text**: Displays text.
- **ElevatedButton** : A button with a raised effect.
- **TextButton** : A button with a flat effect.
- **Container**: A box that can hold other widgets and be styled.
- **Column**: Arranges widgets vertically.
- **Row**: Arranges widgets horizontally.
- **ListView**: Displays a scrollable list of items.

---

## **2.2 Designing the Home Screen**

The home screen of the **Personal Finance Tracker** will have:

1. A title in the app bar.
2. A list of transactions (initially empty).
3. A floating action button to add new transactions.

---

## **2.3 Building the Home Screen**

### **Step 1: Update `HomeScreen`**

Open the `lib/main.dart` file and update the `HomeScreen` class to include the basic structure.

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Finance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // Placeholder for the transaction list
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'No transactions added yet!',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new transaction
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### **Explanation**:

1. **`Scaffold`**:
   - Provides the basic structure of the screen.
   - Includes an `AppBar`, a `body`, and a `floatingActionButton`.
2. **`Column`**:
   - Arranges widgets vertically.
   - Used here to display the transaction list and other elements.
3. **`FloatingActionButton`**:
   - A circular button used for primary actions (e.g., adding a transaction).

---

## **2.4 Adding a Transaction List**

### **Step 1: Create a Dummy List of Transactions**

For now, we’ll use a hardcoded list of transactions to display in the app.

Update the `HomeScreen` class:

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of transactions
    final List<Map<String, String>> transactions = [
      {'title': 'Groceries', 'amount': '\$50'},
      {'title': 'Electricity Bill', 'amount': '\$30'},
      {'title': 'Internet', 'amount': '\$20'},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Finance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(transactions[index]['title']!),
                    subtitle: Text('Amount: ${transactions[index]['amount']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new transaction
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### **Explanation**:

1. **`ListView.builder`**:
   - Dynamically builds a scrollable list of items.
   - `itemCount`: The number of items in the list.
   - `itemBuilder`: A function that defines how each item in the list should look.
2. **`Card`**:
   - A material design card widget used to display each transaction.
3. **`ListTile`**:
   - A convenient widget for displaying a title, subtitle, and optional leading/trailing icons.

---

## **2.5 Styling the Transaction List**

Let’s improve the appearance of the transaction list by adding some styling.

Update the `ListTile` widget inside the `ListView.builder`:

```dart
ListTile(
  leading: CircleAvatar(
    radius: 30,
    child: Padding(
      padding: EdgeInsets.all(6),
      child: FittedBox(
        child: Text(transactions[index]['amount']!),
      ),
    ),
  ),
  title: Text(
    transactions[index]['title']!,
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Text('Transaction details here'),
)
```

### **Explanation**:

1. **`CircleAvatar`**:
   - A circular widget used to display an icon or text.
   - Here, it displays the transaction amount.
2. **`FittedBox`**:
   - Ensures the text inside the `CircleAvatar` fits properly.

---

## **2.6 Adding a Placeholder for Empty Transactions**

If there are no transactions, we’ll display a placeholder message.

Update the `body` of the `HomeScreen`:

```dart
body: transactions.isEmpty
    ? Center(
        child: Text(
          'No transactions added yet!',
          style: TextStyle(fontSize: 18),
        ),
      )
    : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(transactions[index]['amount']!),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index]['title']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Transaction details here'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
```

---

## **2.7 Summary**

In this chapter, you:

1. Learned about common Flutter widgets like `Column`, `Row`, `ListView`, and `Card`.
2. Built the basic UI for the **Personal Finance Tracker** app.
3. Displayed a list of transactions using `ListView.builder`.
4. Added a placeholder message for when there are no transactions.

---

## **Homework**

1. Add more dummy transactions to the list and observe how the app handles scrolling.
2. Customize the app’s theme (e.g., change the app bar color or text styles).
3. Add a trailing icon (e.g., a delete button) to each transaction in the list.

---
