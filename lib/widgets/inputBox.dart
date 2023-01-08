import 'package:flutter/material.dart';
import '../pages/variables.dart' as vr;

class InputBox extends StatefulWidget {
  String boxName = "";
  bool obscure = false;
  InputBox({required this.boxName, required this.obscure});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 30,
          child: Text(
            widget.boxName,
            style: TextStyle(
              color: Colors.white,
              fontFamily: vr.basicFont,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 20,
          child: TextFormField(
            autofocus: false,
            obscureText: widget.obscure,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 35.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: TextStyle(
              fontFamily: vr.basicFont,
              fontSize: 24,
              color: Color(0xFF000000),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
      ],
    );
  }
}
