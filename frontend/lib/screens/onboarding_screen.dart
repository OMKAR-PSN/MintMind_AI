import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';
import '../models/user_profile.dart';

class OnboardingScreen extends StatefulWidget {
  final String userId;
  final String email;
  final String fullName;

  const OnboardingScreen({
    super.key,
    required this.userId,
    required this.email,
    required this.fullName,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late TextEditingController _ageController;
  late TextEditingController _courseController;
  late TextEditingController _monthlyAllowanceController;
  late TextEditingController _monthlyBudgetController;
  late TextEditingController _savingsGoalController;
  late TextEditingController _partTimeIncomeController;

  String _selectedFinancialGoal = 'Save for Future';
  String _selectedCurrency = 'USD';
  String _selectedExpenseCategory = 'Food & Dining';
  String _selectedSavingHabit = 'Occasional Saver';

  final List<String> _financialGoals = [
    'Save for Future',
    'Build Emergency Fund',
    'Save for Higher Studies',
    'Track Spending Habits',
    'Learn Financial Management',
  ];

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'INR', 'JPY', 'AUD'];

  final List<String> _expenseCategories = [
    'Food & Dining',
    'Entertainment & Hobbies',
    'Travel & Transport',
    'Shopping & Clothing',
    'Education & Books',
    'Subscriptions',
  ];

  final List<String> _savingHabits = [
    'Regular Saver',
    'Occasional Saver',
    'Just Started',
    'Want to Learn',
  ];

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
    _courseController = TextEditingController();
    _monthlyAllowanceController = TextEditingController();
    _monthlyBudgetController = TextEditingController();
    _savingsGoalController = TextEditingController();
    _partTimeIncomeController = TextEditingController();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _courseController.dispose();
    _monthlyAllowanceController.dispose();
    _pageController.dispose();
    _monthlyBudgetController.dispose();
    _savingsGoalController.dispose();
    _partTimeIncomeController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    // Validate only required fields
    if (_ageController.text.isEmpty ||
        _courseController.text.isEmpty ||
        _monthlyAllowanceController.text.isEmpty ||
        _monthlyBudgetController.text.isEmpty ||
        _savingsGoalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final userProfile = UserProfile(
      userId: widget.userId,
      email: widget.email,
      fullName: widget.fullName,
      age: _ageController.text,
      occupation: _courseController.text,
      monthlyIncome: _monthlyAllowanceController.text,
      financialGoal: _selectedFinancialGoal,
      monthlyBudget: _monthlyBudgetController.text,
      currency: _selectedCurrency,
    );

    // Save to shared preferences
    await prefs.setString(
      'user_profile_${widget.userId}',
      userProfile.toJson().toString(),
    );
    await prefs.setBool('onboarding_completed_${widget.userId}', true);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Progress
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '🎓 Student Profile',
                            style: TextStyle(
                              color: Color(0xFFF97316),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hey ${widget.fullName}! Let\'s personalize your experience',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF97316),
                        radius: 20,
                        child: Text(
                          widget.fullName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress Bar
                  Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                          decoration: BoxDecoration(
                            color: index <= _currentPage
                                ? const Color(0xFFF97316)
                                : Colors.grey[800],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Step ${_currentPage + 1} of 4',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
            // PageView Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                },
                children: [
                  _buildPage1(),
                  _buildPage2(),
                  _buildPage3(),
                  _buildPage4(),
                ],
              ),
            ),
            // Navigation Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFF97316)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFFF97316),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _currentPage < 3
                          ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : _saveProfile,
                      child: Text(
                        _currentPage < 3 ? 'Continue' : 'Complete Setup 🚀',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Page 1: Basic Info
  Widget _buildPage1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📋 Basic Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tell us a bit about yourself',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildQuestionCard(
            icon: '🎂',
            child: _buildTextField(
              label: 'Age',
              controller: _ageController,
              hint: 'e.g., 21',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Age is required';
                if (int.tryParse(value) == null) return 'Enter a valid age';
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            icon: '📚',
            child: _buildTextField(
              label: 'Course/Field of Study',
              controller: _courseController,
              hint: 'e.g., Computer Science',
              validator: (value) {
                if (value!.isEmpty) return 'Course is required';
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Page 2: Money Matters
  Widget _buildPage2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💰 Money Matters',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us understand your finances',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildQuestionCard(
            icon: '💵',
            child: _buildTextField(
              label: 'Monthly Allowance/Pocket Money',
              controller: _monthlyAllowanceController,
              hint: 'e.g., 5000',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Monthly allowance is required';
                if (double.tryParse(value) == null) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            icon: '🎯',
            child: _buildTextField(
              label: 'Monthly Budget',
              controller: _monthlyBudgetController,
              hint: 'e.g., 4000',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Monthly budget is required';
                if (double.tryParse(value) == null) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            icon: '💼',
            child: _buildTextField(
              label: 'Part-time Income/Side Gigs',
              controller: _partTimeIncomeController,
              hint: 'Optional - e.g., 3000',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                if (double.tryParse(value) == null) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Page 3: Goals & Preferences
  Widget _buildPage3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎯 Goals & Preferences',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What are your financial aspirations?',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildQuestionCard(
            icon: '🚀',
            child: _buildDropdown(
              label: 'Financial Goal',
              value: _selectedFinancialGoal,
              items: _financialGoals,
              onChanged: (value) {
                setState(() => _selectedFinancialGoal = value!);
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            icon: '💎',
            child: _buildTextField(
              label: 'Annual Savings Goal Amount',
              controller: _savingsGoalController,
              hint: 'e.g., 50000',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Savings goal is required';
                if (double.tryParse(value) == null) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            icon: '🌍',
            child: _buildDropdown(
              label: 'Currency',
              value: _selectedCurrency,
              items: _currencies,
              onChanged: (value) {
                setState(() => _selectedCurrency = value!);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Page 4: Spending Habits
  Widget _buildPage4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💳 Spending Habits',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Last step! Tell us about your spending',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildQuestionCard(
            icon: '🛍️',
            child: _buildDropdown(
              label: 'Top Spending Category',
              value: _selectedExpenseCategory,
              items: _expenseCategories,
              onChanged: (value) {
                setState(() => _selectedExpenseCategory = value!);
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildQuestionCard(
            icon: '🏦',
            child: _buildDropdown(
              label: 'Your Saving Habit',
              value: _selectedSavingHabit,
              items: _savingHabits,
              onChanged: (value) {
                setState(() => _selectedSavingHabit = value!);
              },
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF97316).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF97316).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Text('✨', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You\'re all set! Click Complete Setup to start your financial journey.',
                    style: TextStyle(color: Colors.grey[300], fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard({required String icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: const Color(0xFF111827),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFF97316), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[700]!, width: 1),
          ),
          child: Theme(
            data: Theme.of(
              context,
            ).copyWith(canvasColor: const Color(0xFF111827)),
            child: DropdownButtonFormField<String>(
              value: value,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF111827),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              iconEnabledColor: const Color(0xFFF97316),
              iconDisabledColor: Colors.grey,
              dropdownColor: const Color(0xFF111827),
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }
}
