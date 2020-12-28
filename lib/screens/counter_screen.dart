
import 'package:counterapp/store/counter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ScreenOne extends StatefulWidget {
  final ValueNotifier<bool> isFloatingHidden;
  final Function showHideFloatingButton;

  const ScreenOne({Key key, this.isFloatingHidden, this.showHideFloatingButton}) : super(key: key);

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  CounterStore store;

  @override
  void initState() {
    super.initState();
    store = context.read<CounterStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Observer(
              builder: (context) {
                return Text('${store.counter}', style: Theme.of(context).textTheme.headline3);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text('Increment me!'),
                  onPressed: () => store.incrementCounter(),
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: widget.isFloatingHidden,
              builder: (BuildContext context, bool isHidden, Widget child) {
                return RaisedButton(
                  child: Text(isHidden ? 'Show Floating button' : 'Hide Floating Button'),
                  onPressed: () => widget.showHideFloatingButton(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}