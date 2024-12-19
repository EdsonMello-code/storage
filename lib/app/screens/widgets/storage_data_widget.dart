import 'package:flutter/material.dart';
import 'package:storage/app/core/extensions.dart';

class StorageDataWidget extends StatelessWidget {
  final double totalInGB, freeInGB;
  const StorageDataWidget({
    super.key,
    required this.totalInGB,
    required this.freeInGB,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 41,
          right: 41,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: Icon(
                    Icons.cloud,
                    color: context.appTheme.white,
                  ),
                ),
                Text(
                  'My Storage',
                  style: TextStyle(
                    color: context.appTheme.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            LinearProgressIndicator(
              value: .2,
              color: context.appTheme.naveBlue,
              minHeight: 9,
              borderRadius: BorderRadius.circular(13),
            ),
            Text(
              'Voce usou ${(freeInGB).abs()} GB de $totalInGB GB.',
              style: TextStyle(
                color: context.appTheme.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
