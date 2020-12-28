import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' as pr;

class MobxProvider<T extends Disposable> extends pr.Provider<T> {
  static void _dispose(BuildContext context, Disposable store) {
    store?.dispose();
  }

  MobxProvider({
    Key key,
    @required pr.Create<T> create,
    bool lazy,
    Widget child,
  })  : assert(create != null),
        super(
          key: key,
          lazy: lazy,
          create: create,
          dispose: _dispose,
          child: child,
        );

  MobxProvider.value({
    Key key,
    @required T value,
    pr.UpdateShouldNotify<T> updateShouldNotify,
    Widget child,
  }) : super.value(
          key: key,
          value: value,
          updateShouldNotify: updateShouldNotify,
          child: child,
        );
}

mixin Disposable {
  void dispose() {}
}
