import 'package:flutter/material.dart';
import 'package:otter/pages/gastos/gastos_screen.dart';
import 'package:otter/pages/inicio/inicio_screen.dart';

final routes = <String, WidgetBuilder>{
  '/inicio': (context) => const InicioScreen(),
  '/detalle-gastos': (context) => const GastosScreen(),
};
