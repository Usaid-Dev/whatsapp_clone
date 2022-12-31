import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.buttonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: SizedBox(
        height: 42,
        width: MediaQuery.of(context).size.width - 100,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('AGREE AND CONTINUE'),
        ),
      ),
    );
  }
}
