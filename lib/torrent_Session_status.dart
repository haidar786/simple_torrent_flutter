class TorrentSessionStatus {
  List<int> bencode;
  int bytesDownloaded;
  int bytesWanted;
  int downloadRate;
  String magnetUri;
  double progress;
  String saveLocationUri;
  int seederCount;
  String state;
  TorrentSessionBuffer torrentSessionBuffer;
  int uploadRate;
  String videoFileUri;

  TorrentSessionStatus(
      {this.bencode,
        this.bytesDownloaded,
        this.bytesWanted,
        this.downloadRate,
        this.magnetUri,
        this.progress,
        this.saveLocationUri,
        this.seederCount,
        this.state,
        this.torrentSessionBuffer,
        this.uploadRate,
        this.videoFileUri});

  TorrentSessionStatus.fromJson(Map<String, dynamic> json) {
    bencode = json['bencode'].cast<int>();
    bytesDownloaded = json['bytesDownloaded'];
    bytesWanted = json['bytesWanted'];
    downloadRate = json['downloadRate'];
    magnetUri = json['magnetUri'];
    progress = json['progress'];
    saveLocationUri = json['saveLocationUri'];
    seederCount = json['seederCount'];
    state = json['state'];
    torrentSessionBuffer = json['torrentSessionBuffer'] != null
        ? new TorrentSessionBuffer.fromJson(json['torrentSessionBuffer'])
        : null;
    uploadRate = json['uploadRate'];
    videoFileUri = json['videoFileUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bencode'] = this.bencode;
    data['bytesDownloaded'] = this.bytesDownloaded;
    data['bytesWanted'] = this.bytesWanted;
    data['downloadRate'] = this.downloadRate;
    data['magnetUri'] = this.magnetUri;
    data['progress'] = this.progress;
    data['saveLocationUri'] = this.saveLocationUri;
    data['seederCount'] = this.seederCount;
    data['state'] = this.state;
    if (this.torrentSessionBuffer != null) {
      data['torrentSessionBuffer'] = this.torrentSessionBuffer.toJson();
    }
    data['uploadRate'] = this.uploadRate;
    data['videoFileUri'] = this.videoFileUri;
    return data;
  }
}

class TorrentSessionBuffer {
  int bufferHeadIndex;
  int bufferSize;
  int bufferTailIndex;
  int downloadedPieceCount;
  int endIndex;
  int lastDownloadedPieceIndex;
  int pieceCount;
  List<bool> pieceDownloadStates;
  int startIndex;

  TorrentSessionBuffer(
      {this.bufferHeadIndex,
        this.bufferSize,
        this.bufferTailIndex,
        this.downloadedPieceCount,
        this.endIndex,
        this.lastDownloadedPieceIndex,
        this.pieceCount,
        this.pieceDownloadStates,
        this.startIndex});

  TorrentSessionBuffer.fromJson(Map<String, dynamic> json) {
    bufferHeadIndex = json['bufferHeadIndex'];
    bufferSize = json['bufferSize'];
    bufferTailIndex = json['bufferTailIndex'];
    downloadedPieceCount = json['downloadedPieceCount'];
    endIndex = json['endIndex'];
    lastDownloadedPieceIndex = json['lastDownloadedPieceIndex'];
    pieceCount = json['pieceCount'];
    pieceDownloadStates = json['pieceDownloadStates'].cast<bool>();
    startIndex = json['startIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bufferHeadIndex'] = this.bufferHeadIndex;
    data['bufferSize'] = this.bufferSize;
    data['bufferTailIndex'] = this.bufferTailIndex;
    data['downloadedPieceCount'] = this.downloadedPieceCount;
    data['endIndex'] = this.endIndex;
    data['lastDownloadedPieceIndex'] = this.lastDownloadedPieceIndex;
    data['pieceCount'] = this.pieceCount;
    data['pieceDownloadStates'] = this.pieceDownloadStates;
    data['startIndex'] = this.startIndex;
    return data;
  }
}
