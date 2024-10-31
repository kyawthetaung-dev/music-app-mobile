import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_list/api/new_list_api.dart';
import 'package:food_list/api/trending_list_api.dart';
import 'package:food_list/models/new_list_model.dart';
import 'package:food_list/models/trending_list_model.dart';
import 'package:food_list/screens/home_screen.dart';
import 'package:food_list/screens/new_screen.dart';
import 'package:food_list/screens/trend_screen.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade200.withOpacity(0.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade700,
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
                        Navigator.of(context).pushNamed('play');
                      },
                      icon: const Icon(Icons.play_circle_outline)),
                  label: 'Play'),
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
                        Navigator.of(context).pushNamed('profile');
                      },
                      icon: const Icon(Icons.people_outline)),
                  label: 'Profile'),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              _NewMusic(),
              _TrendingMusic(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewMusic extends StatefulWidget {
  const _NewMusic({Key? key}) : super(key: key);

  @override
  State<_NewMusic> createState() => __NewMusicState();
}

class __NewMusicState extends State<_NewMusic> {
  NewListModel? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      log('Awaiting trend list...');
      data = await newListApi();
    } catch (err) {
      log('Caught error: Trend is empty $err');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20.0, top: 35),
            child: SectionHeader(title: 'New Music'),
          ),
          const SizedBox(height: 20),
          if (!isLoading)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NewSongCard();
                },
              ),
            ),
          // if (isLoading)
          //   const Padding(
          //     padding: EdgeInsets.only(top: 20.0),
          //     child: CircularProgressIndicator(
          //       color: Colors.black,
          //       strokeWidth: 2,
          //     ),
          //   ),
        ],
      ),
    );
  }
}

class NewSongCard extends StatefulWidget {
  NewSongCard({
    Key? key,
  }) : super(key: key);

  @override
  State<NewSongCard> createState() => _NewSongCardState();
}

class _NewSongCardState extends State<NewSongCard> {
  @override
  void initState() {
    super.initState();
    // log('message ${widget.song}');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => NewListScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/550x/d1/79/c5/d179c5c424ed339058effcb85c3f0f49.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey.shade400,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alan Walker',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fade',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.deepPurple.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendingMusic extends StatefulWidget {
  const _TrendingMusic({
    Key? key,
    // required this.songs,
  }) : super(key: key);

  // final List<Song> songs;

  @override
  State<_TrendingMusic> createState() => _TrendingMusicState();
}

class _TrendingMusicState extends State<_TrendingMusic> {
  TrendListModel? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      log('Awaiting trend list...');
      data = await trendListApi();
    } catch (err) {
      log('Caught error: Trend is empty $err');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 30.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20.0, top: 35),
            child: SectionHeader(title: 'Trending Music'),
          ),
          const SizedBox(height: 20),
          if (!isLoading)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SongCard();
                },
              ),
            ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
        ],
      ),
    );
  }
}

class SongCard extends StatefulWidget {
  SongCard({
    Key? key,
  }) : super(key: key);

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  void initState() {
    super.initState();
    // log('message ${widget.song}');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (builder) => TrendListScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/550x/d1/79/c5/d179c5c424ed339058effcb85c3f0f49.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey.shade400,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Travis Scott',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'FE!N',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.deepPurple.shade300,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
