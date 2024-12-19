class SystemInfoModel {
  final double freemem;
  final double totalmem;

  const SystemInfoModel({
    required this.freemem,
    required this.totalmem,
  });

  factory SystemInfoModel.fromMap(Map<String, dynamic> map) {
    return SystemInfoModel(
      freemem: map['totalmem'].toDouble(),
      totalmem: map['freemem'].toDouble(),
    );
  }
}
