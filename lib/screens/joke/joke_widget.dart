import 'package:flutter/material.dart';

class JokeListItem extends StatelessWidget {
  final String message;

  const JokeListItem({
    Key? key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: Text(message)));
  }
}
