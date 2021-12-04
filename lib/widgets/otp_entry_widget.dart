import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpEntryWidget extends StatefulWidget {
  const OtpEntryWidget({Key? key}) : super(key: key);

  @override
  _OtpEntryWidgetState createState() => _OtpEntryWidgetState();
}

class _OtpEntryWidgetState extends State<OtpEntryWidget> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PinPut(
            // obscureText: '●',
            fieldsCount: 6,
            controller: otpController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            keyboardType: TextInputType.number,
            fieldsAlignment: MainAxisAlignment.center,
            eachFieldMargin: const EdgeInsets.symmetric(horizontal: 5),
            selectedFieldDecoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).scaffoldBackgroundColor),
            ),
            submittedFieldDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Theme.of(context).scaffoldBackgroundColor),
            ),
            followingFieldDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
