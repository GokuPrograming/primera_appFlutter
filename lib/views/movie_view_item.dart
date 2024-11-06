import 'package:flutter/material.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/views/movie_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItem extends StatefulWidget {
  MovieViewItem({
    super.key,
    required this.moviesDAO,
  });

  MoviesDAO moviesDAO;
  @override
  State<MovieViewItem> createState() => _MovieViewItemState();
}

class _MovieViewItemState extends State<MovieViewItem> {
  MoviesDatabase? moviesDatabase;
  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
        // color: Color.fromARGB(123, 123, 12, 123),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  'https://th.bing.com/th/id/OIP.M6VOhw0xsP0GkT8Rq8PwIAHaEK?rs=1&pid=ImgDetMain',
                  height: 100,
                  width: 100,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(widget.moviesDAO.imgMovie!),
                    subtitle: Text(widget.moviesDAO.releaseDate!),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    WoltModalSheet.show(
                        context: context,
                        pageListBuilder: (context) => [
                              WoltModalSheetPage(
                                child: MovieView(
                                  moviesDAO: widget.moviesDAO,
                                ),
                              )
                            ]);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                    onPressed: () {
                      moviesDatabase!
                          .DELETE('tblmovies', widget.moviesDAO.idMovie!)
                          .then((value) {
                        if (value > 0) {
                          GlobalValues.banUpdateListmovies.value =
                              !GlobalValues.banUpdateListmovies.value;
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
                            type: QuickAlertType.success,
                            text: 'Something is wrong',
                            autoCloseDuration: const Duration(seconds: 2),
                            showConfirmBtn: false,
                          );
                        }
                      });
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          ],
        )
        // Text(widget.moviesDAO.imgMovie!),
        );
  }
}
