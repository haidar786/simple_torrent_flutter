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
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.os.Looper
import com.google.gson.GsonBuilder
import com.google.gson.Gson
import java.io.File
import java.io.FileWriter


class SimpleTorrentFlutterPlugin(private val activeContext: Context) : MethodCallHandler {
  private val uiThreadHandler = Handler(Looper.getMainLooper())


  companion object {
    private lateinit var methodChannel: MethodChannel
    private lateinit var reverseMethodChannel : MethodChannel
    private lateinit var torrentSession: TorrentSession
    private lateinit var gson: Gson

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      gson = GsonBuilder()
              .registerTypeAdapter(Uri::class.java, UriAdapter())
              .create()
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
          reverseMethodChannel.invokeMethod("onAddTorrent", gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onBlockUploaded(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onBlockUploaded",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onMetadataFailed(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onMetadataFailed",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onMetadataReceived(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onMetadataReceived",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onPieceFinished(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        val root = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_ALARMS).parent)
        val gpxfile = File(root, "samples2.txt")
        val writer = FileWriter(gpxfile)
        writer.append(gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        writer.flush()
        writer.close()
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onPieceFinished",gson.toJson(torrentSessionStatus))
        }
      }

      override fun onTorrentDeleteFailed(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentDeleteFailed",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onTorrentDeleted(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentDeleted",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onTorrentError(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentError",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onTorrentFinished(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentFinished",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onTorrentPaused(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentPaused",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onTorrentRemoved(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentRemoved",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

      override fun onTorrentResumed(torrentHandle: TorrentHandle, torrentSessionStatus: TorrentSessionStatus) {
        uiThreadHandler.post {
          reverseMethodChannel.invokeMethod("onTorrentResumed",gson.toJson(torrentSessionStatus,TorrentSessionStatus::class.java))
        }
      }

    }
  }
}
