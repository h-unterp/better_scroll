import 'dart:math';

import 'package:better_scroll/easy_example_provider.dart';
import 'package:better_scroll/video_list/video_list_data.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

import 'video_list/constants.dart';
import 'video_list/video_list_widget.dart';

class EasyExample extends StatefulWidget {
  const EasyExample({Key? key}) : super(key: key);

  @override
  State<EasyExample> createState() => _EasyExampleState();
}

class _EasyExampleState extends State<EasyExample> {
  @override
  void initState() {
    super.initState();
    _setupData();
  }

  final _random = Random();

  final List<String> _videos = [
    Constants.bugBuckBunnyVideoUrl,
    Constants.forBiggerBlazesUrl,
    Constants.forBiggerJoyridesVideoUrl,
    Constants.elephantDreamVideoUrl,
  ];

  List<VideoListData> dataList = [];

  void _setupData() {
    for (int index = 0; index < 1000; index++) {
      var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
      dataList.add(VideoListData("Video $index", randomVideoUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiverPagedBuilder<int, Post>(
        // the first page we will ask
        firstPageKey: 1,
        // The [StateNotifierProvider] that holds the logic and the list of Posts
        provider: easyExampleProvider,
        // a function that build a single Post
        itemBuilder: (context, item, index) {
          VideoListData videoListData = dataList[index];
          return VideoListWidget(
            videoListData: videoListData,
          );
        },

        // The type of list we want to render
        // This can be any of the [infinite_scroll_pagination] widgets
        pagedBuilder: (controller, builder) => PagedListView(
            pagingController: controller, builderDelegate: builder),
      ),
    );
  }
}
