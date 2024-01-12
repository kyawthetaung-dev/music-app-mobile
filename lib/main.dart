import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:food_list/screens/playlist.dart';
import 'package:food_list/screens/search_home_screen.dart';
import 'package:food_list/screens/user_profile.dart';
import 'package:food_list/screens/favourite.dart';
import 'package:food_list/screens/ablum.dart';
import 'package:food_list/screens/login_screen.dart';
import 'package:food_list/screens/register_screen.dart';
import 'package:food_list/screens/home_screen.dart';
import 'package:food_list/screens/playlist_screen.dart';
import 'package:get/get.dart';


Future<void> main() async{
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'music app',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        )
      ), 
      home: AudioServiceWidget(child:HomeScreen()),
      getPages : [
        GetPage(name: '/login', page: () => const LoginProfile()),
        GetPage(name: '/signin', page: () => const SignInPage()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/search', page: () => const SearchHomePage()),
        GetPage(name: '/profile', page: () => const UserProfile()),
        GetPage(name: '/favourite', page: () => const FavouritePlay()),
        GetPage(name: '/playlist', page: () =>   PlaylistScreen(index:0,albName: '', albImage: "",albId: '',)),
        GetPage(name: '/ablum', page: () =>  Ablum(index: 0,musicId: '', albName: '', musicName: '', albImage: '', url: "",)),
        GetPage(name: '/play', page: () => const PlayList()),
      ],
    );
  }
}