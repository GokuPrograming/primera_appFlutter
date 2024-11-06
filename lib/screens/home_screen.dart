import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024b/provider/test_provider.dart';

import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
  final testProvider = Provider.of<TestProvider>(context);
  //debemos de modificar tambien el main
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.access_alarm_outlined)),
          GestureDetector(
              onTap: () {},
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset('assets/game_icon.png')))
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 1:
              return ProfileScreen();
            default:
              return ProfileScreen();
          }
        },
      ),
      //endDrawer: Drawer(),
      drawer: myDrawer(testProvider),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
          TabItem(icon: Icons.movie,title: 'firebaseMovies')
        ],
        onTap: (int i) => setState(() {
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(key: _key, children: [
        FloatingActionButton.small(
            heroTag: "btn1",
            onPressed: () {
              GlobalValues.banThemeDark.value = false;
            },
            child: const Icon(Icons.light_mode)),
        FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: () {
              GlobalValues.banThemeDark.value = true;
            },
            child: const Icon(Icons.dark_mode))
      ]),
    );
  }

  Widget myDrawer(testProvider) {
    
    return Drawer(
      
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text(testProvider.name),
              accountEmail: Text('miCorreoXD@muchosBugs.com')),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/db'),
            title: Text('Movies List'),
            subtitle: Text('Database of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/movies'),
            title: Text('Movies database'),
            subtitle: Text('Database of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          ),
           ListTile(
            onTap: () => Navigator.pushNamed(context, '/firebaseMovies'),
            title: Text('Movies Firebase'),
            subtitle: Text('Database of movies'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
