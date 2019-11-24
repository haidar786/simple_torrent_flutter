package com.haidar.simple_torrent_flutter

import android.content.Context
import android.net.Uri
import android.os.Environment
import android.os.Handler
import com.frostwire.jlibtorrent.TorrentHandle
import com.masterwok.simpletorrentandroid.TorrentSession
import com.masterwok.simpletorrentandroid.TorrentSessionOptions
import com.masterwok.simpletorrentandroid.contracts.TorrentSessionListener
import com.masterwok.simpletorrentandroid.models.TorrentSessionStatus
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.os.Looper



class SimpleTorrentFlutterPlugin(private val activeContext: Context) : MethodCallHandler {
  private val uiThreadHandler = Handler(Looper.getMainLooper())


  companion object {
    private lateinit var methodChannel: MethodChannel
    private lateinit var reverseMethodChannel : MethodChannel
    private lateinit var torrentSession: TorrentSession

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channelName = "simple_torrent_flutter"
      val reverseChannelName = "simple_torrent_flutter/reverse"
      methodChannel = MethodChannel(registrar.messenger(), channelName)
      reverseMethodChannel = MethodChannel(registrar.messenger(),reverseChannelName)
      val instance = SimpleTorrentFlutterPlugin(registrar.activeContext())
      methodChannel.setMethodCallHandler(instance)
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "start" -> {
        val uri = createNewTorrent(call.argument("torrentPath")!!)
        if (torrentSession.isRunning) {
          torrentSession.stop()
        }
        torrentSession.start(activeContext,uri)
        result.success("started")
      }
      "pause" -> {
        torrentSession.pause()
        result.success("paused")
      }
      "resume" ->{
        torrentSession.resume()
        result.success("resumed")
      }
      "stop" -> {
        torrentSession.stop()
        result.success("stopped")
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun createNewTorrent(argument: String): Uri {
    val torrentUri = Uri.parse(argument)
    val torrentSessionOptions = TorrentSessionOptions(
            downloadLocation = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
            , enableLogging = false
            , shouldStream = true
    )
    torrentSession = TorrentSession(torrentSessionOptions)
    listeners()
    return torrentUri
  }

  private fun listeners() {
    torrentSession.listener = object : TorrentSessionListener{
      override fun onAddTorrent(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onAddTorrent","pakistan")
        }
      }

      override fun onBlockUploaded(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onBlockUploaded",null)
        }
      }

      override fun onMetadataFailed(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onMetadataFailed",null)
        }
      }

      override fun onMetadataReceived(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onMetadataReceived",null)
        }
      }

      override fun onPieceFinished(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onPieceFinished",null)
        }
      }

      override fun onTorrentDeleteFailed(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentDeleteFailed",null)
        }
      }

      override fun onTorrentDeleted(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentDeleted",null)
        }
      }

      override fun onTorrentError(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentError",null)
        }
      }

      override fun onTorrentFinished(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentFinished",null)
        }
      }

      override fun onTorrentPaused(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentPaused",null)
        }
      }

      override fun onTorrentRemoved(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentRemoved",null)
        }
      }

      override fun onTorrentResumed(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentResumed",null)
        }
      }

    }
  }
}
