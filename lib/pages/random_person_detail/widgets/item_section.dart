import 'package:flutter/material.dart';

class ItemSection extends StatelessWidget {
  final String label;
  final String value;

  const ItemSection({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text('$label:')),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
