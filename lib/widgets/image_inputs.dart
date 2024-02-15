import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onselectImage;
  const ImageInput(this.onselectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      // User cancelled the picker
      return;
    }

    setState(() {
      _storedImage = File(pickedImage.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedImage.path);
    final savedImage =
        await File(pickedImage.path).copy('${appDir.path}/$fileName');
    widget.onselectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(
              Icons.camera,
              color: Colors.indigo,
            ),
            label: const Text(
              'Take Picture',
              style: TextStyle(color: Colors.indigo),
            ),
          ),
        ),
      ],
    );
  }
}
