import 'package:flutter/material.dart';

void main() {
  runApp(ExchangeApp());
}

class ExchangeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double money = 0;
  double conversionFactor = 1;
  double leiAmount = 0;
  String moneyString = '0';
  String currencyType = 'Lei';
  String? errorText;
  TextEditingController controller = TextEditingController();

  void exchangeToEuro() {
    setState(() {
      currencyType = 'Euro';
      conversionFactor = 4.92;
    });
  }

  void exchangeToDollar() {
    setState(() {
      currencyType = 'Dollar';
      conversionFactor = 4.77;
    });
  }

  void convertor() {
    setState(() {
      money = conversionFactor * leiAmount;
      moneyString = money.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Currency Converter'),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/exchange.PNG'),
            Text(
              'The following amount will be converter in ' + currencyType,
            ),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (String value) {
                setState(() {
                  if (value.isNotEmpty) {
                    if (double.tryParse(value) == null) {
                      errorText = 'This is not a number. Insert amount in numbers';
                    } else {
                      if (double.tryParse(value)! < 0) {
                        errorText = 'Insert a positive amount';
                      } else {
                        leiAmount = double.tryParse(value)!;
                        errorText = null;
                      }
                    }
                  } else {
                    leiAmount = double.tryParse(value)!;
                    errorText = null;
                  }
                });
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter amount here',
                errorText: errorText,
                suffixIcon: IconButton(
                  onPressed: controller.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            Text(
              moneyString,
              style: Theme.of(context).textTheme.headline4,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: exchangeToDollar,
                  child: const Text('Dollar'),
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: exchangeToEuro,
                  child: const Text('Euro'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: convertor,
                  child: const Text('Convert Amount'),
                ),
              ],
            )
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
