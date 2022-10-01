part of 'ingresos_bloc.dart';

@immutable
abstract class IngresosEvent {}

class AddEvent extends IngresosEvent {
  final String nombre;
  final double monto;
  final DateTime periodoPago;

  AddEvent(this.nombre, this.monto, this.periodoPago);
}
