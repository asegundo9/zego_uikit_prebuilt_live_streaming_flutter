// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

/// Here is the simplest demo.
///
/// Please follow the link below to see more details.
/// [Examples](https://github.com/ZEGOCLOUD/zego_uikit_prebuilt_live_streaming_example_flutter)

Widget liveStreamingPage({required bool isHost}) {
  return ZegoUIKitPrebuiltLiveStreaming(
    appID: 1883215575,
    appSign: '7b5391081998de1b813d9a93d4049c62043881028f4ea30aa6371f397ebe9d40',
    userID: 'local user id',
    userName: 'local user name',
    liveID: 'live id',
    config: isHost
        ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
        : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
  );
}
