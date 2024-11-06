import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/services/popular_api.dart';

class Popularscreen extends StatefulWidget {
  const Popularscreen({super.key});
  @override
  State<Popularscreen> createState() => _PopularscreenState();
}

class _PopularscreenState extends State<Popularscreen> {
  PopularApi? popularApi;
  @override
  void initState() {
    super.initState();
    popularApi = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: popularApi!.getPopularMovies(),
          builder: (context, AsyncSnapshot<List<PopularMoviedao>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardPopular(snapshot.data![index]);
                  //     Text(snapshot.data![index].title);
                },
              );
            } else {
              if (snapshot.hasError) {
                print('el error es este');
                print(snapshot.error);
                return const Center(
                  child: Text('Something was wrong :()'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget CardPopular(PopularMoviedao popular) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detalle', arguments: popular),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular.posterPath}')),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: .7,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    popular.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  height: 50,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
