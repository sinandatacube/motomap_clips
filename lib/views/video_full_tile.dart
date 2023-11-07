import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:motomap_clips/models/reel_model.dart';
import 'package:motomap_clips/utils/url_checker.dart';
import 'package:motomap_clips/views/screen_options.dart';
import 'package:video_player/video_player.dart';

ValueNotifier<bool> isMute = ValueNotifier(false);

class VideoFullTile extends StatefulWidget {
  final ReelModel item;
  final PageController pageController;
  final int index;
  final String customerName;
  final String customerMobile;
  final String customerId;

  const VideoFullTile({
    Key? key,
    required this.item,
    required this.index,
    required this.customerMobile,
    required this.customerName,
    required this.customerId,
    required this.pageController,
  }) : super(key: key);

  @override
  State<VideoFullTile> createState() => _VideoFullTileState();
}

class _VideoFullTileState extends State<VideoFullTile> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // _videoPlayerController.setVolume(isMute.value ? 1 : 0);
    debugPrint(widget.item.adVideoUrl + " asdsjahfjkdskjfakfadsjflkj");
    if (!UrlChecker.isImageUrl(widget.item.adVideoUrl) &&
        UrlChecker.isValid(widget.item.adVideoUrl)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.item.adVideoUrl));
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: false,
    );
    setState(() {});
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
      if (_videoPlayerController.value.isPlaying) {
        isPlaying = true;
      } else {
        isPlaying = false;
      }
      _videoPlayerController.setVolume(isMute.value ? 0 : 1);

      setState(() {});
    });
  }

  togglePlayPause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      isPlaying = _videoPlayerController.value.isPlaying;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _videoPlayerController.setVolume(isMute.value ? 0 : 1);
    return getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: () => togglePlayPause(),
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            ),
          )
        else
          const Align(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.white38,
              strokeWidth: 1.5,
            ),
          ),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width > 768
              ? MediaQuery.of(context).size.width * 0.35
              : MediaQuery.of(context).size.width,
          child: SizedBox(
            height: 8,
            child: VideoProgressIndicator(
              _videoPlayerController,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                backgroundColor: Colors.white38,
                bufferedColor: Colors.white,
                playedColor: Colors.amber,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 15,
          child: ValueListenableBuilder(
              valueListenable: isMute,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    // print("object");
                    isMute.value = !isMute.value;

                    // _videoPlayerController.setVolume(isMute.value ? 1 : 0);
                  },
                  icon: Icon(
                    value ? Icons.volume_off_rounded : Icons.volume_up_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                );
              }),
          // const SizedBox(height: 20),
        ),
        ScreenOptions(
            customerMobile: widget.customerMobile,
            customerId: widget.customerId,
            customerName: widget.customerName,
            reelItem: widget.item,
            videoController: _videoPlayerController,
            index: widget.index),
        if (!isPlaying)
          IconButton(
            onPressed: () => togglePlayPause(),
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
            style: IconButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              backgroundColor: Colors.black26,
            ),
          ),
      ],
    );
  }
}
