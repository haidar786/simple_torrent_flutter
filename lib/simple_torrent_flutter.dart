import 'dart:async';

import 'package:flutter/services.dart';

class SimpleTorrentFlutter extends SimpleListener {
  final _channel = MethodChannel('simple_torrent_flutter');

  final _reverseChannel = MethodChannel('simple_torrent_flutter/reverse');

  BaseSimpleListeners simpleListener;

  SimpleTorrentFlutter(BaseSimpleListeners baseSimpleListeners){
    simpleListener = baseSimpleListeners;
  }


  Future<String> torrentPath(String path) async {
    String status;
    try {
      status = await _channel.invokeMethod("start", {"torrentPath": path});
      _handlers();
    } on PlatformException catch (e) {
      status = e.toString();
    }
    return status;
  }

  _handlers() async {
    _reverseChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onAddTorrent":
          simpleListener.onAddTorrent(call.arguments);
          break;
        case "onBlockUploaded":
          simpleListener.onBlockUploaded(call.arguments);
          break;
        case "onMetadataFailed":
          simpleListener.onMetadataFailed(call.arguments);
          break;
        case "onMetadataReceived":
          simpleListener.onMetadataReceived(call.arguments);
          break;
        case "onPieceFinished":
          simpleListener.onPieceFinished(call.arguments);
          break;
        case "onTorrentDeleteFailed":
          simpleListener.onTorrentDeleteFailed(call.arguments);
          break;
        case "onTorrentDeleted":
          simpleListener.onTorrentDeleted(call.arguments);
          break;
        case "onTorrentError":
          simpleListener.onTorrentError(call.arguments);
          break;
        case "onTorrentFinished":
          simpleListener.onTorrentFinished(call.arguments);
          break;
        case "onTorrentPaused":
          simpleListener.onTorrentPaused(call.arguments);
          break;
        case "onTorrentRemoved":
          simpleListener.onTorrentRemoved(call.arguments);
          break;
        case "onTorrentResumed":
          simpleListener.onTorrentResumed(call.arguments);
          break;
      }
    });
  }

}

abstract class BaseSimpleListeners {
  void onAddTorrent(var value);
  void onBlockUploaded(var value);
  void onMetadataFailed(var value);
  void onMetadataReceived(var value);
  void onPieceFinished(var value);
  void onTorrentDeleteFailed(var value);
  void onTorrentDeleted(var value);
  void onTorrentError(var value);
  void onTorrentFinished(var value);
  void onTorrentPaused(var value);
  void onTorrentRemoved(var value);
  void onTorrentResumed(var value);
}

class SimpleListener extends BaseSimpleListeners {
  @override
  void onAddTorrent(value) {
    print(value);
  }

  @override
  void onBlockUploaded(value) {
    print(value);
  }

  @override
  void onMetadataFailed(value) {
    print(value);
  }

  @override
  void onMetadataReceived(value) {
    print(value);
  }

  @override
  void onPieceFinished(value) {
    print(value);
  }

  @override
  void onTorrentDeleteFailed(value) {
    print(value);
  }

  @override
  void onTorrentDeleted(value) {
    print(value);
  }

  @override
  void onTorrentError(value) {
    print(value);
  }

  @override
  void onTorrentFinished(value) {
    print(value);
  }

  @override
  void onTorrentPaused(value) {
    print(value);
  }

  @override
  void onTorrentRemoved(value) {
    print(value);
  }

  @override
  void onTorrentResumed(value) {
    print(value);
  }
}
