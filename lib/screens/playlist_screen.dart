import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_list/models/ablum_list_model.dart';
import 'package:just_audio/just_audio.dart';

import 'ablum.dart';

class PlaylistScreen extends StatefulWidget {
  PlaylistScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  String? title;
  AlbumListModel? data;
  AlbumListDataModel? playlist;

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

    try {} catch (err) {
      log('Caught error: $err');
    }

    setState(() {
      isLoading = false;
    });
  }

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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Playlist',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // if(!isLoading)
                _PlaylistInformation(),
                const SizedBox(height: 30),
                const _PlayOrShuffleSwitch(),
                if (!isLoading)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // List tempUrlList = [];
                          // for (var i = 0; i < data!.data!.length; i++) {
                          //   tempUrlList.add(data!.data![i].url);
                          // }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => Ablum(
                                  // url: tempUrlList,
                                  )));
                        },
                        child: ListTile(
                            leading: Text(
                              'ဇာတ်ပို့',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            title: Text(
                              'Wanted',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: InkWell(
                              onTap: () {
                                // List tempUrlList = [];
                                // for (var i = 0; i < data!.data!.length; i++) {
                                //   tempUrlList.add(data!.data![i].url);
                                // }
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => Ablum(
                                        // url: tempUrlList,
                                        )));
                              },
                              child: Text('Fokker'),
                            ),
                            trailing: const Icon(
                              Icons.play_circle,
                              color: Colors.white,
                            )),
                      );
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayOrShuffleSwitch extends StatefulWidget {
  const _PlayOrShuffleSwitch({Key? key}) : super(key: key);

  @override
  State<_PlayOrShuffleSwitch> createState() => __PlayOrShuffleSwitchState();
}

class __PlayOrShuffleSwitchState extends State<_PlayOrShuffleSwitch> {
  bool isPlay = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isPlay ? 0 : width * 0.45,
              child: Container(
                height: 50,
                width: width * 0.465,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                            color: isPlay ? Colors.white : Colors.deepPurple,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.play_circle,
                          color: isPlay ? Colors.white : Colors.deepPurple),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                            color: isPlay ? Colors.deepPurple : Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.shuffle,
                          color: isPlay ? Colors.deepPurple : Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistInformation extends StatefulWidget {
  _PlaylistInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<_PlaylistInformation> createState() => __PlaylistInformationState();
}

class __PlaylistInformationState extends State<_PlaylistInformation> {
  AudioPlayer audioPlayer = AudioPlayer();
  int currentIndex = 0;
  String currentImageUrl = "";
  String currentTitle = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            'https://i.pinimg.com/550x/d1/79/c5/d179c5c424ed339058effcb85c3f0f49.jpg',
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Fokker',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
