class ServerModel {
  final String serverName;
  final String serverUrl;

  ServerModel({
    required this.serverName,
    required this.serverUrl,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      serverName: json['serverName'] as String,
      serverUrl: json['serverUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serverName': serverName,
      'serverUrl': serverUrl,
    };
  }
}

class ServerResults {
  ServerResults({
    required this.serverList,
  });

  final List<ServerModel>? serverList;
}
