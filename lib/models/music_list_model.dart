
class MusicListModel{
  int? code;
  String? message;
  List<MusicListDataModel>? data;

  MusicListModel({
    required this.code,
    required this.message,
    required this.data
  });


}

class MusicListDataModel{
  String? albImage;
  String? albName;
  String? music_count;
  int? alb_id;

  MusicListDataModel({
    required this.albImage,
    required this.albName,
    required this.music_count,
    required this.alb_id
  });
}