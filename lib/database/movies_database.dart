import 'dart:io';
import 'dart:ui';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:primerapp/models/moviesdao.dart';
import 'package:sqflite/sqflite.dart';

class MoviesDatabase {
  static final NAMEDB = 'MOVIESSB';
  static final VERSION = 1;
  static Database? _database;
  //generar el getter que esta apuntando a una base de datos
  Future<Database> get database async
  //cuando se manda la conexion debe de ir de manera asyncrona, con un future
  {
    //si ya existe la conexion, retornara la conexion
    if (database != null) return _database!;
    //si es nulo, pues inicializa la conexion a la base de datos
    return _database = await initDAtabase();
  }

  Future<Database> initDAtabase() async {
    Directory folder = await getApplicationCacheDirectory();
    String path = join(folder.path, NAMEDB);
    //db es el objeto y la version es la version de la base de datos
    //apunta a la ubicacion del archivo que almacena la base de datos
    return openDatabase(
      path,
      version: VERSION,
      onCreate: (db, version) {
//creacion de la base de dadtos
        String query = '''
create table tblgenre(
idGenre char (1) PRIMARY KEY,
dscgenre varchar(50)
);

create table tblmovies(
      idMovie INTEGER PRIMARY KEY,
      nameMovie VARCHAR(100),
      overview TEXT,
      idGenre char(1),
      imageMovie varchar(150),
      releaseDate char(10),
      constraint movie_genero_fk foreign key(idGenre) references tblgenre(idGenre)
      )''';
        db.execute(query);
      },
    );
  }

  ///init database
  // ignore: non_constant_identifier_names
  Future<int> Insert(String table, Map<String, dynamic> row) async {
    var con = await database;
    return await con.insert(table, row);
  }

  // ignore: non_constant_identifier_names
  Future<int> Update(String table, Map<String, dynamic> row) async {
    var con = await database;
    return await con.update(
      table,
      row,
      where: 'idMovie=?',
      whereArgs: [
        row['id_movie'],
      ],
    );
  }

  Future<int> Delete(String table, int idMovie) async {
    var con = await database;
    return await con.delete(table, where: 'idMovie=?', whereArgs: [idMovie]);
  }

  Future<List<Moviesdao>> Select() async {
    var con = await database;
    var result = await con.query('tblmovies');
    return  result
        .map(
          (movie) => Moviesdao.fromMap(movie),
        )
        .toList();
  }
}
