/*
 * Copyright (c) 2019-2019 KPG Inc. to Present.
 *  All Rights Reserved.
 *
 * This software is the confidential and proprietary information of KPG Inc. .
 * You shall not disclose such confidential information
 * and shall use it only in accordance with the terms of the license
 * agreement you entered into with www.kpg123.com.
 */

import 'package:flutter/material.dart';

/// 屏幕适配
///
/// 代码来自 ScreenUtil， 但不通过静态类成员
class ScreenDimens {
  //设计稿的设备尺寸修改
  double width;
  double height;
  bool allowFontScaling;

  MediaQueryData _mediaQueryData;
  double _screenWidth;
  double _screenHeight;
  double _pixelRatio;
  double _statusBarHeight;
  double _bottomBarHeight;
  double _textScaleFactor;

  ScreenDimens(
    BuildContext context, {
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  }) {
    init(context);
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  double get textScaleFactor => _textScaleFactor;

  ///设备的像素密度
  double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 dp 刘海屏会更高
  double get statusBarHeight => _statusBarHeight;

  ///底部安全区距离 dp
  double get bottomBarHeight => _bottomBarHeight;

  ///实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / width;

  get scaleHeight => _screenHeight / height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  double setWidth(num width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  double setHeight(num height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  double setSp(num fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}
