import 'dart:convert';

import 'package:food_list/models/music_list_model.dart';
import 'package:http/http.dart' as http;

albumListApi() async {
  var url = Uri.parse("https://music-d.rayhub.online/api/album/list");

  final response = await http.get(
    url
  );

  var data = json.decode(response.body);
  // print(data);

  List<MusicListDataModel> musicListData = [];
  if(data["data"] == []) {
    MusicListDataModel dummyData = MusicListDataModel(
      albImage: "", 
      albName: "", 
      music_count: "",
      alb_id: 0
    );

    musicListData.add(dummyData);
  } else {
    for(int i = 0; i <  data["data"].length; i++) {
      MusicListDataModel realData = MusicListDataModel(
        albImage: data["data"][i]["alb_image"]==null?"":data["data"][i]["alb_image"], 
        albName: data["data"][i]["alb_name"]==null?"": data["data"][i]["alb_name"], 
        music_count: data["data"][i]["music_count"]==null?"": data["data"][i]["music_count"].toString(),
        alb_id: data["data"][i]["alb_id"]==null?"":data["data"][i]["alb_id"]
      );
      musicListData.add(realData);
    }
  }
  
  MusicListModel musicList = MusicListModel(
    code: data["code"], 
    message: data["message"], 
    data: musicListData
  );

  // print("MusicList : $musicList");

  return musicList;
}