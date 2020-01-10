import 'dart:math';

import 'package:agora_class_demo/settings.dart';
import 'package:agora_class_demo/util/screen_dimens.dart';
import 'package:agora_class_demo/util/toast_utils.dart';
import 'package:agora_class_demo/widgets/classroom/large_video.dart';
import 'package:agora_class_demo/widgets/classroom/small_video_list.dart';
import 'package:agora_class_demo/widgets/common/adaptive_scaffold.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// 课堂页面
class PageClassroom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageClassroomState();
  }
}

class _PageClassroomState extends State<PageClassroom> {
  ScreenDimens dimens;
  int localUid = 0;
  final List<int> remoteUids = new List();
  int largeUid = 0;

  List<int> get smallUids {
    List<int> result = List();
    if (localUid != null && localUid != 0) {
      result.add(localUid);
    }
    if (remoteUids != null) {
      result.addAll(remoteUids);
    }
    if (result.length > 5) {
      result = result.sublist(0, 5);
    }
    if (largeUid != null && largeUid != 0) {
      result.remove(largeUid);
    }
    return result;
  }

  @override
  void initState() {
    super.initState();

    _join();
  }

  void _join() async {
    // 初始化前，请求相机麦克风权限
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);

    await AgoraRtcEngine.create(AGORA_APPID);
    _initHandlers();

    VideoEncoderConfiguration config = new VideoEncoderConfiguration();
    config.dimensions = Size(720, 960);
    config.frameRate = 15;
    config.orientationMode = VideoOutputOrientationMode.FixedPortrait;
    AgoraRtcEngine.setVideoEncoderConfiguration(config);

    AgoraRtcEngine.enableAudio();
    AgoraRtcEngine.enableVideo();
    AgoraRtcEngine.setAudioProfile(
        AudioProfile.MusicStandardStereo, AudioScenario.GameStreaming);
    AgoraRtcEngine.enableWebSdkInteroperability(true);
    AgoraRtcEngine.setParameters(
        '{\"che.video.lowBitRateStreamParameter\":{\"width\":120,\"height\":160,\"frameRate\":15,\"bitRate\":45}}');
    AgoraRtcEngine.enableDualStreamMode(true);
    AgoraRtcEngine.setRemoteDefaultVideoStreamType(1);

    Future.delayed(Duration(seconds: 2), () {
      AgoraRtcEngine.joinChannel(null, 'classroom', null, 0);
    });
  }

  void _initHandlers() {
    AgoraRtcEngine.onError = (code) {
      debugPrint('onError: $code');
      showToast("音视频连接错误，错误码: " + code.toString());
    };

    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      debugPrint('onJoinChannelSuccess: $uid - $elapsed');
      setState(() {
        localUid = uid;
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      debugPrint('onLeaveChannel');
      setState(() {
        localUid = 0;
        largeUid = 0;
        remoteUids.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      debugPrint('onUserJoined: $uid - $elapsed');
      setState(() {
        remoteUids.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      debugPrint('onUserOffline: $uid - $reason');
      setState(() {
        remoteUids.remove(uid);
      });
    };
  }

  void _leave() async {
    await AgoraRtcEngine.leaveChannel();
    await AgoraRtcEngine.destroy();
    localUid = 0;
    largeUid = 0;
    remoteUids.clear();
  }

  @override
  void dispose() {
    _leave();
    super.dispose();
  }

  void _onShrink(int uid) {
    if (uid != localUid) {
      AgoraRtcEngine.setRemoteVideoStreamType(uid, 1);
    }
    setState(() {
      largeUid = 0;
    });
  }

  Widget _large() {
    if (largeUid != null && largeUid != 0) {
      return LargeVideo(
        dimens: dimens,
        largeUid: largeUid,
        localUid: localUid,
        onShrink: this._onShrink,
      );
    } else {
      return Container();
    }
  }

  void _onEnlarge(int uid) {
    if (largeUid != null && largeUid != 0 && largeUid != localUid) {
      AgoraRtcEngine.setRemoteVideoStreamType(uid, 1);
    }
    if (uid != localUid) {
      AgoraRtcEngine.setRemoteVideoStreamType(uid, 0);
    }
    setState(() {
      largeUid = uid;
    });
  }

  Widget _list() {
    List<int> uids = smallUids;
    if (uids.isNotEmpty) {
      return Positioned(
        top: max(dimens.setHeight(80), dimens.statusBarHeight),
        right: dimens.setWidth(50),
        child: SmallVideoList(
          dimens: dimens,
          localUid: localUid,
          smallUids: uids,
          onEnlarge: this._onEnlarge,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _blackboard() {
    return Container(
      width: dimens.screenWidthDp,
      height: dimens.screenHeightDp,
      color: Colors.teal,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(localUid == 0 ? '正在连接...' : 'localUid: $localUid'),
            Text('largeUid: $largeUid'),
            Text('remoteUids: $remoteUids'),
            RaisedButton(
              child: Text('退出课堂'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dimens = ScreenDimens(context, width: 1536, height: 2048);
    return AdaptiveScaffold(
      dimens: dimens,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          _blackboard(),
          _large(),
          _list(),
        ],
      ),
    );
  }
}
