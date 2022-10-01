part of 'ingresos_bloc.dart';

@immutable
abstract class IngresosState {}

class IngresosInitial extends IngresosState {
  final String nombre;
  final double monto;
  final DateTime periodoIngreso;

  IngresosInitial(
      {required this.nombre,
      required this.monto,
      required this.periodoIngreso});
}
