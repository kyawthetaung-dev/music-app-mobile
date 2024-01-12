import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_list/api/search_list_api.dart';
import 'package:food_list/models/search_list_model.dart';
import 'package:food_list/screens/new_screen.dart';
import 'package:food_list/utils/api_const_url.dart';

class SearchHomePage extends StatefulWidget {
  const SearchHomePage({Key? key}) : super(key: key);

  @override
  State<SearchHomePage> createState() => _SearchHomePageState();
}

class _SearchHomePageState extends State<SearchHomePage> {
  SearchListModel? data;
  List<SearchListDataModel>? searchedData;
  SearchListDataModel? playlist;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      print('Awaiting user order...');
       data = await searchListApi();
       searchedData = data!.data!;
       setState(() {
      isLoading = false;
       });
    } 
    catch (err) {
      print('Caught error: Ablum is emputy $err');
    }
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<SearchListDataModel> results = [];
    log("message $enteredKeyword");
    if (enteredKeyword == "") {
      // if the search field is empty or only contains white-space, we'll display all users
      results = data!.data!;
    } else {
      results = searchedData!
          .where((e) => e.music_name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          // .where((e) => e.artist_name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchedData = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade200.withOpacity(0.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
         appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple.shade800,
          automaticallyImplyLeading: false,
          // centerTitle: false,
          title: const Text("Enjoy your favourite music",style: TextStyle(fontWeight: FontWeight.bold),),
        
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.deepPurple.shade700,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/home');
                      },
                      icon: const Icon(Icons.home)),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                         Navigator.of(context).pushNamed('play');
                      },
                      icon: const Icon(Icons.play_circle_outline)),
                  label: 'play'),
                  BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('search');
                      },
                      icon: const Icon(Icons.search_outlined)),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('profile');
                      },
                      icon: const Icon(Icons.people_outline)),
                  label: 'Profile'),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children:  [
               Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 10.0,bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey.shade400),
                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(!isLoading)
                    searchedData!.isNotEmpty ? ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchedData!.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                                Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (builder) =>NewListScreen(
                                                        index: index, 
                                                        // albImage: searchedData![index].music_name.toString(), 
                                                        albImage: "$mainUrl${searchedData![index].music_image}",
                                                        // musicId: '',
                                                        // url: "$mainUrl${searchedData![index].music_files}", 
                                                        musicName: searchedData![index].artist_name.toString(),
                                                        musicFiles: "$mainUrl${searchedData![index].music_files}", artistName: searchedData![index].music_name.toString(),
                                                        
                                                    )));
                            },
                            child:
                            Container(
                              height: 75,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade800.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(15.0),
                                  //   child: Image.network(
                                  //     "$mainUrl${searchedData![index].music_image}",
                                  //     height: 40,
                                  //     width: 40,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                              //  for (int i = 0; i<widget.index.bitLength; i++)
                              //    Text(
                              //                     '${widget.index + 1 }',
                              //                         style: Theme.of(context)
                              //                         .textTheme
                              //                         .bodyMedium!
                              //                         .copyWith(
                              //                           fontWeight: FontWeight.bold,
                              //                         ),
                              //                   ),
                                                
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    // child: searchedData!.isNotEmpty
                                    // ?
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          searchedData![index].artist_name.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          searchedData![index].music_name.toString(),
                                            style: Theme.of(context).textTheme.bodySmall!),
                                      ],
                                    )
                                    // :const Text(
                                    //   'Not results found Please try with diffrent search',
                                    //   style: TextStyle(color: Colors.white,fontSize: 20),
                                    // )
                                  ),
                                  IconButton(
                                    onPressed: () {
                              Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (builder) =>NewListScreen(
                                                        index: index, 
                                                        // albImage: searchedData![index].music_name.toString(), 
                                                        albImage: "$mainUrl${searchedData![index].music_image}",
                                                        // musicId: '',
                                                        // url: "$mainUrl${searchedData![index].music_files}", 
                                                        musicName: searchedData![index].music_name.toString(),
                                                        musicFiles: "$mainUrl${searchedData![index].music_files}", 
                                                        artistName: searchedData![index].artist_name.toString(),
                                                    )));
                            },
                                    icon: const Icon(Icons.play_circle_outline, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            // :const Text(
                            //           'Not results found Please try with diffrent search',
                            //           style: TextStyle(color: Colors.white,fontSize: 20),
                            //         )
                          );
                        })
                    ) : const Text(
                                      'Not results found Please try with diffrent search',
                                      style: TextStyle(color: Colors.white,fontSize: 20),
                                    ),
                    if(isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2,),
                    )
                  ],
                )
              )
              // _PlaylistMusic(searchId: '',)
            ],
          ),
        ),
      ),
    );
  }
}
