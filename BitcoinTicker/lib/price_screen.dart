import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'constants.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import './classes/cripto_currency.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({Key key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //final CriptoCurrency criptoCurrency = new CriptoCurrency();
  String dropDownValue = 'USD';
  int selectedValue;
  String btcCoinExchangeValue = "31388";
  String ethCoinExchangeValue = "1146";
  String ltcCoinExchangeValue = "132";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Crypto")),
        backgroundColor: Color(0xFF695ffe),
      ),
      backgroundColor: Color(0xFF060047),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurrencyWidget(
            coinExchangeValue: btcCoinExchangeValue,
            criptoValue: "${cryptoList[0]}",
          ),
          CurrencyWidget(
            coinExchangeValue: ethCoinExchangeValue,
            criptoValue: "${cryptoList[1]}",
          ),
          CurrencyWidget(
            coinExchangeValue: ltcCoinExchangeValue,
            criptoValue: "${cryptoList[2]}",
          ),
          Container(
            child: (Platform.isAndroid) ? isMaterial() : isCupertino(),
          )
        ],
      ),
    );
  }

  isMaterial() {
    return Center(
      child: DropdownButton<String>(
        value: dropDownValue,
        icon: kDropDownIconStyle,
        elevation: 16,
        style: kdropDownItem,
        dropdownColor: Color(0xFF060047),
        onChanged: (String newValue) {
          _onLoading(context, newValue);
          // var btcCoinData =
          //     await criptoCurrency.getCoinData(cryptoList[0], newValue);
          // var ethCoinData =
          //     await criptoCurrency.getCoinData(cryptoList[1], newValue);
          // var ltcCoinData =
          //     await criptoCurrency.getCoinData(cryptoList[2], newValue);
          // setState(() {
          //   dropDownValue = newValue;
          //   btcCoinExchangeValue = btcCoinData['rate'].toStringAsFixed(0);
          //   ethCoinExchangeValue = ethCoinData['rate'].toStringAsFixed(0);
          //   ltcCoinExchangeValue = ltcCoinData['rate'].toStringAsFixed(0);
          // });
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
      offAxisFraction: 0.5,
      looping: true,
      backgroundColor: Color(0xFF060047),
      onSelectedItemChanged: (int currentValue) {
        _onLoading(context, currentValue);
        // var btcCoinData = await criptoCurrency.getCoinData(
        //     cryptoList[0], currenciesList[currentValue]);
        // var ethCoinData = await criptoCurrency.getCoinData(
        //     cryptoList[1], currenciesList[currentValue]);
        // var ltcCoinData = await criptoCurrency.getCoinData(
        //     cryptoList[2], currenciesList[currentValue]);
        // setState(() {
        //   selectedValue = currentValue;
        //   btcCoinExchangeValue = btcCoinData['rate'].toStringAsFixed(0);
        //   ethCoinExchangeValue = ethCoinData['rate'].toStringAsFixed(0);
        //   ltcCoinExchangeValue = ltcCoinData['rate'].toStringAsFixed(0);
        // });
      },
      diameterRatio: 2.1,
      itemExtent: 50.0,
      children: [
        for (var currency in currenciesList)
          Text(
            currency,
            style: TextStyle(color: Colors.white),
          )
      ],
    );
  }

  _onLoading(BuildContext context, newValue) {
    final CriptoCurrency criptoCurrency = CriptoCurrency();
    showIOSDialog() {
      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return CupertinoDialogAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Loading",
                      style: kdropDownItem,
                    ),
                  )
                ],
              ),
            );
          });
    }

    showAndroidDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              backgroundColor: Color(0xFF060047),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Loading",
                      style: kdropDownItem,
                    ),
                  )
                ],
              ),
            );
          });
    }

    (Platform.isIOS) ? showAndroidDialog() : showIOSDialog();
    Future.delayed(Duration(seconds: 1), () async {
      Navigator.pop(context);
      var btcCoinData = await criptoCurrency.getCoinData(cryptoList[0],
          (newValue is String) ? newValue : currenciesList[newValue]);
      var ethCoinData = await criptoCurrency.getCoinData(cryptoList[1],
          (newValue is String) ? newValue : currenciesList[newValue]);
      var ltcCoinData = await criptoCurrency.getCoinData(cryptoList[2],
          (newValue is String) ? newValue : currenciesList[newValue]);
      setState(() {
        dropDownValue = newValue;
        btcCoinExchangeValue = btcCoinData['rate'].toStringAsFixed(0);
        ethCoinExchangeValue = ethCoinData['rate'].toStringAsFixed(0);
        ltcCoinExchangeValue = ltcCoinData['rate'].toStringAsFixed(0);
      });
    });
  }
}

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    Key key,
    @required this.coinExchangeValue,
    @required this.criptoValue,
  }) : super(key: key);

  final String coinExchangeValue;
  final String criptoValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Color(0xff181A1B),
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1 $criptoValue = ",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Text(
                  "$coinExchangeValue",
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF09eab4)),
                )
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
      ),
    );
  }
}
