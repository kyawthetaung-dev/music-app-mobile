class Song {
  final String? url;
  final String? name;
  final String? artist;
  final String? icon;
  final String? album;
  final Duration? duration;
  Song({this.url, this.name, this.artist, this.icon, this.album, this.duration});
}

class SongDatabase {
  static List<Song> songList = [
    Song(
        url: "https://music-d.rayhub.online/assets/music/Double J/nii_nii_way_way.mp3",
        name: "Song 2",
        artist: "Artist 2",
        duration: Duration(minutes: 7, seconds: 5),
        icon:
            "https://i.pinimg.com/originals/1f/c6/69/1fc66962352f4f2cdef41af009215cc4.jpg",
        album: "Album 2"),
    Song(
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
        name: "Song 3",
        duration: Duration(minutes: 5, seconds: 44),
        artist: "Artist 3",
        icon:
            "https://i.pinimg.com/736x/ea/1f/64/ea1f64668a0af149a3277db9e9e54824.jpg",
        album: "Album 3"),
    Song(
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
        name: "Song 4",
        artist: "Artist 4",
        duration: Duration(minutes: 5, seconds: 2),
        icon:
            "https://magazine.artland.com/wp-content/uploads/2020/02/Webp.net-compress-image-67-1.jpg",
        album: "Album 4")
  ];
}