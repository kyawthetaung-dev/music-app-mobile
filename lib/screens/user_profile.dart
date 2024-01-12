import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade300.withOpacity(0.8),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple.shade800,
          centerTitle: true,
          title: const Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                icon: Icon(Icons.people))
          ],
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
                        Navigator.of(context).pushNamed('/');
                      },
                      icon: const Icon(Icons.home)),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('play');
                      },
                      icon: const Icon(Icons.play_circle_outline)),
                  label: 'Play'),
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
        body: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/glass.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: const [
                      Text(
                        'User name',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "@user",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                      // padding: EdgeInsets.all(20),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      // color: Colors.deepPurple.shade400,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: Colors.white),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "My Acc",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                  // padding: EdgeInsets.all(20),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  // color: Colors.deepPurple.shade400,
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.notification_important_rounded,
                          color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Notification",
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                  // padding: EdgeInsets.all(20),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  // color: Colors.deepPurple.shade400,
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.settings, color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Setting", style: TextStyle(color: Colors.white)),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                  // padding: EdgeInsets.all(20),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  // color: Colors.deepPurple.shade400,
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Help Center",
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                  // padding: EdgeInsets.all(20),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  // color: Colors.deepPurple.shade400,
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
