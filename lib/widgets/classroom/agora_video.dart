import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

/// 声网视频组件
class AgoraVideo extends StatelessWidget {
  final int uid;
  final int localUid;

  AgoraVideo({
    @required this.uid,
    @required this.localUid,
  });

  @override
  Widget build(BuildContext context) {
    return uid == localUid ? AgoraLocalVideo(uid) : AgoraRemoteVideo(uid);
  }
}

class AgoraLocalVideo extends StatelessWidget {
  final int uid;

  AgoraLocalVideo(this.uid);

  @override
  Widget build(BuildContext context) {
    return AgoraRenderWidget(
      uid,
      local: true,
    );
  }
}

class AgoraRemoteVideo extends StatelessWidget {
  final int uid;

  AgoraRemoteVideo(this.uid);

  @override
  Widget build(BuildContext context) {
    return AgoraRenderWidget(uid);
  }
}
