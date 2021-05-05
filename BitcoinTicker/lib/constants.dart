import 'package:flutter/material.dart';

double width(percentage, context) => MediaQuery.of(context).size.width;
double height(percentage, context) => MediaQuery.of(context).size.height;
const kdropDownItem = TextStyle(color: Colors.white, fontSize: 30.0);
const kDropDownIconStyle = Icon(
  Icons.arrow_downward,
  size: 30.0,
  color: Color(0xffa31c44),
);
