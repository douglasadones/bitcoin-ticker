import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  bool style = true;

  List<DropdownMenuItem<String>> getCurrenciesItems() {
    List<DropdownMenuItem<String>> androidStyleList = [];
    for (String name in currenciesList) {
      androidStyleList.add(
        DropdownMenuItem(
          value: name,
          child: Text(name),
        ),
      );
    }
    return androidStyleList;
  }

  List<Widget> getListIosStyle() {
    List<Widget> ioStyleList = [];
    for (String item in currenciesList) {
      ioStyleList.add(Text(item));
    }
    return ioStyleList;
  }

  Widget? scrollerStyle(bool controller) {
    if (controller) {
      return CupertinoPicker(
        looping: true,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          // ignore: avoid_print
          print(selectedIndex);
        },
        children: getListIosStyle(),
      );
    } else {
      return DropdownButton<String>(
          dropdownColor: Colors.blueGrey,
          value: selectedCurrency, // Starting value
          items: getCurrenciesItems(),
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
        title: const Center(
          child: Text('🤑 Coin Ticker'),
        ),
        actions: [
          const Text(
            'Style: ',
            textAlign: TextAlign.end,
            
          ),
          Switch(
            value: style,
            onChanged: (value) {
              setState(() {
                style = value;
              });
            },
          ),
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

// DropdownButton<String>(
//                 dropdownColor: Colors.blueGrey,
//                 value: selectedCurrency, // Starting value
//                 items: getCurrenciesItems(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCurrency = value;
//                   });
//                 }),


// CupertinoPicker(
//               looping: true,
//               itemExtent: 32.0,
//               onSelectedItemChanged: (selectedIndex) {
//                 // ignore: avoid_print
//                 print(selectedIndex);
//               },
//               children: getListIosStyle(),
//             ),