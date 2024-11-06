import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase/database_movies.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/views/movie_view_item_firebase.dart';
import 'package:pmsn2024b/views/new_movie_Views_firebase.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreenFirebase extends StatefulWidget {
  const MoviesScreenFirebase({super.key});

  @override
  State<MoviesScreenFirebase> createState() => _MoviesScreenFirebaseState();
}

class _MoviesScreenFirebaseState extends State<MoviesScreenFirebase> {
  late DatabaseMovies databaseMovies;

  @override
  void initState() {
    super.initState();
    databaseMovies = DatabaseMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        actions: [
          IconButton(
            onPressed: () {
              WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) =>
                    [WoltModalSheetPage(child: NewMovieViewsFirebase())],
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
        stream: databaseMovies.Select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Ocurrió un error al cargar los datos.'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay películas disponibles.'));
          } else {
            var movies = snapshot.data!.docs;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movieData = movies[index];
                return MovieViewItemFirebase(
                  moviesDAO: MoviesDAO.fromMap(
                    {
                      'idMovie': 0,
                      'imgMovie': movieData.get('imgMovie'),
                      'nameMovie': movieData.get('nameMovie'),
                      'overview': movieData.get('overview'),
                      'releaseDate': movieData.get('releaseDate').toString(),
                      ////hay que checar por que lo manda como date, y lo tenemos como char
                    },
                  ),
                  Uid: movieData.id,
                );
              },
            );
          }
        },
      ),
    );
  }
}
