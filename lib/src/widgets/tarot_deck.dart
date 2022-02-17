import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuabian/src/providers/all_deck.dart';
import 'package:vuabian/src/providers/current_index.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';
import 'package:card_swiper/card_swiper.dart';

class TarotDeck extends StatefulWidget {
  @override
  _TarotDeckState createState() => _TarotDeckState();
}

class _TarotDeckState extends State<TarotDeck>
    with SingleTickerProviderStateMixin {
  late ScrollController controller;
  late AnimationController animationController;
  late Animation animation;

  bool myBool = false;

  late int _numOfCards;

  late List allCards;

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    _numOfCards =
        Provider.of<AllDeck>(context, listen: false).allDeck ? 78 : 22;
    allCards = List<int>.generate(_numOfCards, (int) => int);

    controller = ScrollController(
      initialScrollOffset: 10.0,
      keepScrollOffset: true,
    ); // NEW

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(
        // NEW
        controller.position.maxScrollExtent, // NEW
        duration: const Duration(milliseconds: 1000), // NEW
        curve: Curves.linear, // NEW
      );
    });
  }

  int randomChoice = 0;

  int getRand() {
    randomChoice = (allCards..shuffle()).first;
    return randomChoice;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CurrentIndexProvider>(context);
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    int myData = 0;
    animationController.forward();

    return FadeTransition(
      opacity: animationController,
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: const RotatedBox(
          quarterTurns: 1,
        ),
      ),
    );
  }
}
