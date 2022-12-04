import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Icon(
        Icons.chat,
        size: 45,
      ),
    );
  }
}
