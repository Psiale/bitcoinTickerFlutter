import 'package:flutter/material.dart';

double width(percentage, context) => MediaQuery.of(context).size.width;
double height(percentage, context) => MediaQuery.of(context).size.height;
const kdropDownItem = TextStyle(
    backgroundColor: Colors.yellow, color: Colors.black, fontSize: 30.0);
const kDropDownIconStyle = Icon(
  Icons.arrow_downward,
  size: 30.0,
  color: Colors.yellow,
);
