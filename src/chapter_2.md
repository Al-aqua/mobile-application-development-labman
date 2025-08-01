# Lab 2: Widgets and Layout - Personal Finance Tracker

## Objectives

- Understand basic Flutter layout widgets
- Design a dashboard layout with information cards
- Implement a balance overview section
- Create income and expense summary cards

## Prerequisites

- Completed Lab 1
- Working Flutter development environment
- Basic understanding of Dart syntax

## Understanding Flutter Layout Widgets

### 1. Container Widget

The `Container` widget is a convenience widget that combines common painting, positioning, and sizing widgets.

**Key Properties:**

- `child`: The widget inside this container
- `padding`: Empty space inside the container around the child
- `margin`: Empty space outside the container
- `decoration`: Visual styling (borders, shadows, background color)
- `width` and `height`: Size constraints
- `alignment`: How to position the child inside the container

**Example:**

```dart
Container(
  width: 200,
  height: 100,
  margin: EdgeInsets.all(10),
  padding: EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Text('Balance'),
)
```

### 2. Row and Column Widgets

`Row` and `Column` are the primary layout widgets for horizontal and vertical arrangements.

**Key Properties for Both:**

- `children`: List of widgets to display
- `mainAxisAlignment`: How to align children along the main axis (horizontal for Row, vertical for Column)
- `crossAxisAlignment`: How to align children along the cross axis (vertical for Row, horizontal for Column)
- `mainAxisSize`: How much space to take along the main axis (min or max)

**Row Example:**

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Income'),
    Text('\$1,200'),
  ],
)
```

**Column Example:**

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Expenses'),
    Text('\$800'),
    Text('Shopping, Food, Transport'),
  ],
)
```

### 3. Padding Widget

The `Padding` widget adds empty space around its child.

**Key Properties:**

- `padding`: The amount of space to add
- `child`: The widget to pad

**Example:**

```dart
Padding(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Text('Balance Overview'),
)
```

### 4. SizedBox Widget

The `SizedBox` widget is used to create fixed-size spaces or to constrain child widgets.

**Key Properties:**

- `width` and `height`: Fixed dimensions
- `child`: Optional widget to constrain

**Example:**

```dart
// As a spacer:
SizedBox(height: 20)

// To constrain a child:
SizedBox(
  width: double.infinity,
  height: 100,
  child: Card(child: Center(child: Text('Balance'))),
)
```

### 5. Card Widget

The `Card` widget creates a material design card with elevation and rounded corners.

**Key Properties:**

- `child`: The content of the card
- `elevation`: How high the card is raised (affects shadow)
- `shape`: The shape of the card
- `color`: Background color

**Example:**

```dart
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Card Content'),
  ),
)
```

### 6. Expanded and Flexible Widgets

These widgets help distribute available space among children of a Row or Column.

**Expanded** forces the child to take all available space:

```dart
Row(
  children: [
    Expanded(
      child: Container(color: Colors.red, height: 100),
    ),
    Expanded(
      child: Container(color: Colors.blue, height: 100),
    ),
  ],
)
```

**Flexible** allows the child to shrink below its ideal size if needed:

```dart
Row(
  children: [
    Flexible(
      flex: 2,  // Takes 2/3 of available space
      child: Container(color: Colors.red, height: 100),
    ),
    Flexible(
      flex: 1,  // Takes 1/3 of available space
      child: Container(color: Colors.blue, height: 100),
    ),
  ],
)
```

## Implementing the Finance Dashboard

Let's build the finance dashboard step by step:

### 1. Update the `lib/main.dart` File

First, let's modify our `DashboardScreen` class:

```dart
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: const Icon(Icons.account_balance_wallet),
      ),
      body: const FinanceDashboard(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
          debugPrint('Tapped item $index');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Add transaction button pressed');
        },
        tooltip: 'Add Transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 2. Create the Dashboard Layout

Now, let's add the `FinanceDashboard` widget below the `DashboardScreen` class:

```dart
class FinanceDashboard extends StatelessWidget {
  const FinanceDashboard({super.key});

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
          BalanceOverviewCard(),
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
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  title: 'Income',
                  amount: 1250.00,
                  icon: Icons.arrow_upward,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
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
          const SizedBox(height: 8),

