// ignore_for_file: file_names
import 'package:flutter/material.dart' show BuildContext, InheritedWidget, Key, Widget;

//  CLASSE ÚTIL NA DEMONSTRAÇÃO DO COMPARTILHAMENTO
//  DE ESTADO SEM QUE SEJA NECESSÁRIO TRANSMITI-LO
//  DE FORMAS DIRETAS E INDIRETAS ATRAVÉS DE DIVERSOS
//  COMPONENTES DA ÁRVORE
class CounterState {
  int _value = 0;
  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;
  bool diff({required final CounterState current}) => current._value != _value;
}

class CounterProvider extends InheritedWidget {
  final state = CounterState();
  CounterProvider({Key? key, required final Widget child})
      : super(key: key, child: child);

  static CounterProvider? of(final BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(current: state);
  }
}
