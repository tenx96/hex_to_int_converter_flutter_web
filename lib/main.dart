import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hex to Int Converter'),
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
  String hexString = "";
  Color previewColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      hexString = text;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a hex color here'),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    hexString.toColor().isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: hexString));

                              final snackBar = SnackBar(
                                  content: Text('Copied To Clipboard'));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: Icon(Icons.copy),
                            iconSize: 20,
                            splashRadius: 20,
                          )
                        : Container(),
                    SizedBox(
                      width: 10,
                    ),
                    SelectableText(hexString.toColor(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Color(0xFF2196f3))),
                    SizedBox(
                      width: 10,
                    ),
                    hexString.toColor().isNotEmpty ? Expanded(
                      child: Container(
                        height: 50,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(16.0),
                          boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),],
                          color: Color(int.parse(hexString.toColor())),
                        ),
                      ),
                    ) : Container()
                  ],
                ),
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

extension ColorExtension on String {
  String toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return "0x$hexColor".toLowerCase();
    } else {
      return "";
    }
  }
}
