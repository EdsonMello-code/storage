import 'package:intl/intl.dart';

class StorageFileModel {
  final int id;
  final String assetName;
  final DateTime createdAt, updatedAt;
  final double fileSize;
  final FileType fileType;

  String get updateAtFormated => DateFormat.yMd().format(updatedAt);
  String get createAtFormated => DateFormat.yMd().format(createdAt);

  String get nomeWithoutExtension => assetName.split('.').first;

  const StorageFileModel({
    required this.id,
    required this.assetName,
    required this.createdAt,
    required this.updatedAt,
    required this.fileSize,
    required this.fileType,
  });

  factory StorageFileModel.empty() {
    return StorageFileModel(
      assetName: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      fileSize: 0.0,
      fileType: FileType.image,
      id: -1,
    );
  }

  factory StorageFileModel.fromMap(Map<String, dynamic> map) {
    return StorageFileModel(
      id: map['id'],
      assetName: map['assetName'],
      createdAt: DateTime.parse(map['createAt']),
      updatedAt: DateTime.parse(map['updateAt']),
      fileSize: map['fileSize'].toDouble(),
      fileType: FileType.fromString(
        map['fileType'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assetName': assetName,
      'createAt': createdAt.toIso8601String(),
      'updateAt': updatedAt.toIso8601String(),
      'fileSize': fileSize,
      'fileType': fileType.message,
    };
  }
}

enum FileType {
  image('image'),
  video('video'),
  compacted('compacted'),
  genericFile('genericFile');

  final String message;

  static FileType fromString(String value) => values.firstWhere(
        (item) => item.message.contains(value),
      );

  const FileType(this.message);
}
