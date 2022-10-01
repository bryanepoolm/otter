import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ingresos_event.dart';
part 'ingresos_state.dart';

class IngresosBloc extends Bloc<IngresosEvent, IngresosState> {
  IngresosBloc()
      : super(IngresosInitial(
            periodoIngreso: DateTime.now(), monto: 200.00, nombre: '')) {
    on<IngresosEvent>((event, emit) {});
  }
}
