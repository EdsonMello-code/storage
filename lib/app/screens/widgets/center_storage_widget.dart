import 'package:flutter/material.dart';
import 'package:storage/app/core/extensions.dart';
import 'package:storage/app/models/storage_file_model.dart';
import 'package:storage/app/screens/widgets/storage_list_tile_widget.dart';

class CenterStorageWidget extends StatelessWidget {
  final List<StorageFileModel> storages;

  const CenterStorageWidget({
    super.key,
    required this.storages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: context.appTheme.black500,
                            ),
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        context.appTheme.blue,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      fixedSize: WidgetStatePropertyAll(
                        Size(96, 41),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: context.appTheme.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StorageListTileWidget(
              storages: storages,
            ),
          ],
        ),
      ),
    );
  }
}
