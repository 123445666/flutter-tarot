import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:vuabian/src/providers/all_deck.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';

// INTERNACIONALIZATION
import 'package:vuabian/generated/l10n.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _allDeckChoice = Provider.of<AllDeck>(context);
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text(
          'Tarot',
          style: GoogleFonts.galada(
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/oracle.jpg'),
                ),
              ),
              ListTile(
                enabled: true,
                title: Text(
                  S.of(context)!.optionHome,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(
                  S.of(context)!.useAllCards,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                trailing: Switch.adaptive(
                  value: _allDeckChoice.allDeck,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    _allDeckChoice.allDeck = value;
                  },
                ),
              ),
              ListTile(
                title: Text(
                  S.of(context)!.onlyUprightReading,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                trailing: Switch.adaptive(
                  value: _allDeckChoice.onlyUpright,
                  activeColor: Colors.pinkAccent,
                  onChanged: (value) {
                    _allDeckChoice.onlyUpright = value;
                  },
                ),
              ),
              ListTile(
                title: Text(
                  S.of(context)!.optionShare,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  FlutterShare.share(
                      title: 'Tarot App',
                      text: 'Example share text',
                      linkUrl: 'https://play.google.com/store/apps/details?id=com.mundodiferente.tarotcardapp',
                      chooserTitle: 'Example Chooser Title'
                  );
                },
              ),
              ListTile(
                title: Text(
                  S.of(context)!.privacyPolicy,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  Navigator.pop(context);
                  //_displayDialog(context);
                },
              ),
              ListTile(
                title: Text(
                  S.of(context)!.optionExit,
                  style: GoogleFonts.galada(color: Colors.pinkAccent),
                ),
                onTap: () {
                  //SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlipCard(
              fill: Fill.fillBack,
              // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.HORIZONTAL,
              // default
              front: Container(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Image(
                    fit: BoxFit.cover,
                    width: 200.0,
                    image: AssetImage(
                      //'assets/images/back.jpeg',
                      'assets/images/tarotback.png',
                    ),
                  ),
                ),
              ),
              back: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image(
                  fit: BoxFit.cover,
                  width: 200.0,
                  image: AssetImage(
                    //'assets/images/back.jpeg',
                    'assets/images/2.jpg',
                  ),
                ),
              ),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
