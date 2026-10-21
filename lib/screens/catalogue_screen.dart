
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../data/livres_data.dart';
import '../main.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Livre> nouveautes =
        livres.where((livre) => livre.nouveaute == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue des livres'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre Nouveautés
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Nouveautés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Liste horizontale des nouveautés
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nouveautes.length,
              itemBuilder: (context, index) {
                final Livre livre = nouveautes[index];

                return Container(
                  width: 110,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  color: livre.couleur,
                  alignment: Alignment.center,
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),

          // Titre Tout le catalogue
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: livres.length,
            itemBuilder: (context, index) {
              final Livre livre = livres[index];
              return livreTile(livre);
            },
            separatorBuilder: (context, index) {
              return const Divider(indent: 72);
            },
          ),
        ],
      ),
    );
  }
}



