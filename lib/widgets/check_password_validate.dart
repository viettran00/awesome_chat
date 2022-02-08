import 'package:awesome_chat/utils/constants.dart';
import 'package:flutter/material.dart';

class CheckPasswordRegExp extends StatelessWidget {
  bool condition;
  String checkPassSymbolizing;
  String checkPassDetail;

  CheckPasswordRegExp({
    Key? key,
    required this.condition,
    required this.checkPassSymbolizing,
    required this.checkPassDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text(checkPassSymbolizing, style: kCheckPassSymbolizing),
            Text(checkPassDetail, style: kCheckPassDetail),
          ],
        ),
        Positioned(
          right: 0.0,
          child: Icon(
            Icons.check_circle,
            color: condition ? Colors.green : Colors.grey,
            size: 16.0,
          ),
        )
      ],
    );
  }
}
