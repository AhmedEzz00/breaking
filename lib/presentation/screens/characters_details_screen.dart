import 'dart:math';

import '../../business%20logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/charachers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character? character;
  CharactersDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: MyColors.grey,
      expandedHeight: size.height * 0.8,
      pinned: true,
      stretch: true,
      shadowColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            character!.nickname!,
            style: TextStyle(color: MyColors.white),
            textAlign: TextAlign.start,
          ),
          background: Hero(
            tag: character!.char_id.toString(),
            child: Image.network(
              character!.img!,
              fit: BoxFit.cover,
            ),
          )),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: MyColors.yellow,
      height: 30.0,
      endIndent: 20,
      thickness: 2,
      indent: 20,
    );
  }

  Widget chexkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
       return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).charQuotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: MyColors.white, shadows: [
            Shadow(
              blurRadius: 7,
              color: MyColors.yellow,
              offset: Offset(0, 0),
            ),
          ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator(){
    return const Center(
      child: CircularProgressIndicator(
        color:MyColors.yellow
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllQuotes(character!.name!);
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo(
                    'Job: ',
                    character!.occupation!.join(' / '),
                  ),
                  buildDivider(),
                  characterInfo(
                    'Appeared in: ',
                    character!.category!,
                  ),
                  buildDivider(),
                  characterInfo(
                    'Seasons: ',
                    character!.appearance!.join(' / '),
                  ),
                  buildDivider(),
                  characterInfo(
                    'Status: ',
                    character!.status!,
                  ),
                  buildDivider(),
                  character!.better_call_saul_appearance!.isEmpty
                      ? Container()
                      : characterInfo('Better call soul seasons: ',
                          character!.better_call_saul_appearance!.join(' / ')),
                  character!.better_call_saul_appearance!.isEmpty
                      ? Container()
                      : buildDivider(),
                  characterInfo(
                    'Actor / Actress: ',
                    character!.name!,
                  ),
                  buildDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50.0,
                    child: BlocBuilder<CharactersCubit, CharactersState>(
                      builder: (context, state) {
                        return chexkIfQuotesAreLoaded(state);
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0,)
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}



