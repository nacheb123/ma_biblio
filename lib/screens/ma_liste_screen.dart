
import 'package:flutter/material.dart';
import '../data/livres_data.dart';
import '../models/livre.dart';

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

  int compterLivres(String genre) {
    return livres.where((livre) => livre.genre == genre).length;
  }

  bool? get etatTousLesGenres {
    if (_genres.values.every((selectionne) => selectionne)) {
      return true;
    }

    if (_genres.values.every((selectionne) => !selectionne)) {
      return false;
    }

    return null;
  }

  void modifierTousLesGenres(bool? valeur) {
    setState(() {
      final bool cocher = valeur != true;
      _genres.updateAll((genre, ancienEtat) => cocher);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtrer les livres selon les genres et les nouveautés
    final List<Livre> livresFiltres = livres.where((livre) {
      final bool genreSelectionne = _genres[livre.genre] ?? false;
      final bool nouveauteValide =
          !_nouveautesSeulement || livre.nouveaute;

      return genreSelectionne && nouveauteValide;
    }).toList();

    // Compter les livres lus parmi les livres affichés
    final int nombreLus =
        livresFiltres.where((livre) => livre.lu).length;

    final int nombreAffiches = livresFiltres.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lus : $nombreLus / $nombreAffiches'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxListTile(
            title: const Text('Afficher uniquement les nouveautés'),
            value: _nouveautesSeulement,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.blue,
            onChanged: (bool? valeur) {
              setState(() {
                _nouveautesSeulement = valeur ?? false;
              });
            },
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Genres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          CheckboxListTile(
            title: const Text('Tous les genres'),
            tristate: true,
            value: etatTousLesGenres,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.deepPurple,
            onChanged: modifierTousLesGenres,
          ),

          ..._genres.keys.map((genre) {
            final int nombreLivres = compterLivres(genre);

            return CheckboxListTile(
              title: Text(genre),
              subtitle: Text('$nombreLivres livre(s)'),
              secondary: Icon(obtenirIcone(genre)),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.deepPurple,
              value: _genres[genre],
              onChanged: (bool? valeur) {
                setState(() {
                  _genres[genre] = valeur ?? false;
                });
              },
            );
          }),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Livres',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: livresFiltres.length,
              itemBuilder: (context, index) {
                final Livre livre = livresFiltres[index];

                return CheckboxListTile(
                  title: Text(
                    livre.titre,
                    style: TextStyle(
                      decoration: livre.lu
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    '${livre.auteur} – ${livre.annee}',
                  ),
                  value: livre.lu,
                  secondary: CircleAvatar(
                    backgroundColor: livre.couleur,
                    child: const Icon(
                      Icons.menu_book,
                      color: Colors.white,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green,
                  onChanged: (bool? valeur) {
                    setState(() {
                      livre.lu = valeur ?? false;
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 72);
              },
            ),
          ),
        ],
      ),
    );
  }
}







