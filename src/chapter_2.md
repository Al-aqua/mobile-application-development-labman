# Lab 2: Flutter Widgets and Layout Fundamentals

## Learning Objectives

By the end of this lab, students will be able to:

- Master core widgets: Container, Column, Row, Text, Icon
- Understand layout principles and widget tree structure
- Create responsive layouts with proper spacing and alignment
- Style widgets with colors, padding, and margins
- Design the main dashboard UI with expense/income summary cards
- Build basic navigation structure with BottomNavigationBar

---

## Prerequisites

- Completed Lab 1: Introduction to Flutter and Setting Up the Environment
- Personal Finance Tracker project created and running
- Basic understanding of Flutter project structure

---

## Part 1: Understanding Core Layout Widgets

### Container Widget

The `Container` widget is one of the most versatile widgets in Flutter. It's like a box that can hold other widgets and be styled.

**Basic Container:**

```dart
Container(
  width: 200,
  height: 100,
  color: Colors.blue,
  child: const Text('Hello Container!'),
)
```

**Styled Container:**

```dart
Container(
  width: 200,
  height: 100,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.blue.shade100,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.blue),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade400,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: const Text('Styled Container!'),
)
```

### Column and Row Widgets

These widgets arrange their children vertically (Column) or horizontally (Row).

**Column Example:**

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    const Text('First Item'),
    const SizedBox(height: 10),
    const Text('Second Item'),
    const SizedBox(height: 10),
    const Text('Third Item'),
  ],
)
```

**Row Example:**

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    const Icon(Icons.home),
    const Icon(Icons.business),
    const Icon(Icons.school),
  ],
)
```

### Alignment Properties

- **MainAxisAlignment**: Controls alignment along the main axis (vertical for Column, horizontal for Row)
  - `center`, `start`, `end`, `spaceBetween`, `spaceAround`, `spaceEvenly`

- **CrossAxisAlignment**: Controls alignment along the cross axis (horizontal for Column, vertical for Row)
  - `center`, `start`, `end`, `stretch`

---

## Part 2: Building the Dashboard UI

### Step 1: Create the Dashboard Layout

Replace your `DashboardScreen` in `lib/main.dart` with:

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
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            WelcomeCard(),
            SizedBox(height: 20),

            // Summary Cards
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SummaryCards(),
            SizedBox(height: 20),

            // Recent Transactions
            Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: RecentTransactionsList(),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 2: Create the Welcome Card Widget

Add this widget after the `DashboardScreen` class:

```dart
class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Track your expenses and manage your budget',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Step 3: Create Summary Cards

Add this widget:

```dart
class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SummaryCard(
            title: 'Income',
            amount: '\$2,500.00',
            icon: Icons.arrow_upward,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SummaryCard(
            title: 'Expenses',
            amount: '\$1,200.00',
            icon: Icons.arrow_downward,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              Icon(
                icon,
                color: color,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Step 4: Create Recent Transactions List

Add this widget:

```dart
class RecentTransactionsList extends StatelessWidget {
  const RecentTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for now
    final transactions = [
      {
        'title': 'Grocery Shopping',
        'amount': '-\$85.50',
        'category': 'Food',
        'icon': Icons.shopping_cart,
        'color': Colors.orange,
      },
      {
        'title': 'Salary',
        'amount': '+\$2,500.00',
        'category': 'Income',
        'icon': Icons.attach_money,
        'color': Colors.green,
      },
      {
        'title': 'Electric Bill',
        'amount': '-\$120.00',
        'category': 'Utilities',
        'icon': Icons.flash_on,
        'color': Colors.blue,
      },
      {
        'title': 'Coffee',
        'amount': '-\$5.25',
        'category': 'Food',
        'icon': Icons.local_cafe,
        'color': Colors.brown,
      },
      {
        'title': 'Gas Station',
        'amount': '-\$45.00',
        'category': 'Transportation',
        'icon': Icons.local_gas_station,
        'color': Colors.red,
      },
    ];

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionTile(
          title: transaction['title'] as String,
          amount: transaction['amount'] as String,
          category: transaction['category'] as String,
          icon: transaction['icon'] as IconData,
          color: transaction['color'] as Color,
        );
      },
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title;
  final String amount;
  final String category;
  final IconData icon;
  final Color color;

  const TransactionTile({
    super.key,
    required this.title,
    required this.amount,
    required this.category,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: amount.startsWith('-') ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Step 5: Test Your Dashboard

Run your app and you should see:

- A gradient welcome card at the top
- Income and expense summary cards
- A list of recent transactions with icons and colors

---

## Part 3: Adding Bottom Navigation

### Step 1: Create the Main App Structure

Replace your `PersonalFinanceApp` class with:

```dart
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
      home: const MainScreen(),
    );
  }
}
```

### Step 2: Create the Main Screen with Bottom Navigation

Add this new class:

```dart
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TransactionsScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
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

