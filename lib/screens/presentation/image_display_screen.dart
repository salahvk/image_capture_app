import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_capture_app/utils/color_manager.dart';
import 'package:image_capture_app/utils/save_to_gallery.dart';
import 'package:image_capture_app/utils/style_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ImageDisplayScreen extends StatefulWidget {
  const ImageDisplayScreen({super.key});

  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      _cropImage();
    }
  }

  Future<void> _browseGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    final files = <XFile>[];

    files.add(XFile(
      _croppedFile?.path ?? '',
    ));
    await Share.shareXFiles(files,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: _croppedFile != null
                ? _image()
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorManager.textColor)),
                    height: size.height * .4,
                    child: Center(
                      child: Text(
                        "Upload an Image",
                        style: getRegularStyle(
                            color: ColorManager.textColor, fontSize: 15),
                      ),
                    ),
                  ),
          ),
          SizedBox(
              width: size.width * .45,
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          width: size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: size.width * .8,
                                child: ElevatedButton(
                                  child: const Text('Browse Gallery'),
                                  onPressed: () {
                                    _browseGallery();
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const Text("OR"),
                              SizedBox(
                                width: size.width * .8,
                                child: ElevatedButton(
                                  child: const Text('Use a Camera'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _uploadImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Capture"))),
          SizedBox(
            width: size.width * .45,
            child: ElevatedButton(
                onPressed: () async {
                  if (_croppedFile != null) {
                    _onShare(context);
                  }
                },
                child: const Text("Sent To Whatsapp")),
          ),
          SizedBox(
            width: size.width * .45,
            child: ElevatedButton(
                onPressed: () {
                  final file = File(_croppedFile?.path ?? '');
                  saveImageToGallery(file.path, context);
                },
                child: const Text("Save To gallery")),
          )
        ],
      )),
    );
  }

  Widget _image() {
    final size = MediaQuery.of(context).size;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
              fit: BoxFit.cover,
              width: size.width,
              height: size.height * .4,
              File(path)));
    } else {
      return const SizedBox.shrink();
    }
  }
}
