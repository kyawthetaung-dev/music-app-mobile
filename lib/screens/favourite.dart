import 'package:flutter/material.dart';

class FavouritePlay extends StatefulWidget {
  const FavouritePlay({Key? key}) : super(key: key);

  @override
  State<FavouritePlay> createState() => _FavouritePlayState();
}

class _FavouritePlayState extends State<FavouritePlay> {
  List<int> userno = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<String> username = [
    "May",
    "Sai Htee Saing",
    "Garay Han",
    "Wai La",
    "Bunny Phyoe",
    "Sai Sai Kham Hlaing",
    "Po Po",
    "Ni Ni Khin Zaw",
    "Ye Yint Aung"
  ];
  List<String> songname = [
    "I love you",
    "I hate you",
    "I lose you",
    "fucking life",
    "hfofmsfs;;sfh",
    "yjfgtfllgg",
    "tfltfnff",
    "tfofmflslh",
    "Ya Par Tay"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade300.withOpacity(0.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: Column(
            children: [
              Container(
                child: AppBar(
                  backgroundColor: Colors.deepPurple.shade800,
                  centerTitle: true,
                  title: const Text(
                    'Favourite',
                    style: TextStyle(color: Colors.white),
                  ),
                 
                ),
                
              ),
              
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.music_note,
                          size: 32,
                        ),
                        color: Colors.purple,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star_border_outlined,
                          size: 32,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.circle_notifications,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
         bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.deepPurple.shade700,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/home');
                      },
                      icon: const Icon(Icons.home)),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('favourite');
                      },
                      icon: const Icon(Icons.favorite_outline)),
                  label: 'Favourite'),
                  BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('search');
                      },
                      icon: const Icon(Icons.search_outlined)),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                         Navigator.of(context).pushNamed('play');
                      },
                      icon: const Icon(Icons.play_circle_outline)),
                  label: 'Play'),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('profile');
                      },
                      icon: const Icon(Icons.people_outline)),
                  label: 'Profile'),
            ]),
        body: ListView.builder(
            itemCount: username.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
              //  padding: const EdgeInsets.only(bottom: 20),
                onPressed: () {
      
                },
                child: ListTile(
                  // shape: const Border(
                  //   bottom: BorderSide(color: Color.fromARGB(255, 207, 205, 205)),
                  // ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade400,
                    child: Text(
                      userno[index].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    username[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    songname[index],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_rounded),
                    color: Colors.white,
                  ),
                ),
              );
            }),
      ),
    );
  }
}

