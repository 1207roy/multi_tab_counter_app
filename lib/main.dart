import 'package:counterapp/screens/counter_screen.dart';
import 'package:counterapp/store/counter_store.dart';
import 'package:counterapp/widgets/bottom_appbar.dart';
import 'package:counterapp/widgets/mobx_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isFloatingHidden = ValueNotifier<bool>(true);
  CounterStore store1;
  CounterStore store2;
  CounterStore store3;

  @override
  void initState() {
    super.initState();
    store1 = CounterStore();
    store2 = CounterStore();
    store3 = CounterStore();
  }

  String get title {
    switch (_pageIndex.value) {
      case 0:
        return "Counter 1";
      case 1:
        return "Counter 2";
      case 2:
        return "Counter 3";
    }
  }

  void _onItemTapped(int index) {
    _pageIndex.value = index;
  }

  AppBar get buildAppBar => AppBar(title: Text(title), centerTitle: true);

  _showHideFloatingButton() => isFloatingHidden.value = !(isFloatingHidden.value);

  List<Widget> get _widgetOptions => <Widget>[
        MobxProvider<CounterStore>.value(
          key: Key('1'),
          value: store1,
          child: ScreenOne(isFloatingHidden: isFloatingHidden, showHideFloatingButton: () =>_showHideFloatingButton()),
        ),
        MobxProvider<CounterStore>.value(
          key: Key('2'),
          value: store2,
          child: ScreenOne(isFloatingHidden: isFloatingHidden, showHideFloatingButton: _showHideFloatingButton),
        ),
        MobxProvider<CounterStore>.value(
          key: Key('3'),
          value: store3,
          child: ScreenOne(isFloatingHidden: isFloatingHidden, showHideFloatingButton: _showHideFloatingButton),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _pageIndex,
      builder: (_, __, ___) {
        return Scaffold(
            appBar: buildAppBar,
            body: _widgetOptions[_pageIndex.value],
            bottomNavigationBar: _bottomNavigationBar,
            floatingActionButton: floatingActionButton,
        );
      },
    );
  }

  get floatingActionButton {
    return ValueListenableBuilder<bool>(
      valueListenable: isFloatingHidden,
      builder: (BuildContext context, bool isHidden, Widget child) => AnimatedOpacity(
          opacity: isHidden ? 0 : 1,
          duration: Duration(milliseconds: 100),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: isHidden
                ? null
                : _onFloatingButtonPress,
          ),
        ),
    );
  }

  _onFloatingButtonPress() {
    if (_pageIndex.value == 0) {
      store1.incrementCounter();
    } else if (_pageIndex.value == 1) {
      store2.incrementCounter();
    } else {
      store3.incrementCounter();
    }
  }

  Widget get _bottomNavigationBar {
    return AppBottomAppBar(
      color: Colors.grey,
      selectedColor: Colors.lightBlue,
      onTabSelected: (index) => _onItemTapped(index),
      items: [
        BottomAppBarItem(iconData: Icons.home, text: 'Counter 1'),
        BottomAppBarItem(iconData: Icons.person, text: 'Counter 2'),
        BottomAppBarItem(iconData: Icons.group, text: 'Counter 3'),
      ],
    );
  }
}
