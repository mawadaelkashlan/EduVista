import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({super.key, required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });

    // Start playing and loop the video.
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              _ControlsOverlay(controller: _controller),
              VideoProgressIndicator(_controller, allowScrubbing: true),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _ControlsOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Play/pause button
        Center(
          child: IconButton(
            icon: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 50.0,
            ),
            onPressed: () {
              controller.value.isPlaying ? controller.pause() : controller.play();
            },
          ),
        ),
        // Forward button (10 seconds)
        Positioned(
          bottom: 20,
          right: 30,
          child: IconButton(
            icon: const Icon(Icons.forward_10, color: Colors.white, size: 30),
            onPressed: () {
              final currentPosition = controller.value.position;
              controller.seekTo(currentPosition + const Duration(seconds: 10));
            },
          ),
        ),
        // Rewind button (10 seconds)
        Positioned(
          bottom: 20,
          left: 30,
          child: IconButton(
            icon: const Icon(Icons.replay_10, color: Colors.white, size: 30),
            onPressed: () {
              final currentPosition = controller.value.position;
              controller.seekTo(currentPosition - const Duration(seconds: 10));
            },
          ),
        ),
      ],
    );
  }
}
