import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text("this is page for 3", style: const TextStyle(color: Colors.red)),
    );
  }
}
