# simple_torrent_flutter_example

Demonstrates how to use the simple_torrent_flutter plugin.

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:simple_torrent_flutter/simple_torrent_flutter.dart';

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

  String _videoPath = "nothing";
  List list = List<Widget>();

  String _videoUri = "uri none";

  @override
  void initState() {
    list.add(Text("hey"));
    _simpleTorrentFlutter = SimpleTorrentFlutter(SimpleListener());
    _simpleTorrentFlutter.simpleListener = this;
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
        body: Center(
          child: ListView(
            children: <Widget>[
              Text(_videoPath),
              Text(_videoUri),
              widget.path == null
                  ? Text("torrent null :)")
                  : ListTile(
                      title: Text(widget.path),
                      onTap: _addTorrent,
                    ),
              Column(children: list)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onAddTorrent(value) {
    print(value);
    list.add(Text("onAddTorrent"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onBlockUploaded(value) {
    list.add(Text("onBlockUploaded"));
    print(value);
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onMetadataFailed(value) {
    print(value);
    list.add(Text("onMetaDataFailed"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onMetadataReceived(value) {
    print(value);
    list.add(Text("onMetadataRecerived"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onPieceFinished(value) {
    print(value);
    list.add( Text("onPieceFinished"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentDeleteFailed(value) {
    print(value);
    list.add(Text("onTorrentDeleteFailed"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentDeleted(value) {
    print(value);
    list.add(Text("onTorrentDeleted"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentError(value) {
    print(value);
    list.add(Text("onTorrentError"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentFinished(value) {
    print(value);
    list.add(Text("onTorrentFinished"));

    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentPaused(value) {
    print(value);
    list.add(Text("onTorrentPause"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentRemoved(value) {
    print(value);
    list.add(Text("onTorrentRemoved"));
    setState(() {
      _videoPath = value.progress.toString();
    });
  }

  @override
  void onTorrentResumed(value) {
    print(value);
    list.add(Text("onTorrentResumed"));
    setState(() {
      _videoPath = value.progress.toString();
      _videoUri = value.videoFileUri;
    });
  }
}