          // Placeholder for transactions (will implement in Lab 3)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Your transactions will appear here',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. Create the Balance Overview Card

Add the `BalanceOverviewCard` widget below:

```dart
class BalanceOverviewCard extends StatelessWidget {
  const BalanceOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
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
                      Icon(
                        Icons.arrow_upward,
                        size: 14,
                        color: Colors.green,
                      ),
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
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBalanceDetail(
                  context,
                  Icons.calendar_today,
                  'This Month',
                  '\$1,250.00',
                ),
                _buildBalanceDetail(
                  context,
                  Icons.account_balance_wallet,
                  'This Year',
                  '\$12,500.00',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceDetail(
    BuildContext context,
    IconData icon,
    String label,
    String amount,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Column(
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
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

### 4. Create the Summary Cards

Finally, add the `SummaryCard` widget:

```dart
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'This month',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Understanding the Implementation

Let's break down what we've built:

1. **SingleChildScrollView**: Makes the content scrollable if it's larger than the screen
2. **Column and Row Combinations**: Organizes widgets vertically and horizontally
3. **Card Widgets**: Creates elevated material design cards for information display
4. **Expanded Widgets**: Distributes space evenly in the income/expense row
5. **Container with Decoration**: Adds styling to various elements
6. **SizedBox**: Creates consistent spacing between UI elements

Our dashboard has three main sections:

- A balance overview card at the top
- Income and expense summary cards in the middle
- A placeholder for recent transactions (to be implemented in Lab 3)

## Exercises

### Exercise 1: Add a Savings Goal Card

Create a new card below the income and expense cards to display a savings goal:

```dart
class SavingsGoalCard extends StatelessWidget {
  const SavingsGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Goal progress (70%)
    const double progress = 0.7;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.flag, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Savings Goal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'New Laptop',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('\$700 of \$1,000'),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Add this card to the dashboard by inserting it between the income/expense cards and the recent transactions header:

```dart
// After the income and expense row
const SizedBox(height: 16),
const SavingsGoalCard(),
const SizedBox(height: 24),
```

### Exercise 2: Add Custom Styling to the Balance Card

Enhance the `BalanceOverviewCard` with a gradient background. Modify the card's container:

```dart
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).colorScheme.inversePrimary,
          Theme.of(context).colorScheme.primary.inversePrimary(0.7),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      // ... (existing code)
    ),
  ),
)
```

Remember to update the text colors to white for better contrast:

```dart
const Text(
  'Current Balance',
  style: TextStyle(
    fontSize: 16,
    color: Colors.white,
  ),
),
```

### Exercise 3: Add a Refresh Button

Add a refresh button to the AppBar that will eventually update the dashboard data:

```dart
appBar: AppBar(
  title: const Text('Personal Finance Tracker'),
  backgroundColor: Theme.of(context).colorScheme.primary,
  foregroundColor: Theme.of(context).colorScheme.onPrimary,
  leading: const Icon(Icons.account_balance_wallet),
  actions: [
    IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () {
        debugPrint('Refresh button pressed');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Refreshing data...')),
        );
      },
    ),
  ],
),
```

## Exercises 4: Organize your code

- Move the `DashboardScreen` widget to a new file named `dashboard_screen.dart`.
- Move every widget in the `lib/main.dart` file to its own file in the `lib/widgets/` directory.

## Deliverables

By the end of this lab, you should have:

1. A comprehensive understanding of Flutter layout widgets
2. A functional dashboard with:
   - Balance overview card
   - Income and expense summary cards
   - Layout for recent transactions (placeholder)
   - Optional savings goal card

## Troubleshooting Common Issues

1. **Layout Overflow Errors**: If you see yellow/black stripes on the screen, it means a widget is trying to take more space than available. Use `Expanded`, `Flexible`, or constrain the widget's size.

2. **Text Overflow**: When text is too long for its container, use `overflow: TextOverflow.ellipsis` in TextStyle to show "..." instead of error stripes.

3. **Card Padding Issues**: Remember that Cards already have some built-in padding. If your layout looks off, check if you're adding unnecessary padding.

4. **Colors Not Showing**: When using `Theme.of(context)`, ensure it's not called in a constructor and only within build methods.

5. **Rendering Issues**: If the UI doesn't update as expected, try using Flutter's "Hot Restart" instead of just "Hot Reload".

## Next Steps

In the next lab, we'll implement the transaction list using ListTile widgets and create a custom transaction card design. We'll also learn about scrollable lists and more advanced UI components.
