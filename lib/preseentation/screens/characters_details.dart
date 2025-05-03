import 'package:flutter/material.dart';
import 'package:untitled/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        // To handle overflow issues
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Ensure image is full width
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  character.Image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    character.Name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Character Details
            Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow("Status:", character.StatusIfDeadOrAlive),
                  buildDetailRow("Species:", character.Species),
                  if (character.Type.isNotEmpty)
                    buildDetailRow("Type:", character.Type),
                  buildDetailRow("Gender:", character.Gender),
                  buildDetailRow("Location:", character.Location),
                  buildDetailRow("Episodes:",
                      character.EpisodeAppearance.length.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to display details
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}