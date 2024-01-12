
class NewListModel{
  int? code;
  String? message;
  List<NewListDataModel>? data;

  NewListModel({
    required this.code,
    required this.message,
    required this.data
  });

}

class NewListDataModel{
  String? albImage;
  String? artistName;
  String? musicName;
  String? musicFiles;

  NewListDataModel({
    required this.albImage,
    required this.artistName,
    required this.musicName,
    required this.musicFiles
  });

  get data => null;
}