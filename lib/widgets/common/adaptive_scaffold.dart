/*
 * Copyright (c) 2019-2019 KPG Inc. to Present.
 *  All Rights Reserved.
 *
 * This software is the confidential and proprietary information of KPG Inc. .
 * You shall not disclose such confidential information
 * and shall use it only in accordance with the terms of the license
 * agreement you entered into with www.kpg123.com.
 */

import 'dart:io';

import 'package:agora_class_demo/util/screen_dimens.dart';
import 'package:flutter/material.dart';

/// 屏幕适配的 Scaffold
class AdaptiveScaffold extends StatelessWidget {
  final ScreenDimens dimens;
  final Widget body;
  final PreferredSizeWidget appBar;
  final Widget floatingActionButton;

  AdaptiveScaffold({
    this.dimens,
    this.body,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        body: Container(
          child: body,
        ),
      );
    } else {
      return Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: floatingActionButton,
        body: Container(
          width: dimens.screenWidthDp,
          height: dimens.screenHeightDp,
          child: body,
        ),
      );
    }
  }
}
