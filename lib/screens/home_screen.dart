import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_list/api/music_list_api.dart';
import 'package:food_list/api/trending_list_api.dart';
import 'package:food_list/models/music_list_model.dart';
import 'package:food_list/models/trending_list_model.dart';
import 'package:food_list/screens/playlist_screen.dart';
import 'package:food_list/screens/trend_screen.dart';
import 'package:food_list/utils/api_const_url.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          elevation: 0,
          backgroundColor: Colors.deepPurple.shade800,
          automaticallyImplyLeading: false,
          // centerTitle: true,
          title: const Text("Welcome"),
        
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
           children: [
              // const _DiscoverMusic(),
              _TrendingMusic(),
              _PlaylistMusic()
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaylistMusic extends StatefulWidget {
  const _PlaylistMusic({
    Key? key,
  }) : super(key: key);

  

  @override
  State<_PlaylistMusic> createState() => _PlaylistMusicState();
}

class _PlaylistMusicState extends State<_PlaylistMusic> {
  MusicListModel? data;
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
      print('Awaiting user order...');
       data = await albumListApi();
       setState(() {
      isLoading = false;
       });
    } 
    catch (err) {
      print('Caught error: Ablum is emputy $err');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.all(20.0),
      child: Column(
        
        children: [
          const SectionHeader(title: 'Ablum'),
          if(!isLoading)
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 20),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data!.data!.length,
              itemBuilder: ((context, index) {
                return PlaylistCard(index: index, playlist: data!.data![index]);
              })),
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

class PlaylistCard extends StatefulWidget {
  int index;
  MusicListDataModel? playlist;
  PlaylistCard({Key? key, required this.playlist,required this.index}) : super(key: key);
  
  @override
  State<PlaylistCard> createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {

  @override
  void initState() {
    super.initState();
    log('message ${widget.playlist}');
  }
  @override
  Widget build(BuildContext context) {
       return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (builder) =>PlaylistScreen(
            index: widget.index, 
            albName: widget.playlist!.albName.toString(), 
            albImage: "$mainUrl${widget.playlist!.albImage}",
            albId: widget.playlist!.alb_id.toString(),
            
          ))
        );
      },
      child: 
      widget.playlist!.albImage == null 
      ? null 
      :
       Container(
        height: 75,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                "$mainUrl${widget.playlist!.albImage}",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.playlist!.albName.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text("${widget.playlist!.music_count} songs",
                      style: Theme.of(context).textTheme.bodySmall!),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (builder) =>PlaylistScreen(
            index: widget.index, 
            albName: widget.playlist!.albName.toString(), 
            albImage: "$mainUrl${widget.playlist!.albImage}",
            albId: widget.playlist!.alb_id.toString(),
            
          ))
        );
      },
              icon: const Icon(Icons.more_vert, color: Colors.white),
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
      
      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: Column(
        children: [
          // const Padding(
          //   padding:  EdgeInsets.only(right: 20.0,top: 50.0),
          //   child: Text( 'Welcome',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,), ),
          // ),
           const Padding(
            padding:  EdgeInsets.only(right: 20.0,top: 20.0),
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

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.action = 'View More',
  }) : super(key: key);

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
            action,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white)),
      ],
    );
  }
}

// class _DiscoverMusic extends StatelessWidget {
//   const _DiscoverMusic({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Welcome', style: Theme.of(context).textTheme.bodyLarge),
//           const SizedBox(height: 5),
//           Text(
//             'Enjoy your favorite music',
//             style: Theme.of(context)
//                 .textTheme
//                 .headline6!
//                 .copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           // TextFormField(
//           //   style: const TextStyle(color: Colors.black),
//           //   onTap: (){
//           //     // showSearch(context: context, delegate: Search());
//           //   },
//           //   decoration: InputDecoration(
//           //       isDense: true,
//           //       filled: true,
//           //       fillColor: Colors.white,
//           //       hintText: 'Search',
//           //       hintStyle: Theme.of(context)
//           //           .textTheme
//           //           .bodyMedium!
//           //           .copyWith(color: Colors.grey.shade400),
//           //       prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
//           //       border: OutlineInputBorder(
//           //         borderRadius: BorderRadius.circular(15.0),
//           //         borderSide: BorderSide.none,
//           //       )),
//           // )
//         ],
//       ),
//     );
//   }
// }

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}