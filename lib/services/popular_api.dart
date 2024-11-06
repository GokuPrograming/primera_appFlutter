import 'package:dio/dio.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';

class PopularApi {
  final dio = Dio();
  Future<List<PopularMoviedao>> getPopularMovies() async {
    String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=052ff25c66e82692ddc28fcea03247e2&languaje=es-MX&page=1';
    //5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1
    final response = await dio.get(url);
    //se parcio la lista
    final res = response.data['results'] as List;
// Se lo pasamos a una lista
    return res.map((popular) => PopularMoviedao.fromMap(popular)).toList();
  }
}
