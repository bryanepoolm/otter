import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class InputTextFieldWidget extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  const InputTextFieldWidget({
    Key? key,
    required this.label,
    this.inputType = TextInputType.text,
    required this.controller,
  }) : super(key: key);

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        onTap: () async {
          if (widget.inputType == TextInputType.datetime) {
            if (Platform.isAndroid) {
              widget.controller.text = showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100))
                  .toString();
            } else {
              CupertinoRoundedDatePicker.show(
                context,
                borderRadius: 16,
                initialDate: DateTime.now(),
                minimumYear: 1900,
                maximumYear: 2100,
                initialDatePickerMode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (newDateTime) async {
                  setState(() {
                    widget.controller.text = DateTime(newDateTime.year,
                            newDateTime.month, newDateTime.day)
                        .toString();
                  });
                },
              );
            }
          }
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 216, 216, 216),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              width: 0,
              color: Colors.white,
            )),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 4, color: Color.fromARGB(255, 3, 23, 79))),
            label: Text(widget.label),
            floatingLabelStyle:
                const TextStyle(color: Color.fromARGB(255, 3, 23, 79))),
      ),
    );
  }
}
