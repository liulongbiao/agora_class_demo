import 'package:agora_class_demo/util/screen_dimens.dart';
import 'package:agora_class_demo/widgets/common/adaptive_scaffold.dart';
import 'package:flutter/material.dart';

/// 课堂页面
class PageClassroom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageClassroomState();
  }
}

class _PageClassroomState extends State<PageClassroom> {
  ScreenDimens dimens;
  @override
  Widget build(BuildContext context) {
    dimens = ScreenDimens(context, width: 1536, height: 2048);
    return AdaptiveScaffold(
      dimens: dimens,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          BlackBoard(dimens),
        ],
      ),
    );
  }
}

class BlackBoard extends StatelessWidget {
  final ScreenDimens dimens;

  BlackBoard(this.dimens);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimens.screenWidthDp,
      height: dimens.screenHeightDp,
      color: Colors.teal,
    );
  }
}
