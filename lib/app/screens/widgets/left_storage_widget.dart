import 'package:flutter/material.dart';
import 'package:storage/app/core/extensions.dart';
import 'package:storage/app/screens/widgets/storage_data_widget.dart';

class LeftStorageWidget extends StatelessWidget {
  final double totalInGB, freeInGB;

  const LeftStorageWidget({
    super.key,
    required this.totalInGB,
    required this.freeInGB,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: context.appTheme.blue,
      width: MediaQuery.sizeOf(context).width * .18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: context.appTheme.darkBlue,
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14.5,
                horizontal: 20,
              ),
              child: Text(
                'Storage',
                style: TextStyle(
                  color: context.appTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(),
          StorageDataWidget(
            totalInGB: totalInGB,
            freeInGB: freeInGB,
          ),
        ],
      ),
    );
  }
}
