import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class ZegoConfig {
  static const int appID = 1883215575;
  static const String appSign =
      '7b5391081998de1b813d9a93d4049c62043881028f4ea30aa6371f397ebe9d40';
}

final String localUserID = '${Random().nextInt(90000) + 10000}';
final String localUserName = 'user_$localUserID';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKit().initLog().then((_) {
    runApp(const LiveStreamApp());
  });
}

class LiveStreamApp extends StatelessWidget {
  const LiveStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZEGOCLOUD Live Streaming',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _roomIDController = TextEditingController(
    text: '${Random().nextInt(9000) + 1000}',
  );

  @override
  void dispose() {
    _roomIDController.dispose();
    super.dispose();
  }

  void _navigateToLive(BuildContext context, {required bool isHost}) {
    final roomID = _roomIDController.text.trim();
    if (roomID.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: roomID,
          isHost: isHost,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Stream Portal')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your User ID: $localUserID'),
              const SizedBox(height: 20),
              TextFormField(
                controller: _roomIDController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Live Room ID'),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Start Live'),
                      onPressed: () => _navigateToLive(context, isHost: true),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Watch Live'),
                      onPressed: () => _navigateToLive(context, isHost: false),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;

  const LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
  });

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    final config = widget.isHost
        ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
        : ZegoUIKitPrebuiltLiveStreamingConfig.audience();

    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: ZegoConfig.appID,
        appSign: ZegoConfig.appSign,
        userID: localUserID,
        userName: localUserName,
        liveID: widget.liveID,
