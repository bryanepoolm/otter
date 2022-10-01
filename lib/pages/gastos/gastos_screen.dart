import 'package:flutter/material.dart';

class GastosScreen extends StatefulWidget {
  const GastosScreen({Key? key}) : super(key: key);

  @override
  State<GastosScreen> createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_outlined),
        ),
        centerTitle: false,
        title: const Text(
          'Gastos',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(),
    );
  }
}
