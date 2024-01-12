import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_list/models/ablum_list_model.dart';
import 'package:food_list/models/new_list_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../widgets/widgets.dart';


class NewListScreen extends StatefulWidget {
  int index;
  String? artistName;
  String? albImage;
  String? musicName;
  String musicFiles;
  NewListScreen({Key? key, required this.musicFiles,required this.index,required this.musicName,required this.artistName, required this.albImage,}) : super(key: key);

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  NewListModel? data;
  NewListDataModel? song;
  bool _isFavorite = false;

        int currentIndex = 0;
        String currentImageUrl = "";
        String currentTitle = "";
        String currentMusic = "";
        String musciID = "";
        String url = "";

  @override
  void initState() {
    super.initState();
  
    currentIndex = widget.index;
    currentImageUrl = widget.albImage!;
    currentMusic = widget.musicName!;
    currentTitle = widget.artistName!;
    url = widget.musicFiles;
    log(musciID);

    audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      
      AudioSource.uri(Uri.parse(url)),
      
    ]));
    audioPlayer.play();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });

       @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            currentImageUrl,
            fit: BoxFit.cover,
          ),
          const BackgroundFilter(),
          musicPlayer(),
        ],
      ),
    );
  }

  Widget musicPlayer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentMusic,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentTitle,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
              IconButton(
                 icon: _isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },                
              )
            ],
          ),
          const SizedBox(height: 30),
          StreamBuilder<SeekBarData>(
              stream: _seekBarDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChanged: audioPlayer.seek,
                );
              }),
          playerButton(),
        ],
      ),
    );
  }

  Widget playerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
                onPressed: audioPlayer.hasPrevious ? () {
                  audioPlayer.seekToPrevious();
                  setState(() { 
                    currentIndex = currentIndex - 1;
                     currentIndex as AlbumListDataModel?;
                    // song = Song.songs[currentIndex] as AlbumListDataModel?;
                    // currentImageUrl = widget.albImage!;
                    
                   });
                } : null,
                iconSize: 40,
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ));
          },
        ),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playerState = snapshot.data;
                final processingState = playerState!.processingState;

                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    width: 64.0,
                    height: 64.0,
                    margin: const EdgeInsets.all(10.0),
                    child: const CircularProgressIndicator(),
                  );
                } else if (!audioPlayer.playing) {
                  return IconButton(
                    onPressed: audioPlayer.play,
                    iconSize: 75,
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(
                      Icons.pause_circle,
                      color: Colors.white,
                    ),
                    iconSize: 75.0,
                    onPressed: audioPlayer.pause,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.replay_circle_filled_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 75.0,
                    onPressed: () => audioPlayer.seek(
                      Duration.zero,
                      index: audioPlayer.effectiveIndices!.first,
                    ),
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
                onPressed: audioPlayer.hasNext ? () {
                  audioPlayer.seekToNext();
                  setState(() { 
                    currentIndex = currentIndex + 1;
                    // song = Song.songs[currentIndex] as AlbumListDataModel?;
                    // currentImageUrl = song!.alb_image!;
                    currentIndex as AlbumListDataModel?;
                    // currentImageUrl = widget.albImage!;
                  });
                } : null,
                iconSize: 40,
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ));
          },
        ),
      ],
    );
  }
}


class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade200,
                Colors.deepPurple.shade800,
              ]),
        ),
      ),
    );
  }
}
