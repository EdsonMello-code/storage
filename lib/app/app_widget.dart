import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:go_router/go_router.dart';
import 'package:storage/app/core/adapters/http_client/implementations/dio_http_client.dart';
import 'package:storage/app/core/theme.dart';
import 'package:storage/app/repositories/storage_repository.dart';
import 'package:storage/app/screens/view_models/storage_view_model.dart';
import 'package:storage/app/screens/widgets/home_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: Theme.themeData,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(
        storageViewModel: StorageViewModel(
          storageRepository: StorageRepository(
            appHttpClient: DioHttpClient(
              dio: Dio(
                BaseOptions(
                  baseUrl: 'http://192.168.1.145:3000',
                ),
              ),
            ),
          ),
        ),
      ),
    )
  ],
);
