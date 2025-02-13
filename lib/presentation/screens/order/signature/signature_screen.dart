import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:io';

import '../../../../core/extensions/app_paddings.dart';
import '../../../providers/order_provider.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<String> _getDocumentPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _saveSignature() async {
    if (_controller.isNotEmpty) {
      final Uint8List? data = await _controller.toPngBytes();
      if (data != null) {
        final path = await _getDocumentPath();
        final filePath = '$path/signature.png';
        final file = File(filePath);
        await file.writeAsBytes(data);

        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);
        orderProvider.setSignaturePath(filePath);
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Signature Pad')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Signature(
                controller: _controller,
                height: 300,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _controller.clear,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(CircleBorder()),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 35,
                    color: Colors.white,
                  ).padAll(10),
                ),
                ElevatedButton(
                  onPressed: _saveSignature,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(CircleBorder()),
                  ),
                  child: Icon(
                    Icons.done_rounded,
                    size: 35,
                    color: Colors.white,
                  ).padAll(10),
                ),
              ],
            ),
          ],
        ),
      );
}
