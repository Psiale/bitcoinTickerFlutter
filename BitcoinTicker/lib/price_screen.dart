import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'constants.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({Key key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropDownValue = 'MXN';
  int selectedValue;
  CoinData coinData = new CoinData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.yellow[300],
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                child: Center(
                  child: Text(
                    "1 BTC = USD",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ),
          Container(
            child: (Platform.isAndroid) ? isMaterial() : isCupertino(),
          )
        ],
      ),
      appBar: AppBar(),
    );
  }

  isMaterial() {
 return  Center(
   child: DropdownButton<String>(
      value: dropDownValue,
      icon: kDropDownIconStyle,
      elevation: 16,
      style: kdropDownItem,
      onChanged: (String newValue) {
        setState(() {
          dropDownValue = newValue;
        });
      },
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
 );
}
  isCupertino() {
    return CupertinoPicker(
              onSelectedItemChanged: (int currentValue) {
                setState(() {
                  selectedValue = currentValue;
                });
              },
              diameterRatio: 2.1,
              itemExtent: 50.0,
              children: [for (var currency in currenciesList) Text(currency)],
            );
  }
}
