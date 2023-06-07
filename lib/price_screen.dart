import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; // returns the current OS 

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  late bool style;
  late String image;

  @override
  void initState() {
    super.initState();
    initialScrollerStyle();
  }

  void initialScrollerStyle() {
    if (Platform.isIOS) {
      style = true;
      image = 'ios';
    } else if (Platform.isAndroid) {
      style = false;
      image = 'android';
    }
  }

  Widget? scrollerStyle(bool controller) {
    if (controller) {
      List<Text> ioStyleList = [];
      for (String item in currenciesList) {
        ioStyleList.add(Text(item));
      }
      return CupertinoPicker(
        looping: true,
        itemExtent: 30.0,
        onSelectedItemChanged: (selectedIndex) {},
        children: ioStyleList,
      );
    } else {
      List<DropdownMenuItem<String>> androidStyleList = [];
      for (String name in currenciesList) {
        androidStyleList.add(
          DropdownMenuItem(
            value: name,
            child: Text(name),
          ),
        );
      }
      return DropdownButton<String>(
          dropdownColor: Colors.blueGrey,
          value: selectedCurrency, // Starting value
          items: androidStyleList,
          onChanged: (value) {
            setState(() {
              selectedCurrency = value;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('🤑 Coin Ticker'),
        actions: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Scroll Style: ',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          IconButton(
            splashRadius: 24,
            padding: const EdgeInsets.all(4),
            icon: Image.asset('images/$image.png'),
            onPressed: () {
              setState(() {
                if (style) {
                  style = false;
                  image = 'android';
                } else {
                  style = true;
                  image = 'ios';
                }
              });
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  style = false;
                });
              },
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 BTC = ? USD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30.0),
            color: Colors.lightBlue,
            child: scrollerStyle(style),
          ),
        ],
      ),
    );
  }
}
