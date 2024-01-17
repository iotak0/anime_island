class Github {
  Github({
    this.downloadLink,
    this.newFeatures,
    this.version,
    this.adUrlFilters,
    this.versionNumber, // Added the new field here
  });

  final String? version;
  final String? newFeatures;
  final String? downloadLink;
  final List<String>? adUrlFilters;
  final String? versionNumber; // Declare the new field

  factory Github.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Github(
        version: json['version'],
        newFeatures: json['body'],
        downloadLink: json['download_link'],
        adUrlFilters: json['adUrlFilters'] != null
            ? List.generate(json['adUrlFilters'].length,
                (index) => json['adUrlFilters'][index])
            : null,
        versionNumber: json['version_number'], // Added this line
      );
    }
    return Github();
  }
}