### Step 3: Create Placeholder Screens

Add these placeholder screens:

```dart
class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Transactions Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming in Lab 3!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Categories Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming in Lab 5!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Settings Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming in Lab 6!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Part 4: Understanding Widget Composition

### Widget Tree Structure

Your app now has this structure:

```
PersonalFinanceApp
└── MaterialApp
    └── MainScreen
        ├── Scaffold
        │   ├── Body (DashboardScreen)
        │   │   └── Scaffold
        │   │       ├── AppBar
        │   │       └── Padding
        │   │           └── Column
        │   │               ├── WelcomeCard
        │   │               ├── SummaryCards
        │   │               └── RecentTransactionsList
        │   └── BottomNavigationBar
        └── setState() for navigation
```

### Key Layout Concepts

1. **Expanded**: Takes remaining space in Column/Row
2. **Flexible**: Takes space but can be smaller
3. **SizedBox**: Creates fixed spacing
4. **Padding**: Adds space inside widget
5. **Margin**: Adds space outside widget

---

## Part 5: Practical Exercises

### Exercise 1: Customize Summary Cards

1. Add a third summary card for "Balance"
2. Change the colors of the income and expense cards
3. Add more shadow to make cards more prominent

**Hint:** Modify the `SummaryCards` widget to include three cards in a Row.

### Exercise 2: Add More Transaction Categories

1. Add 3 more transaction types to the mock data
2. Create new icons and colors for each category
3. Test the scrolling behavior

### Exercise 3: Style the Bottom Navigation

1. Change the background color of the bottom navigation
2. Modify the selected item color
3. Add different icons for each tab

**Hint:** Use `backgroundColor` and `selectedItemColor` properties.

### Exercise 4: Create a Balance Widget

Add this widget to show the current balance:

```dart
class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          const Text(
            'Current Balance',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$1,300.00',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
```

Add this widget to your dashboard between the welcome card and overview section.

---

## Part 6: Common Layout Patterns

### 1. Card Layout Pattern

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: // Your content here
)
```

### 2. List Item Pattern

```dart
Row(
  children: [
    // Leading icon or image
    Container(/* icon container */),
    const SizedBox(width: 16),

    // Main content
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          // Subtitle
        ],
      ),
    ),

    // Trailing widget (amount, arrow, etc.)
  ],
)
```

### 3. Header Section Pattern

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Section Title',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(height: 10),
    // Section content
  ],
)
```

---

## Part 7: Testing Your Layout

### Hot Reload Practice

1. Change colors in your summary cards
2. Modify text sizes and see immediate changes
3. Add new transaction items to the list
4. Test navigation between tabs

### Responsive Design Check

1. Test on different screen sizes (if available)
2. Check if content scrolls properly
3. Verify that Row widgets don't overflow

---

## Troubleshooting Common Issues

### 1. RenderFlex Overflow Error

**Problem:** "RenderFlex overflowed by X pixels"

**Solution:**

- Use `Expanded` or `Flexible` widgets
- Add `SingleChildScrollView` if needed
- Check Row/Column children sizes

### 2. Widget Size Issues

**Problem:** Container doesn't show up

**Solution:**

- Add width/height or use `double.infinity`
- Ensure parent widget provides constraints
- Check if color is transparent

### 3. Layout Not Centered

**Problem:** Content not centering properly

**Solution:**

- Use `MainAxisAlignment.center` and `CrossAxisAlignment.center`
- Check parent widget constraints
- Use `Center` widget if needed

---

## Homework Assignment

1. **Add a Floating Action Button**: Add a FAB to the Dashboard for adding new transactions
2. **Create a New Summary Card**: Add a "Savings" card with a target amount
3. **Customize Colors**: Create your own color scheme for the app
4. **Add More Transactions**: Create 5 more transaction items with different categories

### Bonus Challenge

Create a "Quick Actions" section with buttons for common actions like:

- Add Income
- Add Expense
- View Reports
- Set Budget

---

## Next Lab Preview

In Lab 3, we'll learn about ListView widgets, forms, and user input components. We'll make the transaction list dynamic and create an "Add Transaction" form.

---

## Key Takeaways

1. **Container** is your Swiss Army knife for styling and layout
2. **Column** and **Row** are fundamental for organizing widgets
3. **Expanded** and **Flexible** help with responsive layouts
4. **Padding** and **Margin** control spacing
5. **Widget composition** creates reusable, maintainable code
6. **Bottom Navigation** provides main app navigation structure

---

## Resources for Further Learning

- [Flutter Layout Cheat Sheet](https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e)
- [Flutter Widget of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- [Material Design Guidelines](https://material.io/design)

**Remember:** Practice is key! Try different combinations of widgets and see how they affect your layout. Don't be afraid to experiment!
