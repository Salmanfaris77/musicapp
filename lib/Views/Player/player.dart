import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:musicapp/Controller/player_controller.dart';
import 'package:musicapp/consts/colors/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Playercontroller>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: Icon(Icons.music_note),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        data[controller.playIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: bgColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        data[controller.playIndex.value].artist.toString(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: bgColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: TextStyle(color: bgColor),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: bgColor,
                                activeColor: sliderColor,
                                min: Duration(seconds: 0).inSeconds.toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDuriationToScedons(
                                      newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duriation.value,
                              style: TextStyle(color: bgColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.playsong(
                                    data[controller.playIndex.value - 1].uri,
                                    controller.playIndex.value - 1);
                              },
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                size: 40,
                              )),
                          Obx(
                            () => CircleAvatar(
                              radius: 35,
                              backgroundColor: bgDarkColor,
                              child: Transform.scale(
                                scale: 3.5,
                                child: IconButton(
                                    onPressed: () {
                                      if (controller.isplaying.value) {
                                        controller.audioPlayer.pause();
                                        controller.isplaying(false);
                                      } else {
                                        controller.audioPlayer.play();
                                        controller.isplaying(true);
                                      }
                                    },
                                    icon: controller.isplaying.value
                                        ? Icon(
                                            Icons.pause,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.play_arrow_rounded,
                                            color: whiteColor,
                                          )),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.playsong(
                                    data[controller.playIndex.value + 1].uri,
                                    controller.playIndex.value + 1);
                              },
                              icon: Icon(
                                Icons.skip_next_rounded,
                                size: 40,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
