class AuthModel {
  String accessToken;
  String tokenType;
  User user;
  String message;
  int code;

  AuthModel({
    required this.accessToken,
    required this.tokenType,
    required this.user,
    required this.message,
    required this.code,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      user: User.fromJson(json['user']),
      message: json['message'],
      code: json['code'],
    );
  }
}

class User {
  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String createdAt;
  String updatedAt;
  List<Account> accounts;
  List<Budget> budgets;
  List<Goal> goals;
  List<Category> categories;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.accounts,
    required this.budgets,
    required this.goals,
    required this.categories,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var accountList = json['accounts'] as List;
    var budgetList = json['budgets'] as List;
    var goalList = json['goals'] as List;
    var categoryList = json['categories'] as List;

    // Membuat list kategori dari JSON
    List<Category> categories =
        categoryList.map((i) => Category.fromJson(i)).toList();

    // Menambahkan kategori baru di depan list
    categories.insert(
        0,
        Category(
          id: null,
          name: 'all',
          slug: null,
          userId: null,
          description: null,
          createdAt: null,
          updatedAt: null,
        ));

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      accounts: accountList.map((i) => Account.fromJson(i)).toList(),
      budgets: budgetList.map((i) => Budget.fromJson(i)).toList(),
      goals: goalList.map((i) => Goal.fromJson(i)).toList(),
      categories:
          categories, // menggunakan list kategori yang telah dimodifikasi
    );
  }
}

class Account {
  int id;
  int userId;
  String accountName;
  String accountType;
  int balance;
  String createdAt;
  String updatedAt;
  List<Transaction> transactions;

  Account({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.accountType,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
    required this.transactions,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    var transactionList = json['transactions'] as List;
    return Account(
      id: json['id'],
      userId: json['user_id'],
      accountName: json['account_name'],
      accountType: json['account_type'],
      balance: json['balance'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      transactions:
          transactionList.map((i) => Transaction.fromJson(i)).toList(),
    );
  }
}

class Transaction {
  int id;
  int accountId;
  int categoryId;
  int amount;
  String transactionDate;
  String type;
  String description;
  String createdAt;
  String updatedAt;

  Transaction({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.amount,
    required this.transactionDate,
    required this.type,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: int.tryParse(json['id'].toString()) ?? 0,
      accountId: int.tryParse(json['account_id'].toString()) ?? 0,
      categoryId: int.tryParse(json['category_id'].toString()) ?? 0,
      amount: int.tryParse(json['amount'].toString()) ?? 0,
      transactionDate: json['transaction_date'],
      type: json['type'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Budget {
  int id;
  int userId;
  int categoryId;
  String name;
  int amount;
  String dueDate;
  String status;
  String createdAt;
  String updatedAt;
  List<BudgetTransaction> budgetTransactions;
  Category category;

  Budget({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.budgetTransactions,
    required this.category,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    var budgetTransactionList = json['budget_transactions'] as List;
    return Budget(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      name: json['name'],
      amount: json['amount'],
      dueDate: json['due_date'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      budgetTransactions: budgetTransactionList
          .map((i) => BudgetTransaction.fromJson(i))
          .toList(),
      category: Category.fromJson(json['category']),
    );
  }
}

class BudgetTransaction {
  int id;
  int budgetId;
  String transactionDate;
  String description;
  int amount;
  String createdAt;
  String updatedAt;

  BudgetTransaction({
    required this.id,
    required this.budgetId,
    required this.transactionDate,
    required this.description,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BudgetTransaction.fromJson(Map<String, dynamic> json) {
    return BudgetTransaction(
      id: json['id'],
      budgetId: json['budget_id'],
      transactionDate: json['transaction_date'],
      description: json['description'],
      amount: json['amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Goal {
  int id;
  int userId;
  String name;
  int targetAmount;
  int currentAmount;
  String deadline;
  String createdAt;
  String updatedAt;
  List<GoalTransaction> goalTransactions;

  Goal({
    required this.id,
    required this.userId,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.goalTransactions,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    var goalTransactionList = json['goal_transactions'] as List;
    return Goal(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      targetAmount: json['target_amount'],
      currentAmount: json['current_amount'],
      deadline: json['deadline'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      goalTransactions:
          goalTransactionList.map((i) => GoalTransaction.fromJson(i)).toList(),
    );
  }
}

class GoalTransaction {
  int id;
  int goalId;
  int amount;
  String transactionDate;
  String createdAt;
  String updatedAt;

  GoalTransaction({
    required this.id,
    required this.goalId,
    required this.amount,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoalTransaction.fromJson(Map<String, dynamic> json) {
    return GoalTransaction(
      id: json['id'],
      goalId: json['goal_id'],
      amount: json['amount'],
      transactionDate: json['transaction_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  int? userId;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.userId,
    required this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      userId: json['user_id'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
