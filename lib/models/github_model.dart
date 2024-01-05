class Github {
  Github({
    this.downloadLink,
    this.newFeatures,
    this.version,
  });

  final String? version;
  final String? newFeatures;
  final String? downloadLink;

  factory Github.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Github(
        version: json['version'],
        newFeatures: json['body'],
        downloadLink: json['download_link'] );
    }
    return Github();
  }
}