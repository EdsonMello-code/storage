import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:storage/app/core/choose_file_mixin.dart';
import 'package:storage/app/core/command.dart';
import 'package:storage/app/core/result.dart';
import 'package:storage/app/models/storage_file_model.dart';
import 'package:storage/app/models/system_info_model.dart';
import 'package:storage/app/repositories/i_storage_repository.dart';
import 'package:storage/app/repositories/storage_repository.dart';

class StorageViewModel with ChooseFileMixin {
  final IStorageRepository _storageRepository;
  late final listStoragesCommand =
      CommandWithArguments<List<StorageFileModel>, StorageFileModel?>(
    getStoragesByName,
  )..execute(null);

  late final getSystemInfrmationCommand =
      CommandWithoutArguments<SystemInfoModel>(
    _storageRepository.getSystemInfo,
  )..execute();

  late final uploadImageCommand = CommandWithArguments<void, String>(
    _storageRepository.uploadFile,
  );

  void uploadImageListener(BuildContext context) {
    final completed = uploadImageCommand.completed;
    if (completed) {
      final materialBanner = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Hey!!',
          message: 'Arquivo foi armazenado com sucesso!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.success,
          // to configure for material banner
          inMaterialBanner: true,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(materialBanner);

      uploadImageCommand.clearResult();
    }
  }

  StorageViewModel({required StorageRepository storageRepository})
      : _storageRepository = storageRepository;

  Future<Result<List<StorageFileModel>>> getStoragesByName(
      [StorageFileModel? storageFileModel]) async {
    if (storageFileModel == null) {
      return _storageRepository.getFileStorages();
    } else {
      return _storageRepository.searchBy(storageFileModel);
    }
  }

  Future<void> uploadFile() async {
    final image = await pickImageFromGallery();

    if (image == null) {
      return;
    }

    await uploadImageCommand.execute(image.path);
  }
}
