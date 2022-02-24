import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const Badge({
    Key? key,
    required final this.child,
    required final this.value,
    final this.color,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color ?? Theme.of(context).colorScheme.error,
              ),
              constraints: const BoxConstraints(
                minHeight: 16,
                maxWidth: 16,
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              )),
        )
      ],
    );
  }
}
