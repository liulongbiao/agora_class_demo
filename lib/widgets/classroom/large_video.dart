import 'dart:math';

import 'package:agora_class_demo/util/screen_dimens.dart';
import 'package:agora_class_demo/widgets/common/circle_icon_button.dart';
import 'package:flutter/material.dart';

import 'agora_video.dart';
import 'class_callback.dart';
import 'switch_camera_button.dart';

/// 大视频组件
class LargeVideo extends StatelessWidget {
  final ScreenDimens dimens;
  final int largeUid;
  final int localUid;
  final VideoShrinkListener onShrink;

  LargeVideo({
    @required this.dimens,
    @required this.largeUid,
    @required this.localUid,
    this.onShrink,
  });

  Widget _content() {
    return Container(
      width: dimens.setWidth(1536),
      height: dimens.setHeight(2048),
      color: Colors.black,
      child: AgoraVideo(
        uid: largeUid,
        localUid: localUid,
      ),
    );
  }

  Widget _operation() {
    List<Widget> btns = [];

    if (largeUid == localUid) {
      btns.add(SwitchCameraButton(
        size: dimens.setWidth(130),
        iconSize: dimens.setWidth(90),
      ));
    }

    return Positioned(
      right: dimens.setWidth(50),
      bottom: max(dimens.setHeight(150), dimens.bottomBarHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: btns,
      ),
    );
  }

  Widget _shrink() {
    return Positioned(
      top: max(dimens.setHeight(70), dimens.statusBarHeight),
      left: dimens.setWidth(50),
      child: CircleIconButton(
        icon: Icons.close,
        size: dimens.setWidth(90),
        iconSize: dimens.setWidth(60),
        onPressed: () {
          debugPrint('shrink: $largeUid');
          if (onShrink != null) {
            onShrink(largeUid);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimens.setWidth(1536),
      height: dimens.setHeight(2048),
      child: Stack(
        fit: StackFit.passthrough,
        overflow: Overflow.visible,
        children: <Widget>[
          _content(),
          _operation(),
          _shrink(),
        ],
      ),
    );
  }
}
