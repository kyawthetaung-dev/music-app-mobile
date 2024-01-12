
class PlayListModel{
  int? code;
  String? message;
  List<PlayListDataModel>? data;

  PlayListModel({
    required this.code,
    required this.message,
    required this.data
  });


}

class PlayListDataModel{
  String? musicImage;
  String? artistName;
  String? musicName;
  String? musicFiles;

  PlayListDataModel({
    required this.musicImage,
    required this.artistName,
    required this.musicName,
    required this.musicFiles
  });
}