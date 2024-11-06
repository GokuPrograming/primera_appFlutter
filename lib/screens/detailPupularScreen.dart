import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:provider/provider.dart';

class Detailpupularscreen extends StatefulWidget {
  const Detailpupularscreen({super.key});

  @override
  State<Detailpupularscreen> createState() => _DetailpupularscreenState();
}

class _DetailpupularscreenState extends State<Detailpupularscreen> {
  @override
  Widget build(BuildContext context) {
      final testProvider = Provider.of<TestProvider>(context);

    final popular =
        ModalRoute.of(context)?.settings.arguments as PopularMoviedao;
    return Scaffold(
        body: Container(
          
      decoration: BoxDecoration(
          image: DecorationImage(
              opacity: 3,
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${popular.posterPath}'))),
      child: FloatingActionButton(
      
        onPressed: ()=>testProvider.name='Zacarias Flores del campo'
        ,
      ),
    ));
  }
}
