import 'dart:ffi';

class Moviesdao {
  int? idMovie;
  String? nameMovie;
  String? overview;
  String? idGenre;
  String? imgMovie;
  String? releaseDate;
  ////ell contructor puede tomar los valroes ya declarados, no como java asjaj XDXD
  /////nom permite crear un contructor con el mimso nombre, y se usa el constructor nombrado
  Moviesdao(
      {this.idMovie,
      this.nameMovie,
      this.overview,
      this.idGenre,
      this.imgMovie,
      this.releaseDate}) {}
  factory Moviesdao.fromMap(Map<String, dynamic> movie) {
    return Moviesdao(
      idGenre: movie['idGenre'],
      idMovie: movie['idMovie'],
      imgMovie: movie['imgMovie'],
      nameMovie: movie['nameMovie'],
      overview: movie['overview'],
      releaseDate: movie['releaseDate'],
    );
  }
}
