import 'package:flutter/material.dart';
import 'package:storage/app/core/extensions.dart';
import 'package:storage/app/models/storage_file_model.dart';

class StorageListTileWidget extends StatelessWidget {
  final List<StorageFileModel> storages;

  const StorageListTileWidget({
    super.key,
    required this.storages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: storages
            .map((storageItem) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 41,
                                  color: context.appTheme.white,
                                ),
                                Text(
                                  storageItem.assetName,
                                  style: TextStyle(
                                    color: context.appTheme.black500,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              storageItem.createAtFormated,
                              style: TextStyle(
                                color: context.appTheme.black500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              storageItem.updateAtFormated,
                              style: TextStyle(
                                color: context.appTheme.black500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 1,
                      color: Color(0xFF9EB0BD),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
