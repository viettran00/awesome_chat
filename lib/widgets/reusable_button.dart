import 'package:awesome_chat/utils/constants.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {

  final String buttonTitle;
  final Function function;

  const ReusableButton({
    Key? key,
    required this.buttonTitle,
    required this.function
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15.0)),
        child: Center(
          child: Text(buttonTitle, style: kButtonTitle),
        ),
      ),
    );
  }
}