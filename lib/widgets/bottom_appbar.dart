import 'package:flutter/material.dart';

class BottomAppBarItem {
  BottomAppBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}

class AppBottomAppBar extends StatefulWidget {
  final List<BottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final Function(int) onTabSelected;

  const AppBottomAppBar({
    Key key,
    this.items,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.onTabSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppBottomAppBarState();
}

class AppBottomAppBarState extends State<AppBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    BottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    final iconColor = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: iconColor, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: iconColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
