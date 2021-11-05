import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  // ignore: must_call_super
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
    cache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        audiolength = d;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        position = d;
        if (d.inSeconds == audiolength.inSeconds) {
          playBtn = Icons.play_arrow;
        }
      });
    });
  }

  late AudioPlayer audioPlayer;
  late AudioCache cache;
  IconData playBtn = Icons.play_arrow;

  String number = "Select The Prayer";
  int no = 0;
  bool flag = true;
  bool _play = false;
  bool hide = false;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void playAudio() {
    cache.load("audio$no.mp3");
    cache.play("audio$no.mp3");
    setState(() {});
  }

  Duration position = Duration();
  Duration audiolength = Duration();

  Widget slider() {
    return Slider.adaptive(
      value: audiolength.inSeconds.toDouble() > position.inSeconds.toDouble()
          ? position.inSeconds.toDouble()
          : audiolength.inSeconds.toDouble(),
      min: 00.00,
      max: audiolength.inSeconds.toDouble() > 00.00
          ? audiolength.inSeconds.toDouble()
          : 00.00,
      activeColor: Colors.blue.shade900,
      inactiveColor: Colors.blue.shade700,
      onChanged: (value) {
        seekToSec(value.toInt());
        setState(() {
          if (position.inSeconds.toDouble() ==
              audiolength.inSeconds.toDouble()) {
            playBtn = Icons.play_arrow;
            _play = false;
          }
        });
      },
    );
  }

  void seekToSec(int sec) {
    Duration newpos = Duration(seconds: sec);
    audioPlayer.seek(newpos);
  }

  void stopPlayer() {
    audioPlayer.stop();
  }

  @override
  void dispose() {
    stopPlayer();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        title: Text('Namaaz',
            style: TextStyle(
              color: Colors.blue.shade900,
            )),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "images/icon.png",
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                child: Text(
                  number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.yellow.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.yellow.shade700,
                child: InkWell(
                  onTap: () {
                    playBtn = Icons.pause;
                    setState(() {
                      number = "Salat Al-Fajr \n 2 Unit \n Prayer";
                      no = 1;
                      hide = true;
                      playAudio();
                      _play = true;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 100,
                    child: Text(
                      'FAJR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Zohr \n 4 Unit \n Prayer";
                          no = 2;
                          playAudio();
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'ZOHR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Asr \n 4 Unit \n Prayer";
                          no = 3;
                          playAudio();
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'ASR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Maghrib \n 3 Unit \n Prayer";
                          no = 4;
                          playAudio();
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'MAGHRIB',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Isha \n 4 Unit \n Prayer";
                          no = 5;
                          playAudio();
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'ISHA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.shade700,
                elevation: 2.0,
                child: Container(
                  width: 350,
                  height: 140,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize: 45.0,
                              color: Colors.blue.shade700,
                              onPressed: () {
                                double value = position.inSeconds.toDouble();
                                if (value >= 10.0) {
                                  setState(() {
                                    value -= 10.0;
                                    seekToSec(value.toInt());
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.skip_previous,
                              )),
                          IconButton(
                              iconSize: 65.0,
                              color: Colors.blue.shade900,
                              onPressed: () {
                                if (!_play) {
                                  audioPlayer.resume();
                                  playBtn = Icons.pause;
                                  setState(() {
                                    _play = true;
                                  });
                                } else {
                                  audioPlayer.pause();
                                  playBtn = Icons.play_arrow;
                                  setState(() {
                                    _play = false;
                                  });
                                }
                              },
                              icon: Icon(
                                playBtn,
                              )),
                          IconButton(
                              iconSize: 45.0,
                              color: Colors.blue.shade700,
                              onPressed: () {
                                double value = position.inSeconds.toDouble();
                                if (value <=
                                    audiolength.inSeconds.toDouble() - 10.0) {
                                  setState(() {
                                    value += 10.0;
                                    seekToSec(value.toInt());
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.skip_next,
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _printDuration(position),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          slider(),
                          Text(
                            _printDuration(audiolength),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
