import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase/database_movies.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/views/movie_view.dart';
import 'package:pmsn2024b/views/new_movie_Views_firebase.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItemFirebase extends StatefulWidget {
  const MovieViewItemFirebase(
      {super.key,
      required this.moviesDAO,
      // ignore: non_constant_identifier_names
      required this.Uid});

  final MoviesDAO moviesDAO;
  // ignore: prefer_typing_uninitialized_variables
  final Uid;
  @override
  State<MovieViewItemFirebase> createState() => _MovieViewItemFirebaseState();
}

class _MovieViewItemFirebaseState extends State<MovieViewItemFirebase> {
  DatabaseMovies? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = DatabaseMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.moviesDAO.imgMovie!,
                height: 100,
                width: 100,
              ),
              Expanded(
                child: ListTile(
                  title: Text(widget.moviesDAO.nameMovie!),
                  subtitle: Text(widget.moviesDAO.releaseDate!),
                ),
              ),
              IconButton(
                onPressed: () {
                  WoltModalSheet.show(
                    context: context,
                    pageListBuilder: (context) => [
                      WoltModalSheetPage(
                        child: NewMovieViewsFirebase(
                            moviesDAO: widget.moviesDAO,uid: widget.Uid),
                      ),
                    ],
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  moviesDatabase!.eliminar(widget.Uid).then((value) {
                    if (value) {
                      // GlobalValues.banUpdateListmovies.value =
                      //     !GlobalValues.banUpdateListmovies.value;
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Deleted successfully!',
                        autoCloseDuration: const Duration(seconds: 2),
                        showConfirmBtn: false,
                      );
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        text: 'Deletion failed',
                        autoCloseDuration: const Duration(seconds: 2),
                        showConfirmBtn: false,
                      );
                    }
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
