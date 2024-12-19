import 'package:dio/dio.dart';
import 'package:storage/app/core/adapters/http_client/http_client.dart';
import 'package:storage/app/core/app_exception.dart';
import 'package:storage/app/core/result.dart';
import 'package:storage/app/models/storage_file_model.dart';
import 'package:storage/app/models/system_info_model.dart';
import 'package:storage/app/repositories/i_storage_repository.dart';

class StorageRepository implements IStorageRepository {
  final AppHttpClient appHttpClient;

  const StorageRepository({required this.appHttpClient});

  @override
  Future<Result<List<StorageFileModel>>> getFileStorages([int page = 0]) async {
    try {
      final response = await appHttpClient.get(
        '/storage-files',
        queryParameters: {
          'page': page,
        },
      );
      final storageFilesMap = List<Map<String, dynamic>>.from(response.data);

      final storageFiles =
          storageFilesMap.map(StorageFileModel.fromMap).toList();

      return Result.ok(storageFiles);
    } on AppException catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<StorageFileModel>>> searchBy(
      StorageFileModel storage) async {
    try {
      final response = await appHttpClient.get(
        '/search',
        queryParameters: storage.toMap(),
      );
      final storageFilesMap = List<Map<String, dynamic>>.from(response.data);

      final storageFiles =
          storageFilesMap.map(StorageFileModel.fromMap).toList();

      return Result.ok(storageFiles);
    } on AppException catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> uploadFile(String filePath) async {
    try {
      final fileMultipart = await MultipartFile.fromFile(filePath);
      final formData = FormData.fromMap({
        "files": fileMultipart,
      });
      await appHttpClient.post(
        '/file',
        data: formData,
      );

      return Result.ok('');
    } on AppException catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<SystemInfoModel>> getSystemInfo() async {
    try {
      final response = await appHttpClient.get(
        '/server-info',
      );
      final systemInfoMap = Map<String, dynamic>.from(response.data);

      final systemInfo = SystemInfoModel.fromMap(systemInfoMap);

      return Result.ok(systemInfo);
    } on AppException catch (error) {
      return Result.error(error);
    }
  }
}
