import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vuabian/generated/l10n.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';
import 'package:vuabian/src/widgets/drag_target_spread.dart';
import 'package:vuabian/src/widgets/tarot_deck.dart';

class SingleTarotSpreadPage extends StatefulWidget {
  const SingleTarotSpreadPage({Key? key}) : super(key: key);

  @override
  _SingleTarotSpreadPageState createState() => _SingleTarotSpreadPageState();
}

class _SingleTarotSpreadPageState extends State<SingleTarotSpreadPage> {

  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          title: Text(
            S.of(context)!.dailyReading,
            style: GoogleFonts.galada(),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Hero(
                    tag: 'tarot_spread',
                    child: Image(
                      color: Colors.pinkAccent,
                      colorBlendMode: BlendMode.darken,
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                        'assets/images/goddess.jpg',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150.0,
                  width: 95.0,
                  child: DragTargetSpread(
                    autoDetail: true,
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 0.0,
              child: TarotDeck(),
            ),
          ],
        ),
      ),
    );
  }
}
