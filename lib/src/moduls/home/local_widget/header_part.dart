import 'package:flutter/material.dart';

class HeaderPart extends StatelessWidget {
  const HeaderPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Note",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0),
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(.8),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.sort,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
