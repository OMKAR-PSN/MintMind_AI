import 'package:flutter/material.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Assistant"),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          "AI Chat Coming Soon",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
