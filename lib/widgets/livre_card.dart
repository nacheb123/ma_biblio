
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../main.dart';
import '../screens/detail_screen.dart';

class LivreCard extends StatelessWidget {
  final Livre livre;

  const LivreCard({
    super.key,
    required this.livre,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.grey,
      color: Colors.white,
      surfaceTintColor: Colors.blue,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(livre: livre),
            ),
          );
        },
        child: livreTile(livre),
      ),
    );
  }
}




