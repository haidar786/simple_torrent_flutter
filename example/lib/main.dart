import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:simple_torrent_flutter/simple_torrent_flutter.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dataString =
      await MethodChannel('haidar.example.channel.simple_torrent_flutter')
          .invokeMethod("intent");
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
  SimpleTorrentFlutter _simpleTorrentFlutter;
  Map<String, dynamic> jsonObj;

  String _videoPath = "nothing";

  @override
  void initState() {
    _simpleTorrentFlutter = SimpleTorrentFlutter(SimpleListener());
    _simpleTorrentFlutter.simpleListener = this;
    widget.path ?? _addTorrent();
    super.initState();
  }

  Future<void> _addTorrent() async {
    try {
      await _simpleTorrentFlutter.torrentPath(widget.path);
    } on PlatformException {
      print('Failed to get video path.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:Column(
          children: <Widget>[
            Text(_videoPath),
            widget.path == null
                ? Text("torrent null :)")
                : ListTile(
              title: Text(widget.path),
              onTap: _addTorrent,
            ),
            SafeArea(
              child: SingleChildScrollView(child: jsonObj != null ? JsonViewerWidget(jsonObj): Container()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onAddTorrent(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onBlockUploaded(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onMetadataFailed(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onMetadataReceived(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onPieceFinished(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentDeleteFailed(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentDeleted(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentError(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentFinished(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentPaused(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentRemoved(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentResumed(value) {
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }
}
