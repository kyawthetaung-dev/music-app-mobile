import 'dart:convert';

import 'package:food_list/models/ablum_list_model.dart';
import 'package:http/http.dart' as http;

ablumLssistApi(String ablumId) async {
  var url = Uri.parse("https://music-d.rayhub.online/api/album/detail/list/$ablumId");

  final response = await http.get(
    url
  );

  var data = json.decode(response.body);
  // print(data);

  List<AlbumListDataModel> albumListData = [];
  if(data["data"] == []) {
    AlbumListDataModel dummyData = AlbumListDataModel(
      alb_image: "",
      alb_name: "", 
      artist_name: "", 
      music_name: "",
      url:""
    );

    albumListData.add(dummyData);
  } else {
    for(int i = 0; i <  data["data"].length; i++) {
      AlbumListDataModel realData = AlbumListDataModel(
        alb_image: data["data"][i]["alb_image"]==null?"":data["data"][i]["alb_image"],
        alb_name: data["data"][i]["alb_name"]==null?"":data["data"][i]["alb_name"], 
        artist_name: data["data"][i]["artist_name"]==null?"": data["data"][i]["artist_name"], 
        music_name: data["data"][i]["music_name"]==null?"":data["data"][i]["music_name"],
        url: data["data"][i]["music_files"]==null?"":data["data"][i]["music_files"]
      );
      albumListData.add(realData);
    }
  }
  
  AlbumListModel albumList = AlbumListModel(
    code: data["code"], 
    message: data["message"], 
    data: albumListData
  );

  // print("AlbumList : $albumList");

  return albumList;
}