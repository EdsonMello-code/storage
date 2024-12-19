import 'package:flutter/material.dart';
import 'package:storage/app/core/result.dart';
import 'package:storage/app/models/storage_file_model.dart';
import 'package:storage/app/models/system_info_model.dart';
import 'package:storage/app/screens/view_models/storage_view_model.dart';
import 'package:storage/app/screens/widgets/center_storage_widget.dart';
import 'package:storage/app/screens/widgets/left_storage_widget.dart';
import 'package:storage/app/screens/widgets/right_storage_widget.dart';

class HomeScreen extends StatefulWidget {
  final StorageViewModel _storageViewModel;

  const HomeScreen({super.key, required StorageViewModel storageViewModel})
      : _storageViewModel = storageViewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    widget._storageViewModel.uploadImageCommand.addListener(
      () => widget._storageViewModel.uploadImageListener(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      floatingActionButton: FloatingActionButton(
        onPressed: widget._storageViewModel.uploadFile,
      ),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          widget._storageViewModel.listStoragesCommand,
          widget._storageViewModel.getSystemInfrmationCommand,
        ]),
        builder: (context, child) {
          final result = widget._storageViewModel.listStoragesCommand.result;
          final running = widget._storageViewModel.listStoragesCommand.running;
          final systemInfoResult =
              widget._storageViewModel.getSystemInfrmationCommand.result;
          double totalMem = 0;
          double freemem = 0;

          if (systemInfoResult is Ok<SystemInfoModel>) {
            totalMem = systemInfoResult.value.totalmem;
            freemem = systemInfoResult.value.freemem;
          }

          if (running) {
            return Center(child: CircularProgressIndicator());
          }

          if (result is Ok<List<StorageFileModel>>) {
            return Row(
              children: [
                LeftStorageWidget(
                  totalInGB: totalMem,
                  freeInGB: freemem,
                ),
                Expanded(
                    child: CenterStorageWidget(
                  storages: result.value,
                )),
                RightStorageWidget(),
              ],
            );
          }

          return Text('');
        },
      ),
    );
  }
}
