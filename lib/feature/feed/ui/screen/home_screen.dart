import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as httpClient;
import 'package:tiktokui/common/util/constants.dart';
import 'package:tiktokui/feature/feed/model/video.dart';
import 'package:tiktokui/feature/feed/ui/screen/side_actionbar.dart';
// import 'package:better_player/better_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Video> videosList = [];
  bool isLoading = false;
  String errorMessage = "";
  bool hasErrorOccured = false;
  @override
  void initState() {
    super.initState();
    fetchVideos();

    ///
  }

  fetchVideos() async {
    final url =
        "https://pixabay.com/api/videos?key=${Constants.pixabayApiKey}&q=car";

    final uri = Uri.parse(url);
    try {
      setState(() {
        isLoading = true;
      });
      final response = await httpClient.get(uri);

      final Map<String, dynamic> decodedBody = json.decode(response.body);

      final totalItems = decodedBody['totalHits'];

      final List hits = decodedBody["hits"];

      // final first = hits[0];
      // final second = hits[1];

      // final firstVideo = Video.fromJson(first);

      List<Video> tempVideosList = hits.map((item) {
        final Video convertedVideo = Video.fromJson(item);

        return convertedVideo;
      }).toList();

      /// same as above , => means return
      tempVideosList = hits.map((item) => Video.fromJson(item)).toList();

      setState(() {
        videosList = tempVideosList;
        isLoading = false;
      });

      print(hits);
    } catch (e, s) {
      print(e);
      print(s);
      isLoading = false;
      hasErrorOccured = true;
      errorMessage = e.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // buildVideoPlayer(String videoUrl) {
  //   return
  //   BetterPlayer.network(
  //     videoUrl,
  //     betterPlayerConfiguration: BetterPlayerConfiguration(aspectRatio: 16 / 9),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Colors.black26,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: Size(5, 50),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                bottom: PreferredSize(
                    preferredSize: Size(200, 200),
                    child: Container(
                        width: 200,
                        child: TabBar(
                            indicator: BoxDecoration(
                              border: Border(
                                // provides to left side
                                right: BorderSide(
                                    color: Colors.grey), // for right side
                              ),
                            ),
                            tabs: [
                              Text(
                                "FOllow",
                              ),
                              Text("Unfollow")
                            ]))),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                type: BottomNavigationBarType
                    .fixed, //if you want to have more than 3 bottom nav item then color will default to ovverride this has to be done
                elevation: 0,
                backgroundColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.white,
                    ),
                    label: "Discover",
                  ),
                  BottomNavigationBarItem(
                    icon: Center(
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            left: 0.1,
                            child: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            right: 5,
                            bottom: 0,
                            top: 0,
                            child: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                            ),
                          ),
                          Positioned(
                              left: 14,
                              top: 3.2,
                              // bottom: 15,
                              right: 15,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    label: "Post",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    label: "Inbox",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: "Profile",
                  ),
                ]),
            extendBody: true,
            body: TabBarView(
              children: [
                PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: videosList.length,
                    itemBuilder: (context, index) {
                      Video currentVideo = videosList[index];

                      return Container(
                        color: Colors.black87,
                        child: Stack(
                          children: [
                            // buildVideoPlayer(
                            //     currentVideo.availableResolutions.medium.url),

                            Positioned(
                              right: 5,
                              bottom: 100,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      currentVideo.userImageUrl,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SideActionBar(
                                    activeVideo: currentVideo,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 70,
                                left: 10,
                                right: 150,
                                child: Container(
                                  color: Colors.white,
                                  width: 500,
                                  child: Column(
                                    children: [
                                      Text(
                                        currentVideo.userImageUrl,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      );
                    }),
                const Icon(Icons.directions_car),
              ],
            ));
  }

  // printVide(String url) {
  //   print(url);

  //   return Container();
  // }
}
