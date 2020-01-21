// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/digital_clock/screen_configurations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:digital_clock/digital_clock/animated_background.dart';
import 'package:flare_flutter/flare_controls.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  FlareControls _flareControls = new FlareControls();

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    ScreenConfigurations().init(context);
    return Stack(
      children: <Widget>[
        AnimatedBackground(
          filename: "assets/SunnyDay.flr",
          animation: "SunnyDay",
          animationController: _flareControls,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenConfigurations.screenHeight * 0.325,
            width: ScreenConfigurations.screenWidth * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(DateFormat('EEEE').format(_dateTime).toUpperCase(),
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                        )),
                    Text(_dateTime.day.toString(),
                        style: GoogleFonts.unicaOne(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 2, color: Colors.white),
                            ])),
                  ],
                ),
                Text(widget.model.temperatureString,
                    style: GoogleFonts.juliusSansOne(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            height: ScreenConfigurations.screenHeight * 0.4,
            width: ScreenConfigurations.screenWidth * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _dateTime.hour.toString(),
                  style: GoogleFonts.sunflower(
                      fontSize: ScreenConfigurations.screenWidth * 0.5 * 0.37,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 35,
                        )
                      ]),
                ),
                Text(DateFormat('mm').format(_dateTime),
                    style: GoogleFonts.sunflower(
                      fontSize: ScreenConfigurations.screenWidth * 0.5 * 0.37,
                      color: Colors.white.withOpacity(0.15),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
