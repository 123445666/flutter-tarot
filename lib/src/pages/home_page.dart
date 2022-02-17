import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:parallax/parallax.dart';

import 'package:vuabian/src/pages/tutorial_cards_page.dart';
import 'package:vuabian/src/pages/single_tarot_spread_page.dart';

import 'package:vuabian/src/providers/all_deck.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';
import 'package:vuabian/src/routes/spread_routes.dart';

// INTERNATIONALIZATION
import 'package:vuabian/generated/l10n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
        child: Column(
          children: <Widget>[
            const Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/oracle.jpg'),
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
                    linkUrl:
                        'https://play.google.com/store/apps/details?id=com.mundodiferente.vuabian',
                    chooserTitle: 'Example Chooser Title');
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
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 60.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _SingleCardChoice(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SpreadSwiper(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/arcana.jpg',
                      title: S.of(context)!.tutorialMajor,
                      isMayorArcana: true,
                      startPosition: 0,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/wands.jpg',
                      title: S.of(context)!.tutorialMinorWands,
                      isMayorArcana: false,
                      startPosition: 22,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/swords.jpg',
                      title: S.of(context)!.tutorialMinorSwords,
                      isMayorArcana: false,
                      startPosition: 64,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/cups.jpg',
                      title: S.of(context)!.tutorialMinorCups,
                      isMayorArcana: false,
                      startPosition: 50,
                    ),
                    _TarotTutorial(
                      image: 'assets/images/pentacles.jpg',
                      title: S.of(context)!.tutorialMinorPentacles,
                      isMayorArcana: false,
                      startPosition: 36,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TarotTutorial extends StatelessWidget {
  final String image;
  final String title;
  final bool isMayorArcana;
  final int startPosition;

  const _TarotTutorial(
      {required this.image,
      required this.title,
      required this.isMayorArcana,
      required this.startPosition});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10.0,
        ),
        _TarotTutorialSlivers(
          image: image,
          title: title,
          page: TutorialCardsPage(
            isMayorArcana: isMayorArcana,
            startPosition: startPosition,
            title: title,
            image: image,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

@immutable
class _TarotTutorialSlivers extends StatelessWidget {
  final String image;
  final String title;
  final Widget page;

  const _TarotTutorialSlivers(
      {required this.image, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);
    final List<String> listOfImages = [image];

    return GestureDetector(
      onTap: () {
        _interstitialCounter.counter += 1;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
      child: SizedBox(
        height: 200.0,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: title,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
                  child: Parallax(
                    parallaxImages: listOfImages,
                    skewAlpha: 3.0,
                    skewBeta: 7.0,
                    height: 300.0,
                    width: 500.0,
                    paddingHorizontal: 10.0,
                    viewportFraction: 0.8,
                    circularBorder: true,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: GoogleFonts.galada(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpreadSwiper extends StatelessWidget {
  const SpreadSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    List<String> pagesTitles = [
      S.of(context)!.titleThreeCardsSpread,
      S.of(context)!.titleTreeOfLifeSpread,
      S.of(context)!.titleTrueLoveSpread,
    ];

    return SizedBox(
      width: double.infinity,
      height: 400.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                child: Image(
                  fit: BoxFit.cover,
                  color: Colors.pinkAccent,
                  colorBlendMode: BlendMode.darken,
                  image: AssetImage(
                    'assets/spreads/spread$index.jpg',
                  ),
                ),
              ),
              Center(
                child: Text(
                  pagesTitles[index],
                  style: GoogleFonts.galada(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          );
        },
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: Colors.pinkAccent,
            color: Colors.blueGrey.withOpacity(
              0.3,
            ),
          ),
        ),
        itemCount: 3,
        itemWidth: 300.0,
        itemHeight: 300.0,
        layout: SwiperLayout.STACK,
        onTap: (index) {
          _interstitialCounter.counter += 1;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => pages[index],
            ),
          );
        },
        onIndexChanged: (index) {},
      ),
    );
  }
}

class _SingleCardChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    return GestureDetector(
      onTap: () {
        _interstitialCounter.counter += 1;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SingleTarotSpreadPage(),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: 'tarot_spread',
              child: Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
//                    child: Image(
//                      fit: BoxFit.cover,
//                      color: Colors.pink,
//                      colorBlendMode: BlendMode.darken,
//                      height: 100.0,
//                      image: AssetImage(
//                        'assets/images/goddess.jpg',
//                      ),
//                    ),
                  child: Image(
                    fit: BoxFit.cover,
                    color: Colors.pinkAccent,
                    colorBlendMode: BlendMode.darken,
                    image: AssetImage(
                      'assets/images/goddess.jpg',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context)!.dailyReading,
                style: GoogleFonts.galada(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
