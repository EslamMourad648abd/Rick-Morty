import 'package:flutter/material.dart';
import 'package:untitled/data/models/characters.dart';
import 'package:untitled/preseentation/screens/characters_details.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterItem({Key? key, required this.character, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Navigating to details for: ${character.Name}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsScreen(character: character),
          ),
        );
      }, // Make the card clickable
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.white, width: 5)),
        child: Stack(
          children: [
            // Clipper for rounded borders for images wrap it and choose image borders
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/Loading.gif',
                image: character.Image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/not_found.gif', // ❌ If Image Not Found
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            // Name Overlay (Bottom)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black54, // Semi-transparent overlay
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
                child: Text(
                  character.Name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
