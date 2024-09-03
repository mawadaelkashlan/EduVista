// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeVideoPlayer extends StatefulWidget {
//   final String url;

//   const YoutubeVideoPlayer({super.key, required this.url});

//   @override
//   State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
// }

// class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
//   late YoutubePlayerController playerController;

//   @override
//   void initState() {
//     super.initState();
//     final videoId = YoutubePlayer.convertUrlToId(widget.url);

//     if (videoId != null) {
//       playerController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: false,
//         ),
//       );
//     } else {
//       playerController = YoutubePlayerController(
//         initialVideoId: '',
//         flags: const YoutubePlayerFlags(
//           autoPlay: false,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         YoutubePlayer(
//           controller: playerController,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.red,
//           onReady: () {
//             // Add any actions to be performed when the player is ready
//           },
//         ),
//         Positioned(
//           bottom: 10,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 onPressed: seekBackward,
//                 icon: const Icon(
//                   Icons.replay_10,
//                   size: 30,
//                   color: Colors.black54,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               IconButton(
//                 onPressed: seekForward,
//                 icon: const Icon(
//                   Icons.forward_10,
//                   size: 30,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void seekForward() {
//     final currentPosition = playerController.value.position;
//     final duration = playerController.value.metaData.duration;
//     if (currentPosition.inSeconds + 10 < duration.inSeconds) {
//       playerController.seekTo(currentPosition + const Duration(seconds: 10));
//     }
//   }

//   void seekBackward() {
//     final currentPosition = playerController.value.position;
//     if (currentPosition.inSeconds - 10 > 0) {
//       playerController.seekTo(currentPosition - const Duration(seconds: 10));
//     }
//   }

//   @override
//   void dispose() {
//     playerController.dispose();
//     super.dispose();
//   }
// }
