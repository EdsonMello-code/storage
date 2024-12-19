import 'package:storage/app/core/result.dart';
import 'package:storage/app/models/storage_file_model.dart';
import 'package:storage/app/models/system_info_model.dart';

abstract interface class IStorageRepository {
  Future<Result<List<StorageFileModel>>> getFileStorages([int page = 0]);
  Future<Result<void>> uploadFile(String filePath);
  Future<Result<List<StorageFileModel>>> searchBy(StorageFileModel filePath);
  Future<Result<SystemInfoModel>> getSystemInfo();
}
