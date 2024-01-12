
class SearchListModel{
  int? code;
  String? message;
  List<SearchListDataModel>? data;

  SearchListModel({
    required this.code,
    required this.message,
    required this.data
  });


}

class SearchListDataModel{
  String? music_image;
  String? music_name;
  String? music_files;
  String? artist_name;

  SearchListDataModel({
    required this.music_files,
    required this.music_image,
    required this.music_name,
    required this.artist_name
  });
}