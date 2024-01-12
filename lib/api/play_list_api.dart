import 'dart:convert';

import 'package:food_list/models/music_list_model.dart';
import 'package:food_list/models/play_list_model.dart';
import 'package:http/http.dart' as http;

playListApi(String musicId) async {
  var url = Uri.parse("https://music-d.rayhub.online/api/music/new/detail/list/$musicId");

  final response = await http.get(
    url
  );

  var data = json.decode(response.body);
  // print(data);

  List<PlayListDataModel> playListData = [];
  if(data["data"] == []) {
    PlayListDataModel dummyData = PlayListDataModel(
      musicName: "", 
      artistName: "", 
      musicFiles: "",
      musicImage: ""
    );

    playListData.add(dummyData);
  } else {
    for(int i = 0; i <  data["data"].length; i++) {
      PlayListDataModel realData = PlayListDataModel(
        musicImage: data["data"][i]["music_image"]==null?"": data["data"][i]["music_image"], 
        artistName: data["data"][i]["artist_name"]==null?"":  data["data"][i]["artist_name"], 
        musicName: data["data"][i]["music_name"]==null?"": data["data"][i]["music_name"],
        musicFiles: data["data"][i]["music_files"]==null?"": data["data"][i]["music_files"]
      );
      playListData.add(realData);
    }
  }
  
  PlayListModel playList = PlayListModel(
    code: data["code"], 
    message: data["message"], 
    data: playListData
  );

  // print("MusicList : $musicList");

  return playList;
}