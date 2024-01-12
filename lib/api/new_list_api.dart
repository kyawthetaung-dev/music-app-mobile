import 'dart:convert';

import 'package:food_list/models/music_list_model.dart';
import 'package:food_list/models/new_list_model.dart';
import 'package:http/http.dart' as http;

import '../models/trending_list_model.dart';

newListApi() async {
  var url = Uri.parse("https://music-d.rayhub.online/api/music/new/list");

  final response = await http.get(
    url
  );

  var data = json.decode(response.body);
  // print(data);

  List<NewListDataModel> newListData = [];
  if(data["data"] == []) {
    NewListDataModel dummyData = NewListDataModel(
      albImage: "", 
      artistName: "", 
      musicName: "",
      musicFiles: ""
    );

    newListData.add(dummyData);
  } else {
    for(int i = 0; i <  data["data"].length; i++) {
      NewListDataModel realData = NewListDataModel(
        albImage: data["data"][i]["alb_image"]==null?"":data["data"][i]["alb_image"], 
        artistName: data["data"][i]["artist_name"]==null?"": data["data"][i]["artist_name"], 
        musicName: data["data"][i]["music_name"]==null?"": data["data"][i]["music_name"].toString(),
        musicFiles: data["data"][i]["music_files"]==null?"": data["data"][i]["music_files"]
      );
      newListData.add(realData);
    }
  }
  
  NewListModel newList = NewListModel(
    code: data["code"], 
    message: data["message"], 
    data: newListData
  );

  // print("trendList : $trendList");

  return newList;
}