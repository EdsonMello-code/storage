import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final completerController = Completer<VideoPlayerController>();

  @override
  void initState() {
    super.initState();

    getApplicationCacheDirectory().then((value) async {
      final outputPath = '${value.path}/output.mp4';
      await File(outputPath).delete();
      final fileExistes = await File(outputPath).exists();
      if (!fileExistes) {
        await File(outputPath).create();
      }

      UDPFileClient(outputPath).startReceiving();
      await Future.delayed(Duration(seconds: 10));

      completerController
          .complete(VideoPlayerController.file(File(outputPath)));

      (await completerController.future).initialize();
      (await completerController.future).play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: completerController.future,
            builder: (context, future) {
              if (future.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (future.connectionState == ConnectionState.done) {
                return VideoPlayer(future.data!);
              }

              return SizedBox.shrink();
            }),
      ),
    );
  }
}

class UDPFileClient {
  static const int PORT = 12346; // PORT + 1 do servidor
  final String outputPath;

  UDPFileClient(this.outputPath);

  Future<void> startReceiving() async {
    final socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      PORT,
    );

    print('Cliente UDP iniciado na porta $PORT');
    final outputFile = File(outputPath).openWrite();

    try {
      final Map<int, List<int>> bufferedChunks = {};
      int expectedSequence = 0;

      socket.listen((event) {
        if (event == RawSocketEvent.read) {
          final datagram = socket.receive();
          if (datagram == null) return;

          final data = datagram.data;
          if (data.length < 4) return;

          print(data);

          // Extrai o número de sequência do cabeçalho
          final sequenceNumber =
              data.buffer.asByteData().getInt32(0, Endian.big);

          // Verifica se é o pacote de finalização
          if (sequenceNumber == -1) {
            print('Recebimento concluído');
            outputFile.close();
            socket.close();
            return;
          }

          // Extrai os dados do chunk (removendo o cabeçalho)
          final chunkData = data.sublist(4);

          // Armazena o chunk no buffer
          bufferedChunks[sequenceNumber] = chunkData;

          // Processa chunks em ordem
          while (bufferedChunks.containsKey(expectedSequence)) {
            File(outputPath).length().then((value) {
              print('File size: $value');
            });
            final chunk = bufferedChunks.remove(expectedSequence)!;
            outputFile.add(chunk);

            print(
                'Processado chunk #$expectedSequence com ${chunk.length} bytes');
            expectedSequence++;
          }

          File(outputPath).length().then((value) {
            print('File size final: $value');
          });
        }
      });
    } catch (e) {
      print('Erro durante o recebimento: $e');
      await outputFile.close();
      socket.close();
    }
  }
}
