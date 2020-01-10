import 'package:agora_class_demo/util/screen_dimens.dart';
import 'package:agora_class_demo/util/toast_utils.dart';
import 'package:flutter/material.dart';

import 'agora_video.dart';
import 'class_callback.dart';

/// 小视频组件
class SmallVideo extends StatelessWidget {
  static DateTime lastEnlargeTs;

  final ScreenDimens dimens;
  final int uid;
  final int localUid;
  final VideoEnlargeListener onEnlarge;

  SmallVideo({
    @required this.dimens,
    @required this.uid,
    @required this.localUid,
    this.onEnlarge,
  });

  Widget _content() {
    return Container(
      width: dimens.setWidth(225),
      height: dimens.setHeight(300),
      child: AgoraVideo(
        uid: uid,
        localUid: localUid,
      ),
    );
  }

  Widget _main() {
    return Listener(
      child: _content(),
      onPointerDown: (details) {
        if (lastEnlargeTs != null &&
            lastEnlargeTs.add(Duration(seconds: 2)).isAfter(DateTime.now())) {
          debugPrint('videoEnlarge: too often');
          showToast('请不要频繁切换画面');
          return;
        }

        debugPrint('enlarge: $uid');
        if (onEnlarge != null) {
          onEnlarge(uid);
        }

        lastEnlargeTs = DateTime.now();
      },
    );
  }

  Widget _name() {
    String userName = "uid: $uid";
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: dimens.setHeight(12),
          left: dimens.setWidth(21),
        ),
        width: dimens.setWidth(180),
        height: dimens.setHeight(46),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.black, Colors.transparent],
            center: Alignment.centerLeft,
            radius: 3.0,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              dimens.setWidth(10),
            ),
          ),
        ),
        child: Text(
          userName,
          style: TextStyle(
            color: Colors.white,
            fontSize: dimens.setSp(24),
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimens.setWidth(225),
      height: dimens.setHeight(300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          dimens.setWidth(10),
        ),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        overflow: Overflow.visible,
        children: <Widget>[
          _main(),
          _name(),
        ],
      ),
    );
  }
}
