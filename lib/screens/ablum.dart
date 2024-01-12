// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:food_list/models/ablum_list_model.dart';
import 'package:food_list/models/play_list_model.dart';
import 'package:food_list/utils/api_const_url.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../utils/database.dart';
import '../widgets/widgets.dart';

MediaItem mediaItem = MediaItem(
    id: SongDatabase.songList[0].url!,
    title: SongDatabase.songList[0].name!,
    artUri: Uri.parse(SongDatabase.songList[0].icon!),
    album: SongDatabase.songList[0].album,
    duration: SongDatabase.songList[0].duration,
    artist: SongDatabase.songList[0].artist
);

int current = 0;

_backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    AudioServiceBackground.setState(controls: [
      MediaControl.skipToPrevious,
      MediaControl.pause,
      MediaControl.stop,
      MediaControl.skipToNext,
    ], systemActions: [
      MediaAction.seek
    ], playing: true, processingState: AudioProcessingState.loading);
    // Connect to the URL
    await _audioPlayer.setUrl(mediaItem.id);
    AudioServiceBackground.setMediaItem(mediaItem);
    // Now we're ready to play
    _audioPlayer.play();
    // Broadcast that we're playing, and what controls are available.
    AudioServiceBackground.setState(controls: [
      MediaControl.pause,
      MediaControl.stop,
      MediaControl.skipToNext,
      MediaControl.skipToPrevious
    ], systemActions: [
      MediaAction.seek
    ], playing: true, processingState: AudioProcessingState.ready);
  }

  @override
  Future<void> onStop() async {
    AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.ready);
    await _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.setState(controls: [
      MediaControl.pause,
      MediaControl.stop,
      MediaControl.skipToNext,
      MediaControl.skipToPrevious
    ], systemActions: [
      MediaAction.seek
    ], playing: true, processingState: AudioProcessingState.ready);
    await _audioPlayer.play();
    return super.onPlay();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(controls: [
      MediaControl.play,
      MediaControl.stop,
      MediaControl.skipToNext,
      MediaControl.skipToPrevious
    ], systemActions: [
      MediaAction.seek
    ], playing: false, processingState: AudioProcessingState.ready);
    await _audioPlayer.pause();
    return super.onPause();
  }

  @override
  Future<void> onSkipToNext() async {
    if (current < SongDatabase.songList.length - 1)
      current = current + 1;
    else
      current = 0;
    mediaItem = MediaItem(
        id: SongDatabase.songList[current].url!,
        title: SongDatabase.songList[current].name!,
        artUri: Uri.parse(SongDatabase.songList[current].icon!),
        album: SongDatabase.songList[current].album,
        duration: SongDatabase.songList[current].duration,
        artist: SongDatabase.songList[current].artist);
    AudioServiceBackground.setMediaItem(mediaItem);
    await _audioPlayer.setUrl(mediaItem.id);
    AudioServiceBackground.setState(position: Duration.zero);
    return super.onSkipToNext();
  }

  @override
  Future<void> onSkipToPrevious() async {
    if (current != 0)
      current = current - 1;
    else
      current = SongDatabase.songList.length - 1;
    mediaItem = MediaItem(
        id: SongDatabase.songList[current].url!,
        title: SongDatabase.songList[current].name!,
        artUri: Uri.parse(SongDatabase.songList[current].icon!),
        album: SongDatabase.songList[current].album,
        duration: SongDatabase.songList[current].duration,
        artist: SongDatabase.songList[current].artist);
    AudioServiceBackground.setMediaItem(mediaItem);
    await _audioPlayer.setUrl(mediaItem.id);
    AudioServiceBackground.setState(position: Duration.zero);
    return super.onSkipToPrevious();
  }

  @override
  Future<void> onSeekTo(Duration position) {
    _audioPlayer.seek(position);
    AudioServiceBackground.setState(
      position: position,
    );
    return super.onSeekTo(position);
  }
}

