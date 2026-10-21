
import 'package:flutter/material.dart';
import '../models/livre.dart';
import '../data/livres_data.dart';

class MaListeScreen extends StatefulWidget {
  const MaListeScreen({super.key});

  @override
  State<MaListeScreen> createState() => _MaListeScreenState();
}

class _MaListeScreenState extends State<MaListeScreen> {
  bool _nouveautesSeulement = false;

  Map<String, bool> _genres = {
    'Roman': true,
    'Science-fiction': true,
    'Policier': true,
    'Fantasy': true,
    'Biographie': true,
  };

  // Associer une icône à chaque genre
  IconData obtenirIcone(String genre) {
    switch (genre) {
      case 'Roman':
        return Icons.menu_book;
      case 'Science-fiction':
        return Icons.science;
      case 'Policier':
        return Icons.search;
      case 'Fantasy':
        return Icons.auto_awesome;
      case 'Biographie':
        return Icons.person;
      default:
        return Icons.book;
    }
  }

  // Compter les livres de chaque genre
  int compterLivres(String genre) {
    return livres.where((livre) => livre.genre == genre).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma liste'),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            activeColor: Colors.blue,
            onChanged: (bool? valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Genres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ..._genres.keys.map((genre) {
            final int nombreLivres = compterLivres(genre);

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nombreLivres livre(s)'),
              secondary: Icon(obtenirIcone(genre)),
              activeColor: Colors.deepPurple,
              value: _genres[genre],
              onChanged: (bool? valeur) {
                setState(() {
                  _genres[genre] = valeur ?? false;
                });
              },
            );
          }),
        ],
      ),
    );
  }
}



