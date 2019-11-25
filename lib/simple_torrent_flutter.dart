import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simple_torrent_flutter/torrent_Session_status.dart';

class SimpleTorrentFlutter extends SimpleListener {
  final _channel = MethodChannel('simple_torrent_flutter');

  final _reverseChannel = MethodChannel('simple_torrent_flutter/reverse');

  BaseSimpleListeners simpleListener;

  SimpleTorrentFlutter(BaseSimpleListeners baseSimpleListeners){
    simpleListener = baseSimpleListeners;
  }


  Future<void> torrentPath(String path) async {
    try {
      await _channel.invokeMethod("start", {"torrentPath": path});
      _handlers();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _handlers() async {
    _reverseChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onAddTorrent":
          simpleListener.onAddTorrent(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onBlockUploaded":
          simpleListener.onBlockUploaded(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onMetadataFailed":
          simpleListener.onMetadataFailed(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onMetadataReceived":
          simpleListener.onMetadataReceived(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onPieceFinished":
          simpleListener.onPieceFinished(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentDeleteFailed":
          simpleListener.onTorrentDeleteFailed(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentDeleted":
          simpleListener.onTorrentDeleted(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentError":
          simpleListener.onTorrentError(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentFinished":
          simpleListener.onTorrentFinished(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentPaused":
          simpleListener.onTorrentPaused(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentRemoved":
          simpleListener.onTorrentRemoved(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
        case "onTorrentResumed":
          simpleListener.onTorrentResumed(TorrentSessionStatus.fromJson(jsonDecode(call.arguments)));
          break;
      }
    });
  }

}

abstract class BaseSimpleListeners {
  void onAddTorrent(TorrentSessionStatus value);
  void onBlockUploaded(TorrentSessionStatus value);
  void onMetadataFailed(TorrentSessionStatus value);
  void onMetadataReceived(TorrentSessionStatus value);
  void onPieceFinished(TorrentSessionStatus value);
  void onTorrentDeleteFailed(TorrentSessionStatus value);
  void onTorrentDeleted(TorrentSessionStatus value);
  void onTorrentError(TorrentSessionStatus value);
  void onTorrentFinished(TorrentSessionStatus value);
  void onTorrentPaused(TorrentSessionStatus value);
  void onTorrentRemoved(TorrentSessionStatus value);
  void onTorrentResumed(TorrentSessionStatus value);
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
