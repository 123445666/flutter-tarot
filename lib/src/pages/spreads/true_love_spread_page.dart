import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vuabian/generated/l10n.dart';
import 'package:vuabian/src/widgets/drag_target_spread.dart';
import 'package:vuabian/src/widgets/tarot_deck.dart';

class TrueLoveSpreadPage extends StatefulWidget {
  final int index;

  const TrueLoveSpreadPage({Key? key, required this.index}) : super(key: key);

  @override
  _TrueLoveSpreadPageState createState() => _TrueLoveSpreadPageState();
}

class _TrueLoveSpreadPageState extends State<TrueLoveSpreadPage> {
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
          S.of(context)!.titleTrueLoveSpread,
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
                    SingleChildScrollView(
                      controller: _controller,
                      padding: const EdgeInsets.only(
                        top: 40.0,
                        bottom: 150.0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              DragTargetSpread(
                                numberOrder: 1,
                              ),
                              DragTargetSpread(
                                numberOrder: 2,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              DragTargetSpread(
                                numberOrder: 3,
                              ),
                              DragTargetSpread(
                                numberOrder: 4,
                              ),
                              DragTargetSpread(
                                numberOrder: 5,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              DragTargetSpread(
                                numberOrder: 6,
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
                          S.of(context)!.titleTrueLoveSpread,
                          style: GoogleFonts.galada(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          S.of(context)!.spreadTrueLove,
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
