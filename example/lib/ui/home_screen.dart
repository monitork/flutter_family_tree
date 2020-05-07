import 'dart:math';
import 'package:flutter_family_tree/flutter_family_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_family_tree_example/ui/measure_size.dart';

class TreeItem {
//  final int id;
//  final int parentId;
  @required
  String title;
  String subTitle;
  List<TreeItem> extras;

  TreeItem({this.title, this.subTitle, this.extras});

//  String getId() {
//    return this.id.toString();
//  }

  List<TreeItem> getExtraData() {
    return this.extras;
  }

//  String getParentId() {
//    return this.parentId.toString();
//  }

  String getTitle() {
    return this.title;
  }

  String getSubTitle() {
    return this.subTitle;
  }
}

class HomeScreen extends StatelessWidget {
  var data = TreeItem(title: "Level 0", extras: [
    TreeItem(title: "Level1.1", extras: [TreeItem(title: 'Level 1.1.1')]),
    TreeItem(title: "Level1.2", extras: [
      TreeItem(
          title: 'Level 1.2.1', extras: [TreeItem(title: 'Level 1.2.1.1')]),
      TreeItem(title: 'Level 1.2.2'),
      TreeItem(title: 'Level 1.2.3')
    ])
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Family Tree'),
          ),
          body: FamilyTree(
            child: FFTParent(
              parent: TreeItemWidget(
                item: TreeItem(title: "Level 0"),
              ),
              children: <Widget>[
                FFTParent(
                  parent: TreeItemWidget(
                    item: TreeItem(title: "Level 1.1"),
                  ),
                  children: <Widget>[
                    FFTParent(
                        parent: TreeItemWidget(
                      item: TreeItem(title: "Level 2.1"),
                    )),
                    FFTParent(
                        parent: TreeItemWidget(
                      item: TreeItem(title: "Level 2.2"),
                    ))
                  ],
                ),
                FFTParent(
                  parent: TreeItemWidget(
                    item: TreeItem(title: "Level 1.1"),
                  ),
                  children: <Widget>[
                    FFTParent(
                        parent: TreeItemWidget(
                      item: TreeItem(title: "Level 2.1"),
                    )),
                    FFTParent(
                        parent: TreeItemWidget(
                      item: TreeItem(title: "Level 2.2"),
                    ))
                  ],
                ),
                FFTParent(
                  parent: TreeItemWidget(
                    item: TreeItem(title: "Level 1.2"),
                  ),
                  children: <Widget>[
                    FFTParent(
                        parent: TreeItemWidget(
                      item: TreeItem(title: "Level 2.3"),
                    )),
                    FFTParent(
                        parent: TreeItemWidget(
                      item: TreeItem(title: "Level 2.4"),
                    ))
                  ],
                )
              ],
            ),
          )
//        TreeView(
//          data: data,
//        ),
          ),
    );
  }
}

class TreeView extends StatefulWidget {
  final TreeItem data;
  final Color bgColor;
  final Color separatorColor;
  final Padding padding;

  const TreeView(
      {Key key,
      this.data,
      this.bgColor = Colors.white,
      this.separatorColor = Colors.red,
      this.padding})
      : super(key: key);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraint.maxWidth, minHeight: constraint.maxHeight),
          child: Container(
            padding:
                widget.padding != null ? widget.padding : EdgeInsets.all(0.0),
            decoration: BoxDecoration(color: widget.bgColor),
            child: TreeColumn(
                data: widget.data,
                isFist: true,
                isLast: true,
                bgColor: widget.bgColor,
                separatorColor: widget.separatorColor),
          ),
        ),
        scrollDirection: Axis.horizontal,
      );
    });
  }
}

class TreeRow extends StatelessWidget {
  final List<TreeItem> data;
  final Color bgColor;
  final Color separatorColor;

  const TreeRow(
      {Key key, @required this.data, this.bgColor, this.separatorColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(data.length, (index) {
          return TreeColumn(
            data: data[index],
            isFist: index == 0,
            isLast: index == data.length - 1,
            bgColor: bgColor,
            separatorColor: separatorColor,
          );
        }));
  }
}

class TreeColumn extends StatefulWidget {
  final TreeItem data;
  final bool isFist;
  final bool isLast;
  final Color bgColor;
  final Color separatorColor;

  const TreeColumn(
      {Key key,
      @required this.data,
      this.isFist = false,
      this.isLast = false,
      this.bgColor,
      this.separatorColor})
      : super(key: key);

  @override
  _TreeColumnState createState() => _TreeColumnState();
}

class _TreeColumnState extends State<TreeColumn> {
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
            drawHorizontalLine(myChildSize.width),
            TreeItemWidget(
              item: widget.data,
              isParent: false,
            ),
            widget.data.extras != null && widget.data.extras.length > 0
                ? TreeRow(
                    data: widget.data.extras,
                    bgColor: widget.bgColor,
                    separatorColor: widget.separatorColor)
                : SizedBox(),
          ],
        ));
  }

  Widget drawHorizontalLine(double width) {
    if (widget.isFist && widget.isLast) {
      return Container(
        height: 1,
        width: 1,
        color: widget.separatorColor,
      );
    }
    return SizedBox(
      width: width,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 1,
              color: widget.isFist ? widget.bgColor : widget.separatorColor,
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                height: 1,
                color: widget.isLast ? widget.bgColor : widget.separatorColor,
              ))
        ],
      ),
    );
  }
}

class TreeItemWidget extends StatelessWidget {
  final TreeItem item;
  final bool isParent;

  const TreeItemWidget({Key key, @required this.item, this.isParent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          drawVerticalTopLine(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(color: Colors.yellow),
            child: ListTile(
              title: Text(
                '${item.title}',
                textAlign: TextAlign.center,
              ),
              subtitle: item.subTitle != null ? Text('${item.subTitle}') : null,
            ),
          ),
          drawVerticalLine(),
        ],
      ),
    );
  }

  Widget drawVerticalTopLine() {
    if (isParent) {
      return SizedBox();
    }
    return Container(
      width: 1,
      height: 8,
      decoration: BoxDecoration(color: Colors.red),
    );
  }

  Widget drawVerticalLine() {
    if (item.extras != null) {
      return Container(
        width: 1,
        height: 16,
        decoration: BoxDecoration(color: Colors.red),
      );
    } else {
      return SizedBox();
    }
  }
}
