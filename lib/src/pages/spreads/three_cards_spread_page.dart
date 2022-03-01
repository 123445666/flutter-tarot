import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vuabian/generated/l10n.dart';
import 'package:vuabian/src/widgets/drag_target_spread.dart';
import 'package:vuabian/src/widgets/tarot_deck.dart';

import 'package:provider/provider.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';

class ThreeCardsSpreadPage extends StatefulWidget {
  final int index;

  const ThreeCardsSpreadPage({Key? key, required this.index}) : super(key: key);

  @override
  _ThreeCardsSpreadPageState createState() => _ThreeCardsSpreadPageState();
}

class _ThreeCardsSpreadPageState extends State<ThreeCardsSpreadPage> {
  bool accepted = false;
  GlobalKey<FlipCardState> spreadKey = GlobalKey<FlipCardState>();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        actions: <Widget>[
          FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.pinkAccent,
            onPressed: () {
              spreadKey.currentState?.toggleCard();
            },
            child: const Icon(
              Icons.info,
            ),
          ),
        ],
        title: Text(
          S.of(context)!.titleThreeCardsSpread,
          style: GoogleFonts.galada(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            fit: BoxFit.cover,
            color: Colors.pinkAccent,
            colorBlendMode: BlendMode.darken,
            image: AssetImage(
              'assets/spreads/spread${widget.index}.jpg',
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              flipOnTouch: false,
              key: spreadKey,
              front: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: SingleChildScrollView(
                        controller: _controller,
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          bottom: 150.0,
                        ),
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const <Widget>[
                            DragTargetSpread(
                              numberOrder: 1,
                            ),
                            DragTargetSpread(
                              numberOrder: 2,
                            ),
                            DragTargetSpread(
                              numberOrder: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      child: TarotDeck(),
                    ),
                  ],
                ),
              ),
              back: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(
                      30.0,
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.pink, BlendMode.darken),
                        image: AssetImage('assets/images/tarotback.png'),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          S.of(context)!.titleThreeCardsSpread,
                          style: GoogleFonts.galada(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          S.of(context)!.spreadThreeCards,
                          style: GoogleFonts.galada(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
