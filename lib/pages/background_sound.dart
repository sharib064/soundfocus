import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundSound extends StatefulWidget {
  const BackgroundSound({super.key});

  @override
  State<BackgroundSound> createState() => _BackgroundSoundState();
}

class _BackgroundSoundState extends State<BackgroundSound> {
  final List songs = [
    ["Forest", "lib/images/forest.png", "Lullaby", "audio/forest2.mp3"],
    ["Mantra", "lib/images/mantra.jpg", "Alex", "audio/mantra.mp3"],
    [
      "Sunset-landscape",
      "lib/images/Forest.jpg",
      "Keys of Moon",
      "audio/sunset-landscape.mp3"
    ],
    ["Winter-Spa", "lib/images/mantra.jpg", "Alex", "audio/Winter-spa.mp3"],
    ["Eternal-healing", "lib/images/Forest.jpg", "Alex", "audio/healing.mp3"],
    [
      "Deep Meditation",
      "lib/images/meditation.png",
      "David Fesliyan",
      "audio/meditation.mp3"
    ]
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int currentSongIndex = -1; // -1 means no song is currently playing
  double volume = 1.0;

  void reduceVolumeGradually() async {
    const reductionRate = 0.1;
    const interval = Duration(minutes: 5);

    while (volume > 0.0 && isPlaying) {
      await Future.delayed(interval);
      volume -= reductionRate;
      volume = volume < 0.0 ? 0.0 : volume;
      await _audioPlayer.setVolume(volume);
      if (volume <= 0.0) {
        await _audioPlayer.stop();
        setState(() => isPlaying = false);
        break;
      }
    }
  }

  // Function to start playing a selected song
  void startSleepMusic(int index) async {
    setState(() {
      currentSongIndex = index;
      volume = 1.0;
      isPlaying = true;
    });
    await _audioPlayer.play(AssetSource(songs[currentSongIndex][3]));
    reduceVolumeGradually();
  }

  // Function to play the next song
  void playNextSong() async {
    if (currentSongIndex < songs.length - 1) {
      currentSongIndex++;
    } else {
      currentSongIndex = 0;
    }
    await _audioPlayer.play(AssetSource(songs[currentSongIndex][3]));
    reduceVolumeGradually();
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _audioPlayer.onPlayerComplete.listen((_) {
      playNextSong();
    });
  }

  void stop() {
    _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      currentSongIndex = -1; // Reset the song index
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Image.asset(
                    'lib/images/bg-sound-banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, bottom: 10, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  "Turn on sleep mode, and a soothing song will play and gradually decrease its volume to help you fall asleep peacefully.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: const Icon(Icons.music_note),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${songs.length} songs",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Text(
                    "1h 30 min",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    startSleepMusic(index);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: currentSongIndex == index
                          ? Colors.blueGrey // Color for the playing song
                          : const Color(0xff190d0d),
                      border: Border.all(color: Colors.grey, width: 0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            songs[index][1],
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          )),
                      title: Text(
                        songs[index][0],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        songs[index][2],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (!isPlaying) {
                    startSleepMusic(0); // Start from the first song
                  } else {
                    stop();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xfffb3e3e),
                        Color(0xff8f0909),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      isPlaying ? "Stop sound playing" : "Start to fall asleep",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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
