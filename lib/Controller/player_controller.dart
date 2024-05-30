import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isplaying = false.obs;

  var duriation = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkpermission();
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duriation.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDuriationToScedons(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playsong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      audioPlayer.play();
      isplaying(true);
      updatePosition();
    } catch (e) {
      print(e.toString());
    }
  }

  checkpermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkpermission();
    }
  }
}
