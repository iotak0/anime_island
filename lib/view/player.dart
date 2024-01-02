import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class BetterPlayerPage extends StatefulWidget {
  const BetterPlayerPage({super.key, required this.url});
  final String url;

  @override
  State<BetterPlayerPage> createState() => _BetterPlayerPageState();
}

class _BetterPlayerPageState extends State<BetterPlayerPage> {
  late BetterPlayerController _videoController;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _videoController = BetterPlayerController(
      BetterPlayerConfiguration(
          autoDispose: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            controlsHideTime: Duration(seconds: 1),
            enablePip: true,
            playerTheme: BetterPlayerTheme.cupertino,
          ),
          //aspectRatio: 16 / 9,
          looping: true,
          autoPlay: true),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.url,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Player'),
      ),
      body: Column(
        children: [
          BetterPlayer(controller: _videoController),
          ElevatedButton(
              onPressed: () {
                _videoController.enablePictureInPicture(_betterPlayerKey);
              },
              child: const Text('enablePictureInPicture!')),
          ElevatedButton(
              onPressed: () {
                _videoController.disablePictureInPicture();
              },
              child: const Text('disablePictureInPicture!'))
        ],
      ),
    );
  }
}
