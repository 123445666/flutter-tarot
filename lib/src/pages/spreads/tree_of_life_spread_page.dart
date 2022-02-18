import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vuabian/generated/l10n.dart';
import 'package:vuabian/src/widgets/drag_target_spread.dart';
import 'package:vuabian/src/widgets/tarot_deck.dart';

import 'package:provider/provider.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';

class TreeOfLifeSpread extends StatefulWidget {
  final int index;

  const TreeOfLifeSpread({Key? key, required this.index}) : super(key: key);

  @override
  _TreeOfLifeSpreadState createState() => _TreeOfLifeSpreadState();
}

class _TreeOfLifeSpreadState extends State<TreeOfLifeSpread> {
  bool accepted = false;
  GlobalKey<FlipCardState> spreadKey = GlobalKey<FlipCardState>();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

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
          S.of(context)!.titleTreeOfLifeSpread,
          style: GoogleFonts.galada(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.purple],
              ),
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
                    SingleChildScrollView(
                      controller: _controller,
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        bottom: 150.0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: const <Widget>[
                              SizedBox(
                                height: 65.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 3,
                              ),
                              DragTargetSpread(
                                numberOrder: 5,
                              ),
                              DragTargetSpread(
                                numberOrder: 8,
                              ),
                            ],
                          ),
                          Column(
                            children: const <Widget>[
                              DragTargetSpread(
                                numberOrder: 1,
                              ),
                              DragTargetSpread(
                                numberOrder: 6,
                              ),
                              DragTargetSpread(
                                numberOrder: 9,
                              ),
                              DragTargetSpread(
                                numberOrder: 10,
                              ),
                            ],
                          ),
                          Column(
                            children: const <Widget>[
                              SizedBox(
                                height: 65.0,
                              ),
                              DragTargetSpread(
                                numberOrder: 2,
                              ),
                              DragTargetSpread(
                                numberOrder: 4,
                              ),
                              DragTargetSpread(
                                numberOrder: 7,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
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
                          S.of(context)!.titleTreeOfLifeSpread,
                          style: GoogleFonts.galada(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          S.of(context)!.spreadTreeOfLife,
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
