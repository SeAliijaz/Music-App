import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Widgets/custom_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() {
    return _MusicPlayerScreenState();
  }
}

bool playing = false;
IconData playButton = Icons.play_arrow;

AudioPlayer? _player;
AudioCache? cache;

Duration position = Duration();
Duration musicLength = Duration();

Widget _slider() {
  return Slider.adaptive(
      value: position.inSeconds.toDouble(),
      max: musicLength.inSeconds.toDouble(),
      onChanged: (value) {
        seekToSec(value.toInt());
      });
}

void seekToSec(int sec) {
  Duration newPosition = Duration(seconds: sec);
  _player!.seek(newPosition);
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    //now let's handle the audioplayer time
    //this function will allow you to get the music duration
    _player!.onDurationChanged.listen((d) {
      setState(() {
        musicLength = d;
      });
    });

    //this function will allow us to move the cursor of the slider while we are playing the song
    _player!.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // back button and menu button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomCard(child: Icon(Icons.arrow_back)),
                  ),
                  Text('P L A Y L I S T'),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CustomCard(child: Icon(Icons.menu)),
                  ),
                ],
              ),
            ),

            // cover art, artist name, song name
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomCard(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('assets/cover_art.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kota The Friend',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const Text(
                                'Birdie',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 32,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // start time, shuffle button, repeat button, end time
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ///here we have to add duration
                  Text(
                    "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),

                  ///These are just icons
                  Icon(Icons.shuffle),
                  Icon(Icons.repeat),

                  ///here we have to add music position
                  Text(
                    "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),

            ///Slider
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCard(child: Expanded(child: _slider())),
                ],
              ),
            ),

            /// previous song, pause play, skip next song
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Center(
                              child: Icon(
                                Icons.skip_previous,
                                size: 32,
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomCard(
                          child: IconButton(
                              onPressed: () {
                                if (!playing) {
                                  setState(() {
                                    playButton = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  setState(() {
                                    playButton = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },
                              icon: Center(
                                child: Icon(playButton, size: 32),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Center(
                              child: Icon(
                                Icons.skip_next,
                                size: 32,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
