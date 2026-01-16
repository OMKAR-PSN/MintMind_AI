import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class QnaScreen extends StatefulWidget {
  const QnaScreen({super.key});

  @override
  State<QnaScreen> createState() => _QnaScreenState();
}

class _QnaScreenState extends State<QnaScreen> {
  final List<Map<String, String>> qaList = [
    {
      'question': 'What is MintMind AI?',
      'answer':
          'MintMind AI is an intelligent financial assistant that helps you manage your expenses and provides AI-powered financial insights.',
    },
    {
      'question': 'How do I add an expense?',
      'answer':
          'Navigate to the "Add Expense" section from the dashboard and fill in the expense details including amount, category, and date.',
    },
    {
      'question': 'Can I track my spending by category?',
      'answer':
          'Yes, the dashboard provides a detailed breakdown of your expenses by category, helping you understand your spending patterns.',
    },
    {
      'question': 'How does the AI chat feature work?',
      'answer':
          'The AI chat feature allows you to ask financial questions and get personalized advice based on your spending habits.',
    },
    {
      'question': 'Is my data secure?',
      'answer':
          'Yes, all your financial data is encrypted and stored securely. Your privacy is our priority.',
    },
    {
      'question': 'Can I export my expense reports?',
      'answer':
          'Yes, you can generate and export detailed expense reports in various formats from the dashboard.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: qaList.length,
              itemBuilder: (context, index) {
                return _buildQACard(
                  question: qaList[index]['question']!,
                  answer: qaList[index]['answer']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
                child: const Text(
                  'Continue to Dashboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQACard({required String question, required String answer}) {
    return ExpansionTile(
      backgroundColor: Colors.grey[900],
      collapsedBackgroundColor: Colors.grey[900],
      title: Text(
        question,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.expand_more, color: Colors.orange),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
