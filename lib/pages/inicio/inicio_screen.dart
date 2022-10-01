import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:otter/models/gastos/gastos_model.dart';
import 'package:otter/providers/gastos_provider.dart';

import '../../widgets/inputs_widget.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final TextEditingController _controllerNombreGasto = TextEditingController();
  final TextEditingController _controllerMonto = TextEditingController();
  final TextEditingController _controllerFechaPago = TextEditingController();
  DateTime _fechaPagoGasto = DateTime.now();
  @override
  void dispose() {
    _controllerNombreGasto.dispose();
    _controllerMonto.dispose();
    _controllerFechaPago.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset('assets/icon.png'),
          actions: [
            MaterialButton(
              onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  isScrollControlled: false,
                  context: context,
                  builder: (context) {
                    return _ContenedorModalWidget(
                      controllerNombreGasto: _controllerNombreGasto,
                      controllerMonto: _controllerMonto,
                      controllerFechaPago: _controllerFechaPago,
                      fechaPago: _fechaPagoGasto,
                    );
                  }),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.black,
                size: 22,
              ),
            ),
          ],
          titleTextStyle: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
          ),
          centerTitle: false,
          title: const Text(
            'Otter',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saldo actual',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              const Text(
                '200.00',
                style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Proximos pagos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 22,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      ProximosPagosCardWidget(),
                      ProximosPagosCardWidget(),
                      ProximosPagosCardWidget(),
                      ProximosPagosCardWidget(),
                      ProximosPagosCardWidget(),
                    ]),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Gastos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  MaterialButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/detalle-gastos'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Ver mas',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(22)),
                child: FutureBuilder<List<Gastos>>(
                  future: GastosProvider.instance.selectGastos(),
                  builder: (context, AsyncSnapshot<List<Gastos>> snap) {
                    if (!snap.hasData) {
                      return const Text('Cargando...');
                    }
                    return snap.data!.isEmpty
                        ? const Center(
                            child: Text('Sin gastos registrados'),
                          )
                        : ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 15),
                            children: snap.data!.map((gasto) {
                              return ElementoGastosWidget(
                                nombre: gasto.nombre,
                                monto: gasto.monto,
                                fecha: gasto.periodoPago,
                              );
                            }).toList(),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ContenedorModalWidget extends StatefulWidget {
  final TextEditingController controllerNombreGasto;
  final TextEditingController controllerMonto;
  final TextEditingController controllerFechaPago;
  DateTime fechaPago;
  _ContenedorModalWidget({
    Key? key,
    required this.controllerNombreGasto,
    required this.controllerMonto,
    required this.controllerFechaPago,
    required this.fechaPago,
  }) : super(key: key);

  @override
  State<_ContenedorModalWidget> createState() => _ContenedorModalWidgetState();
}

class _ContenedorModalWidgetState extends State<_ContenedorModalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 35),
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: Column(
        children: [
          _ItemButtonModalOpttionsWidget(
            accionOnPressBoton: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (_) {
                    return Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        leading: Container(),
                      ),
                      backgroundColor: Colors.transparent,
                      body: Container(
                        padding:
                            const EdgeInsets.only(top: 22, left: 15, right: 15),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22))),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Agregar gasto',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InputTextFieldWidget(
                                    controller: widget.controllerNombreGasto,
                                    label: 'Nombre del gasto',
                                  ),
                                  InputTextFieldWidget(
                                    controller: widget.controllerMonto,
                                    label: 'Monto',
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                  InputTextFieldWidget(
                                    controller: widget.controllerFechaPago,
                                    label: 'Fecha de pago',
                                    inputType: TextInputType.datetime,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 35),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 22),
                                  color: const Color.fromARGB(255, 3, 23, 79),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  onPressed: () async {
                                    DateFormat format =
                                        DateFormat('Y-m-d H:i:s');
                                    setState(() {
                                      widget.fechaPago = format.parse(
                                          widget.controllerFechaPago.text);
                                    });
                                    await GastosProvider.instance.insertGasto(
                                        Gastos(
                                            nombre: widget
                                                .controllerNombreGasto.text,
                                            monto: double.parse(
                                                widget.controllerMonto.text),
                                            periodoPago: widget.fechaPago));
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Guardar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class _ItemButtonModalOpttionsWidget extends StatelessWidget {
  final void Function() accionOnPressBoton;
  const _ItemButtonModalOpttionsWidget({
    Key? key,
    required this.accionOnPressBoton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        child: MaterialButton(
          elevation: 0,
          color: Colors.grey.shade300,
          height: 33,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          onPressed: accionOnPressBoton,
          hoverElevation: 0,
          focusElevation: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Agregar gastos',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 30,
                )
              ]),
        ),
      ),
    );
  }
}

class ElementoGastosWidget extends StatelessWidget {
  final String nombre;
  final double monto;
  final DateTime fecha;
  const ElementoGastosWidget({
    Key? key,
    required this.nombre,
    required this.monto,
    required this.fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        showModalBottomSheet(
            elevation: 0,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.only(top: 22, left: 40, right: 40),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22))),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                nombre,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 32),
                              ),
                              MaterialButton(
                                onPressed: () {},
                                elevation: 0,
                                color: Colors.blue.shade800,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(
                                  Icons.playlist_add_check,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          const Text(
                            'Monto a pagar',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            monto.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          // ignore: prefer_const_constructors
                          Text(
                            'Fecha de pago',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            fecha.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        elevation: 0,
                        color: const Color.fromARGB(255, 249, 61, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: const Text(
                          'Eliminar',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              );
            });
      }),
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(nombre),
                Text(
                  '$monto',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text('Fecha de pago'), Text(fecha.toString())],
            ),
            const SizedBox(
              height: 15,
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProximosPagosCardWidget extends StatelessWidget {
  const ProximosPagosCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      width: 200,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(22)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '200.00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Fecha de pago:',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text('12 de sep 2022')
            ],
          ),
          Icon(
            Icons.monetization_on,
            size: 35,
            color: Colors.grey.shade700,
          )
        ],
      ),
    );
  }
}
