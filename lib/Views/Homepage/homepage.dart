import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/Controller/player_controller.dart';
import 'package:musicapp/Views/Player/player.dart';
import 'package:musicapp/consts/Textstyle/style.dart';
import 'package:musicapp/consts/colors/colors.dart';
import 'package:musicapp/sreach/sreach.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Playercontroller());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
            icon: Icon(
              Icons.search,
              color: whiteColor,
            ),
          ),
        ],
        // leading: Icon(
        //   Icons.sort_rounded,
        //   color: whiteColor,
        // ),
        title: Text(
          "Beeez",
          style: Ourstyle(),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Song Found",
                style: Ourstyle(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: bgColor,
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: Ourstyle(),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: Ourstyle(),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: whiteColor,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isplaying.value
                            ? Icon(
                                Icons.play_arrow,
                                color: whiteColor,
                                size: 26,
                              )
                            : null,
                        onTap: () {
                          Get.to(
                            () => Player(
                              data: snapshot.data!,
                            ),
                            transition: Transition.downToUp,
                          );
                          controller.playsong(snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
