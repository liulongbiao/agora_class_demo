import 'package:agora_class_demo/util/screen_dimens.dart';
import 'package:flutter/material.dart';

import 'class_callback.dart';
import 'small_video.dart';

/// 小视频列表
class SmallVideoList extends StatefulWidget {
  final ScreenDimens dimens;
  final int localUid;
  final List<int> smallUids;
  final VideoEnlargeListener onEnlarge;

  SmallVideoList({
    @required this.dimens,
    @required this.localUid,
    @required this.smallUids,
    this.onEnlarge,
  });

  @override
  State<StatefulWidget> createState() {
    return _SmallVideoListState();
  }
}

class _SmallVideoListState extends State<SmallVideoList> {
  bool collapsed = false;

  get dimens => widget.dimens;
  get localUid => widget.localUid;

  Widget _expandBtn() {
    String text = collapsed ? '展开窗口' : '收起窗口';
    IconData icon = collapsed ? Icons.expand_more : Icons.expand_less;
    return Container(
      width: dimens.setWidth(220),
      height: dimens.setHeight(70),
      child: FlatButton(
        color: Colors.black54,
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: dimens.setSp(30),
              color: Colors.white,
            ),
            SizedBox(
              width: dimens.setWidth(10),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: dimens.setSp(30),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: StadiumBorder(
          side: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        onPressed: () {
          debugPrint('toggleCollapsed');
          setState(() {
            collapsed = !collapsed;
          });
        },
      ),
    );
  }

  Widget _expand() {
    Widget btn = _expandBtn();
    return Container(
      child: btn,
      width: dimens.setWidth(255),
      height: dimens.setHeight(70),
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: dimens.setHeight(10),
      ),
    );
  }

  Widget _list(uids) {
    if (uids.isEmpty || collapsed) {
      return Container();
    }
    List<Widget> items = uids.map<Widget>((uid) {
      return Container(
        key: Key(uid.toString()),
        margin: EdgeInsets.only(bottom: dimens.setHeight(15)),
        child: SmallVideo(
          dimens: dimens,
          uid: uid,
          localUid: localUid,
          onEnlarge: widget.onEnlarge,
        ),
      );
    }).toList();
    return Container(
      width: dimens.setWidth(255),
      padding: EdgeInsets.only(top: dimens.setHeight(15)),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(
          dimens.setWidth(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  Widget _content() {
    List<int> uids = widget.smallUids;

    if (uids.isEmpty) {
      return Container();
    }
    return Column(
      children: <Widget>[
        _expand(),
        _list(uids),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }
}
