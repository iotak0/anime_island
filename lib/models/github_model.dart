class Github {
  Github(
      {this.downloadLink, this.newFeatures, this.version, this.adUrlFilters});

  final String? version;
  final String? newFeatures;
  final String? downloadLink;
  final List<String>? adUrlFilters;

  factory Github.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Github(
        version: json['version'],
        newFeatures: json['body'],
        downloadLink: json['download_link'],
        adUrlFilters: List.generate(json['adUrlFilters'].length,
            (index) => json['adUrlFilters'][index]),
      );
    }
    return Github();
  }
}
