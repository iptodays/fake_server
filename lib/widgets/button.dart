import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;

  final GestureTapCallback? onTap;

  @override
  State<StatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.child,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
    );
  }
}
