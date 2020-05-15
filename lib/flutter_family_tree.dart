library flutter_family_tree;

import 'package:flutter/material.dart';
import 'measure_size.dart';

class FamilyTree extends StatelessWidget {
  final Color bgColor;
  final Color separatorColor;
  final Padding padding;
  final FFTParent child;
  final double itemWidth;

  const FamilyTree(
      {Key key,
      this.bgColor = Colors.white,
      this.separatorColor = Colors.red,
      this.padding,
      @required this.child,
      this.itemWidth = 200.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraint.maxWidth, minHeight: constraint.maxHeight),
          child: Container(
              padding: padding != null ? padding : EdgeInsets.all(0.0),
              decoration: BoxDecoration(color: bgColor),
              child: child),
        ),
        scrollDirection: Axis.horizontal,
      );
    });
  }
}

class FFTParent extends StatefulWidget {
  final Widget parent;
  final List<Widget> children;

  const FFTParent({Key key, @required this.parent, this.children})
      : super(key: key);

  @override
  _FFTParentState createState() => _FFTParentState();
}

class _FFTParentState extends State<FFTParent> {
  var myChildSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
        onChange: (size) {
          setState(() {
            myChildSize = size;
          });
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.parent,
              drawVerticalLine(),
              drawHorizontalLine(false, false, width: myChildSize.width),
              widget.children != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.children.length,
                        (index) {
                          return FFTParent(
                            parent: widget.children[index],
                          );
                        },
                      ))
                  : SizedBox()
            ]));
  }

  Widget drawHorizontalLine(bool isFirst, bool isLast, {double width = 0}) {
    return SizedBox(
      width: width,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 1,
//              color: Colors.red,
              color: isFirst ? Colors.white : Colors.red,
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                height: 1,
//                color: Colors.red,
                color: isLast ? Colors.white : Colors.red,
              ))
        ],
      ),
    );
  }
}

class FFTRow extends StatelessWidget {
  final List<Widget> children;

  const FFTRow({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        children != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  children.length,
                  (index) {
                    return FFTItem(child: children[index]);
                  },
                ))
            : SizedBox()
      ],
    );
  }
}

class FFTItem extends StatelessWidget {
  final Widget child;

  const FFTItem({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[drawVerticalTopLine(), child, drawVerticalLine()],
      ),
    );
  }
}

Widget drawVerticalTopLine() {
  return Container(
    width: 1,
    height: 8,
    decoration: BoxDecoration(color: Colors.red),
  );
}

Widget drawVerticalLine() {
  return Container(
    width: 1,
    height: 16,
    decoration: BoxDecoration(color: Colors.red),
  );
}
