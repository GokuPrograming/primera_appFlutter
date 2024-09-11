import 'package:flutter/material.dart';
import 'package:primerapp/database/movies_database.dart';
import 'package:primerapp/models/moviesdao.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // MoviesDatabase moviesDb = MoviesDatabase();
  late MoviesDatabase moviesDb;
  @override
  void initState() {
    //carga antes de que renderice
    // TODO: implement initState
    moviesDb = MoviesDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LISTA DE PELICULAS'),
      ),
      body: FutureBuilder(
        future: moviesDb.Select(),

        ///esta conxumiendo en segundo plano el select
        //

        builder: (context, AsyncSnapshot<List<Moviesdao>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {},
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Upps!! un errro al cargar la data'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}
