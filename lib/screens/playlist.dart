import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_list/api/new_list_api.dart';
import 'package:food_list/api/trending_list_api.dart';
import 'package:food_list/models/new_list_model.dart';
import 'package:food_list/models/trending_list_model.dart';
import 'package:food_list/screens/home_screen.dart';
import 'package:food_list/screens/new_screen.dart';
import 'package:food_list/screens/trend_screen.dart';
import 'package:food_list/utils/api_const_url.dart';

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
       
    } 
    catch (err) {
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
            padding:  EdgeInsets.only(right: 20.0,top: 35),
            child: SectionHeader(title: 'New Music'),
          ),
          const SizedBox(height: 20),
          if(!isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data!.data!.length,
              itemBuilder: (context, index) {
                return NewSongCard(index: index, newsong: data!.data![index],);
              },
            ),
          ),
          if(isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2,),
          ),
           
        ],
      ),
    );
  }
}

class NewSongCard extends StatefulWidget {
  NewListDataModel? newsong;
  int index;
   NewSongCard({
    Key? key,
    required this.newsong,
    required this.index,
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
        Navigator.of(context).push(
          MaterialPageRoute(builder: (builder) =>NewListScreen(
            index: widget.index, 
            musicName: widget.newsong!.musicName.toString(),
            artistName: widget.newsong!.artistName.toString(), 
            albImage: "$mainUrl${widget.newsong!.albImage}",
            musicFiles: "$mainUrl${widget.newsong!.musicFiles}",
            
          ))
        );
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
                      "$mainUrl${widget.newsong!.albImage}",
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
                        widget.newsong!.artistName.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.newsong!.musicName.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.deepPurple.shade300, fontWeight: FontWeight.bold),
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
       
    } 
    catch (err) {
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
            padding:  EdgeInsets.only(right: 20.0,top: 35),
            child: SectionHeader(title: 'Trending Music'),
          ),
          const SizedBox(height: 20),
          if(!isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data!.data!.length,
              itemBuilder: (context, index) {
                return SongCard(index: index, trendsong: data!.data![index],);
              },
            ),
          ),
          if(isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2,),
          )
        ],
      ),
    );
  }
}

class SongCard extends StatefulWidget {
  TrendListDataModel? trendsong;
  int index;
   SongCard({
    Key? key,
    required this.trendsong,
    required this.index,
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
        Navigator.of(context).push(
          MaterialPageRoute(builder: (builder) =>TrendListScreen(
            index: widget.index, 
            musicName: widget.trendsong!.musicName.toString(),
            artistName: widget.trendsong!.artistName.toString(), 
            albImage: "$mainUrl${widget.trendsong!.albImage}",
            musicFiles: "$mainUrl${widget.trendsong!.musicFiles}",
            
          ))
        );
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
                      "$mainUrl${widget.trendsong!.albImage}",
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
                        widget.trendsong!.artistName.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.trendsong!.musicName.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.deepPurple.shade300, fontWeight: FontWeight.bold),
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


