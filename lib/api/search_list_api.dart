import 'dart:convert';

import 'package:food_list/models/search_list_model.dart';
import 'package:http/http.dart' as http;

searchListApi() async {
  // var url = Uri.parse("https://music-d.rayhub.online/api/search/music/list/$searchId");
  var url = Uri.parse("http://music-d.rayhub.online/api/music/list");

  final response = await http.get(
    url
  );

  var data = json.decode(response.body);
  // print(data);

  List<SearchListDataModel> searchListData = [];
  if(data["data"] == []) {
    SearchListDataModel dummyData = SearchListDataModel(
      music_image: "", 
      music_name: "", 
      music_files: "",
      artist_name:""
    );

    searchListData.add(dummyData);
  } else {
    for(int i = 0; i <  data["data"].length; i++) {
      SearchListDataModel realData = SearchListDataModel(
        music_image: data["data"][i]["music_image"]==null?"":data["data"][i]["music_image"], 
        music_name: data["data"][i]["music_name"]==null?"":data["data"][i]["music_name"], 
        music_files: data["data"][i]["music_files"]==null?"":data["data"][i]["music_files"],
        artist_name: data["data"][i]["artist_name"]==null?"": data["data"][i]["artist_name"]
      );
      searchListData.add(realData);
    }
  }
  
  SearchListModel searchList = SearchListModel(
    code: data["code"], 
    message: data["message"], 
    data: searchListData
  );

  return searchList;
}