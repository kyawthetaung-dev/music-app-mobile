
class TrendListModel{
  int? code;
  String? message;
  List<TrendListDataModel>? data;

  TrendListModel({
    required this.code,
    required this.message,
    required this.data
  });

}

class TrendListDataModel{
  String? albImage;
  String? artistName;
  String? musicName;
  String? musicFiles;

  TrendListDataModel({
    required this.albImage,
    required this.artistName,
    required this.musicName,
    required this.musicFiles
  });

  get data => null;
}