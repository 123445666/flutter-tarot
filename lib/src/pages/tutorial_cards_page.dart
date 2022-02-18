import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vuabian/generated/l10n.dart';
import 'package:vuabian/src/pages/single_card_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';

class TutorialCardsPage extends StatefulWidget {
  final String title;
  final bool isMayorArcana;
  final int startPosition;
  final String image;

  const TutorialCardsPage({Key? key, required this.title, required this.isMayorArcana, required this.startPosition, required this.image}) : super(key: key);

  @override
  _TutorialCardsPageState createState() => _TutorialCardsPageState();
}

class _TutorialCardsPageState extends State<TutorialCardsPage> {
  @override
  Widget build(BuildContext context) {
    final _interstitialCounter = Provider.of<InterstitialCounter>(context);
    int currentIndex;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        title: Text(
          widget.title,
          style: GoogleFonts.galada(),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(widget.image),
          ),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: Colors.pinkAccent,
          ),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      S.of(context)!.instructionsClick,
                      style: GoogleFonts.galada(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                      ),
                      crossAxisCount: 4,
                      itemCount: widget.isMayorArcana ? 22 : 14,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          _interstitialCounter.counter += 1;
                          currentIndex = index + widget.startPosition;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SingleCardDetailPage(
                                index: currentIndex,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(
                                    3.0,
                                    3.0,
                                  ),
                                  blurRadius: 16.0,
                                  spreadRadius: 4.0,
                                ),
                              ],
                            ),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/${index + widget.startPosition}.jpg'),
                            ),
                          ),
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          const StaggeredTile.extent(2, 300),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
