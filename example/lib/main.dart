import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:simple_torrent_flutter/simple_torrent_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dataString =
      await MethodChannel('haidar.example.channel.simple_torrent_flutter').invokeMethod("intent");
  runApp(MyApp(
    path: dataString,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key, @required this.path}) : super(key: key);
  final String path;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with BaseSimpleListeners {
  String _videoPath = 'Unknown';
  SimpleTorrentFlutter _simpleTorrentFlutter;

  @override
  void initState() {
    _simpleTorrentFlutter = SimpleTorrentFlutter(SimpleListener());
    _simpleTorrentFlutter.simpleListener = this;
    super.initState();
  }

  Future<void> _addTorrent() async {
    String videoPath;
    try {
      videoPath = await _simpleTorrentFlutter.torrentPath(widget.path);
    } on PlatformException {
      videoPath = 'Failed to get video path.';
    }

    if (!mounted) return;

    setState(() {
      _videoPath = videoPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Video path is: $_videoPath\n'),
              widget.path == null
                  ? Text("torrent null :)")
                  : ListTile(
                      title: Text(widget.path),
                      onTap: _addTorrent,
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onAddTorrent(value) {
    print(value);
  }

  @override
  void onBlockUploaded(value) {
    // TODO: implement onBlockUploaded
  }

  @override
  void onMetadataFailed(value) {
    // TODO: implement onMetadataFailed
  }

  @override
  void onMetadataReceived(value) {
    // TODO: implement onMetadataReceived
  }

  @override
  void onPieceFinished(value) {
    // TODO: implement onPieceFinished
  }

  @override
  void onTorrentDeleteFailed(value) {
    // TODO: implement onTorrentDeleteFailed
  }

  @override
  void onTorrentDeleted(value) {
    // TODO: implement onTorrentDeleted
  }

  @override
  void onTorrentError(value) {
    // TODO: implement onTorrentError
  }

  @override
  void onTorrentFinished(value) {
    // TODO: implement onTorrentFinished
  }

  @override
  void onTorrentPaused(value) {
    // TODO: implement onTorrentPaused
  }

  @override
  void onTorrentRemoved(value) {
    // TODO: implement onTorrentRemoved
  }

  @override
  void onTorrentResumed(value) {
    // TODO: implement onTorrentResumed
  }
}
