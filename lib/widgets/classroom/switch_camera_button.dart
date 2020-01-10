/*
 * Copyright (c) 2019-2019 KPG Inc. to Present.
 *  All Rights Reserved.
 *
 * This software is the confidential and proprietary information of KPG Inc. .
 * You shall not disclose such confidential information
 * and shall use it only in accordance with the terms of the license
 * agreement you entered into with www.kpg123.com.
 */

import 'package:agora_class_demo/widgets/common/circle_icon_button.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

/// 切换相机按钮
class SwitchCameraButton extends StatefulWidget {
  final double size;
  final double iconSize;

  SwitchCameraButton({
    this.size = 40.0,
    this.iconSize = 24.0,
  });

  @override
  State<StatefulWidget> createState() {
    return _SwitchCameraButton();
  }
}

class _SwitchCameraButton extends State<SwitchCameraButton> {
  bool switched = false;

  toggle() {
    setState(() {
      switched = !switched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: switched ? Icons.camera_rear : Icons.camera_front,
      size: widget.size,
      iconSize: widget.iconSize,
      onPressed: () async {
        try {
          debugPrint('switchCamera');
          await AgoraRtcEngine.switchCamera();
          toggle();
        } catch (e) {
          // ignore
          debugPrint('switchCamera error $e');
        }
      },
    );
  }
}
