import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vuabian/src/pages/single_card_detail_page.dart';
import 'package:vuabian/src/providers/current_index.dart';
import 'package:vuabian/src/providers/all_deck.dart';

class DragTargetSpread extends StatefulWidget {
  final int? numberOrder;
  final bool? autoDetail;

  const DragTargetSpread({Key? key, this.numberOrder, this.autoDetail})
      : super(key: key);

  @override
  _DragTargetSpreadState createState() => _DragTargetSpreadState();
}

class _DragTargetSpreadState extends State<DragTargetSpread> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _AuxModel(),
      child: DragTargetInstance(
        numberOrder: widget.numberOrder,
        autoDetail: widget.autoDetail,
      ),
    );
  }
}

class DragTargetInstance extends StatefulWidget {
  final int? numberOrder;
  final bool? autoDetail;

  const DragTargetInstance(
      {Key? key, this.numberOrder, this.autoDetail})
      : super(key: key);

  @override
  _DragTargetInstanceState createState() => _DragTargetInstanceState();
}

class _DragTargetInstanceState extends State<DragTargetInstance>
    with SingleTickerProviderStateMixin {
  bool _accepted = false;
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  final _random = Random().nextInt(21);
  late bool _orientation;

  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    _orientation = Provider.of<AllDeck>(context, listen: false).onlyUpright;

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CurrentIndexProvider>(context);
    final goToPage = Provider.of<_AuxModel>(context);
    animationController.forward();

    return SizedBox(
      height: 130.0,
      width: 70.0,
      child: !_accepted
          ? DragTarget<int>(
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                goToPage.goToPage = currentIndex.currentIndex;
                Future<FlipCardState>.delayed(
                    const Duration(milliseconds: 1200), () {
                  return Future.value(_cardKey.currentState);
                })
                  ..then((myVar) {
                    myVar.toggleCard();
                  })
                  ..then((val) {
                    if (widget.autoDetail == true) {
                      Future.delayed(const Duration(milliseconds: 1200), () {
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SingleCardDetailPage(
                              index: goToPage.goToPage,
                            ),
                          ),
                        );
                      });
                    }
                  });

                _accepted = true;
              },
              builder: (context, accepted, rejected) {
                return Stack(
                  children: <Widget>[
                    FadeTransition(
                      opacity: animationController,
                      child: const RotatedBox(
                        quarterTurns: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Image(
                            fit: BoxFit.cover,
                            color: Colors.grey,
                            colorBlendMode: BlendMode.hardLight,
                            image: AssetImage(
                              'assets/images/tarotback.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.numberOrder}',
                        style: GoogleFonts.galada(
                          color: Colors.black,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SingleCardDetailPage(
                      index: goToPage.goToPage,
                    ),
                  ),
                );
              },
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: false,
                key: _cardKey,
                front: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Color(0x44000000))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Stack(
                    children: <Widget>[
                      const RotatedBox(
                        quarterTurns: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/tarotback.png',
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.numberOrder}',
                          style: GoogleFonts.galada(
                            color: Colors.pink,
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                back: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 7, color: Color(0x44000000))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Stack(
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: _orientation
                              ? 4
                              : _random % 2 == 0
                                  ? 2
                                  : 4,
                          child: Image(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              //'assets/images/back.jpeg',
                              'assets/images/${goToPage.goToPage}.jpg',
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.numberOrder}',
                            style: GoogleFonts.galada(
                              color: Colors.pink,
                              fontSize: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _AuxModel with ChangeNotifier {
  int _goToPage = 0;

  int get goToPage => _goToPage;

  set goToPage(int value) {
    _goToPage = value;
    notifyListeners();
  }
}
