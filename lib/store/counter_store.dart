import 'package:counterapp/widgets/mobx_provider.dart';
import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

class CounterStore = _CounterStoreBase with _$CounterStore;

abstract class _CounterStoreBase with Store, Disposable {
  _CounterStoreBase({this.counter = 0});

  @observable
  int counter;

  @action
  void incrementCounter() {
    counter++;
  }

  @action
  void decrementCounter() {
    counter--;
  }
}