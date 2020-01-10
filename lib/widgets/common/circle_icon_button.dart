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

/// 圆形 IconButton
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color color;
  final Color bgColor;
  final VoidCallback onPressed;

  CircleIconButton({
    @required this.icon,
    this.size = 40.0,
    this.iconSize = 24.0,
    this.color = Colors.white,
    this.bgColor = Colors.black38,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        color: bgColor,
        shape: CircleBorder(),
      ),
      child: IconButton(
        iconSize: iconSize,
        icon: Icon(icon),
        color: color,
        padding: EdgeInsets.all((size - iconSize) / 2),
        onPressed: onPressed,
      ),
    );
  }
}
