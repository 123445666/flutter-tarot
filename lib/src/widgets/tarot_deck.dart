import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuabian/src/providers/all_deck.dart';
import 'package:vuabian/src/providers/current_index.dart';
import 'package:deckscrollviewsafety/index.dart';

class TarotDeck extends StatefulWidget {
  const TarotDeck({Key? key}) : super(key: key);

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
    allCards = List<int>.generate(_numOfCards, (int numCard) => numCard);

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

    int myData = 0;
    animationController.forward();

    return FadeTransition(
      opacity: animationController,
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: RotatedBox(
          quarterTurns: 1,
          child: DeckScrollView.useDelegate(
            layoutPow: 2.5,
            itemExtent: 95,
            controller: controller,
            clipToSize: true,
            physics: BouncingScrollPhysics(),
            childDelegate: DeckChildBuilderDelegate(
              builder: (context, index) => Draggable<int>(
                maxSimultaneousDrags: 1,
                affinity: Axis.vertical,
                onDragStarted: () {
                  currentIndex.currentIndex = getRand();
                },
                onDraggableCanceled: (vel, off) {
                  setState(() {});
                },
                onDragCompleted: () {
                  setState(() {
                    myData = randomChoice;
                    allCards.remove(randomChoice);
                  });
                },
                data: myData,
                childWhenDragging: Container(),
                feedback: RotatedBox(
                  quarterTurns: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 3, color: Color(0x44000000))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image(
                        height: 150.0,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          //'assets/images/back.jpeg',
                          'assets/images/tarotback.png',
                        ),
                      ),
                    ),
                  ),
                ),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF9c0c74),
                      boxShadow: [
                        BoxShadow(blurRadius: 3, color: Color(0x44000000))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          //'assets/images/back.jpeg',
                          'assets/images/tarotback.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              childCount: allCards.length,
            ),
          ),
        ),
      ),
    );
  }
}
