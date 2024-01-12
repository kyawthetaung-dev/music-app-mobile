
class AlbumListModel{
  int? code;
  String? message;
  List<AlbumListDataModel>? data;

  AlbumListModel({
    required this.code,
    required this.message,
    required this.data
  });

}

class AlbumListDataModel{
  String? alb_image;
  String? alb_name;
  String? artist_name;
  String? music_name;
  String? url;

  AlbumListDataModel({
    required this.alb_image,
    required this.alb_name,
    required this.artist_name,
    required this.music_name,
    required this.url
  });

  get data => null;
}