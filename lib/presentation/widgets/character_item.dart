import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../data/models/charachers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character? character;
  CharacterItem({Key? key, this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character!.char_id.toString(),
      child: Container(
        width: double.infinity,
        margin:const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding:const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              characterDetailsScreen,
              arguments: character,
            );
          },
          child: GridTile(
            child: Container(
              color: MyColors.grey,
              child: character!.img!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading_dots.gif',
                      image: character!.img!,
                      fit: BoxFit.cover,
                    )
                  : const Text('No image'),
            ),
            footer: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character!.name}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
