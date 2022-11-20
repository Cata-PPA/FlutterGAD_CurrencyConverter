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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      print(money);
      moneyString = money.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Currency Converter'),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/exchange.PNG'),
            Text(
              'The following amount will be converter in ' + currencyType,
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (String value) {
                setState(() {
                  if (value.length != 0) {
                    if (double.tryParse(value) == null) {
                      errorText =
                          'This is not a number. Insert amount in numbers';
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
                  icon: Icon(Icons.clear),
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
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: exchangeToDollar,
                    child: const Text('Dollar')),
                TextButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                    onPressed: exchangeToEuro,
                    child: const Text('Euro')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: convertor,
                    child: const Text('Convert Amount')),
              ],
            )
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
