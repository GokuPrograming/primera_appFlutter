import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/firebase/database_movies.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/views/movie_view_item.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

// ignore: must_be_immutable
class NewMovieViewsFirebase extends StatefulWidget {
  final String? uid;
  NewMovieViewsFirebase({super.key, this.moviesDAO, this.uid});
  MoviesDAO? moviesDAO;
  @override
  State<NewMovieViewsFirebase> createState() => _MovieViewState();
}

class _MovieViewState extends State<NewMovieViewsFirebase> {
  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();
  TextEditingController conId = TextEditingController();
  DatabaseMovies dbMovies = DatabaseMovies();

  @override
  void initState() {
    super.initState();
    dbMovies;
    if (widget.moviesDAO != null) {
      // conId.text = widget.moviesDAO!.idMovie! as String;
      conName.text = widget.moviesDAO!.nameMovie!;
      conOverview.text = widget.moviesDAO!.overview!;
      conImgMovie.text = widget.moviesDAO!.imgMovie!;
      conRelease.text = widget.moviesDAO!.releaseDate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: const InputDecoration(hintText: 'Nombre de la película'),
    );
    final txtOverview = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: const InputDecoration(hintText: 'Sinapsis de la película'),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: const InputDecoration(hintText: 'Poster de la película'),
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: conRelease,
      decoration: const InputDecoration(hintText: 'Fecha de lanzamiento'),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2050));

        if (pickedDate != null) {
          String formatDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          conRelease.text = formatDate;
          setState(() {});
        }
      },
    );

    final btnSave = ElevatedButton(
      onPressed: () {

        if (widget.moviesDAO == null) {
          dbMovies.insertar({
            "nameMovie": conName.text,
            "overview": conOverview.text,
            "imgMovie": conImgMovie.text,
            "releaseDate": conRelease.text
          }).then((value) {
            if (value) {
              ///con el streambuilder ya no se necesita usar usar el valueNotifier
              // GlobalValues.banUpdateListmovies.value =
              //     !GlobalValues.banUpdateListmovies.value;
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Transaction Completed Successfully!',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false,
              );
            } else {
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Something was wrong! :()',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false,
              );
            }
          });
        } else {
          dbMovies.Update({
            "nameMovie": conName.text,
            "overview": conOverview.text,
            "imgMovie": conImgMovie.text,
            "releaseDate": conRelease.text
          }, '${widget.uid}')
              .then((value) {
            final msj;
            QuickAlertType type = QuickAlertType.success;
            if (value) {
              GlobalValues.banMoviemientoActualizar.value =
                  !GlobalValues.banMoviemientoActualizar.value;
              type = QuickAlertType.success;
              msj = 'si jalo pa';
              // autoCloseDuration: const Duration(seconds: 2),
              // showConfirmBtn: false,
            } else {
              type = QuickAlertType.error;
              msj = 'No jalo la actualizacion pa';
            }
            return QuickAlert.show(
              context: context,
              type: type,
              text: msj,
              autoCloseDuration: const Duration(seconds: 2),
              showConfirmBtn: false,
            );
          });
          ;
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
      child: const Text('Guardar'),
    );

    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [txtNameMovie, txtOverview, txtImgMovie, txtRelease, btnSave],
    );
  }
}