class Ablum extends StatefulWidget {
  int index;
  String? albName;
  String? musicName;
  String? albImage;
  String? musicId;
  String? url;
  
  Ablum({Key? key,required this.url,required this.index,required this.musicId,required this.albName, required this.musicName, required this.albImage,}) : super(key: key);

  @override
  State<Ablum> createState() => _AblumState();
}

class _AblumState extends State<Ablum> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayListModel? data;
  PlayListDataModel? song;
  bool _isFavourite = false;

  int currentIndex = 0;
  String currentImageUrl = "";
  String currentTitle = "";
  String currentMusic = "";
  String musciID = "";
  String url = ""; 
  Duration? dura;
        
  @override
  void initState() {
    super.initState();
  
    currentIndex = widget.index;
    currentImageUrl = widget.albImage!;
    currentMusic = widget.musicName!;
    currentTitle = widget.albName!;
    musciID = widget.musicId!;
    url = widget.url!;
    // log(url);

    setAudioSource();
  }

  Future<void> setAudioSource() async {
    // audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      
      // AudioSource.uri(Uri.parse('$mainUrl$url')),
    // ]));
    // audioPlayer.play(); 
    try {
      Duration? duration = await audioPlayer.setUrl('$mainUrl$url');
      print('MP3 file duration: ${duration!.inSeconds} seconds');
      dura = Duration(seconds: duration.inSeconds);
      log(dura.toString());
    } catch (e) {
      print('Error getting MP3 file duration: $e');
    }
    SongDatabase.songList = [
      Song(
        url: '$mainUrl$url',
        name: widget.musicName,
        artist: widget.albName,
        duration: dura,
        icon: "${widget.albImage}",
        album: widget.albName
      )
    ];
    // if (AudioService.running) {
      await AudioService.skipToNext();
      await AudioService.play();
    // } else {
      await AudioService.start(
        backgroundTaskEntrypoint: _backgroundTaskEntrypoint,
      );
    // }
  }

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
      body: AudioServiceWidget(
        child: Stack(
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
                 icon: _isFavourite
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
                _isFavourite = !_isFavourite;
              });
            },                
              )
            ],
          ),
          const SizedBox(height: 30),
          
          // StreamBuilder<Duration>(
          //   stream: AudioService.positionStream,
          //   builder: (_, snapshot) {
          //     if (!snapshot.hasData || snapshot.data == null) {
          //       return Slider(
          //         value: 0,
          //         min: 0,
          //         max: AudioService.currentMediaItem!.duration!.inSeconds.toDouble(),
          //         onChanged: null,
          //       );
          //     }

          //     final mediaState = snapshot.data!;
          //     return Slider(
          //       value: mediaState.inSeconds.toDouble(),
          //       min: 0,
          //       max: AudioService.currentMediaItem!.duration!.inSeconds.toDouble(),
          //       onChanged: (val) {
          //         final newPosition = Duration(seconds: val.toInt());
          //         AudioService.seekTo(newPosition);
          //       },
          //     );
          //   },
          // ),
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
                onPressed: () {
                  AudioService.skipToPrevious();
                },
                iconSize: 40,
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ));
          },
        ),
        StreamBuilder<PlaybackState>(
                      stream: AudioService.playbackStateStream,
                      builder: (context, snapshot) {
                        final playing = snapshot.data?.playing ?? false;
                        if (playing)
                          return IconButton(
                              icon: Icon(Icons.pause_circle_outline, color: Colors.white,),
                              iconSize: 55,
                              onPressed: () {
                                AudioService.pause();
                              });
                        else
                          return IconButton(
                              icon: Icon(Icons.play_circle_outline, color: Colors.white,),
                              iconSize: 55,
                              onPressed: () {
                                  AudioService.play();
                              });
                      }),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
                onPressed: () {
                  AudioService.skipToNext();
                },
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
