class UserProfile {
  final String userId;
  final String email;
  final String fullName;
  final String age;
  final String occupation;
  final String monthlyIncome;
  final String financialGoal;
  final String monthlyBudget;
  final String currency;

  UserProfile({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.age,
    required this.occupation,
    required this.monthlyIncome,
    required this.financialGoal,
    required this.monthlyBudget,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'age': age,
      'occupation': occupation,
      'monthlyIncome': monthlyIncome,
      'financialGoal': financialGoal,
      'monthlyBudget': monthlyBudget,
      'currency': currency,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      age: json['age'] ?? '',
      occupation: json['occupation'] ?? '',
      monthlyIncome: json['monthlyIncome'] ?? '',
      financialGoal: json['financialGoal'] ?? '',
      monthlyBudget: json['monthlyBudget'] ?? '',
      currency: json['currency'] ?? 'USD',
    );
  }
}
