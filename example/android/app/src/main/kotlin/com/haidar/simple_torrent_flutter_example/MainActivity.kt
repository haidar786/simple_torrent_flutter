package com.haidar.simple_torrent_flutter_example

import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    val channel = "haidar.example.channel.simple_torrent_flutter"
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, channel).setMethodCallHandler { call, result ->
      if (call.method.contentEquals("intent")) {
        result.success(intent.dataString)
      }
    }
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    setIntent(intent)
    recreate()
  }

}
