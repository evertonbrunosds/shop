import 'package:flutter/material.dart';
import 'package:shop/providers/Counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(final BuildContext context) {
    final provider = CounterProvider.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo contador'),
      ),
      body: Column(children: <Widget>[
        Text(provider.state.value.toString()),
        IconButton(
          onPressed: () => setState(provider.state.inc),
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () => setState(provider.state.dec),
          icon: const Icon(Icons.remove),
        ),
      ]),
    );
  }
}
