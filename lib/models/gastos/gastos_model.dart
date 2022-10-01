// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Gastos {
  int? id;
  String nombre;
  double monto;
  DateTime periodoPago;

  Gastos({
    this.id,
    required this.nombre,
    required this.monto,
    required this.periodoPago,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nombre': nombre,
      'monto': monto,
      'fecha_pago': periodoPago,
    };
  }

  factory Gastos.fromMap(Map<String, dynamic> map) {
    DateFormat datePago = DateFormat('Y-m-d H:i:s');
    return Gastos(
      id: map['id'] != null ? map['id'] as int : null,
      nombre: map['nombre'] as String,
      monto: map['monto'] as double,
      periodoPago: datePago.parse(map['fecha_pago']),
    );
  }
}
