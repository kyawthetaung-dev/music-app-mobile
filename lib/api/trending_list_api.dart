import 'dart:convert';

import 'package:food_list/models/music_list_model.dart';
import 'package:http/http.dart' as http;

import '../models/trending_list_model.dart';

trendListApi() async {
  var url = Uri.parse("https://music-d.rayhub.online/api/music/trend/list");

  final response = await http.get(
    url
  );

  var data = json.decode(response.body);
  // print(data);

  List<TrendListDataModel> trendListData = [];
  if(data["data"] == []) {
    TrendListDataModel dummyData = TrendListDataModel(
      albImage: "", 
      artistName: "", 
      musicName: "",
      musicFiles: ""
    );

    trendListData.add(dummyData);
  } else {
    for(int i = 0; i <  data["data"].length; i++) {
      TrendListDataModel realData = TrendListDataModel(
        albImage: data["data"][i]["alb_image"]==null?"":data["data"][i]["alb_image"], 
        artistName: data["data"][i]["artist_name"]==null?"":data["data"][i]["artist_name"], 
        musicName: data["data"][i]["music_name"]==null?"": data["data"][i]["music_name"].toString(),
        musicFiles: data["data"][i]["music_files"]==null?"":data["data"][i]["music_files"]
      );
      trendListData.add(realData);
    }
  }
  
  TrendListModel trendList = TrendListModel(
    code: data["code"], 
    message: data["message"], 
    data: trendListData
  );

  // print("trendList : $trendList");

  return trendList;
}