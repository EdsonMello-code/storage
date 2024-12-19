import 'package:flutter/material.dart';

class RightStorageWidget extends StatelessWidget {
  const RightStorageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: Color(0xFFFFFFFF),
      width: MediaQuery.sizeOf(context).width * .18,
    );
  }
}
