import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shop_now_backend/constant/image_string.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shop_now_backend/constant/my_theme.dart';

class ImagePicker extends StatefulWidget {
  final File? selectedImage;
  final void Function(File? file) onImageSelected;
  final void Function() onImageDelete;

  const ImagePicker({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
    required this.onImageDelete,
  });

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);

      widget.onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            DottedBorder(
              strokeWidth: 2,
              color: MyTheme.lightGrey,
              borderType: BorderType.RRect,
              radius: Radius.circular(5),
              padding: EdgeInsets.all(6),
              child:
                  widget.selectedImage != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(widget.selectedImage!, height: 150),
                      )
                      : InkWell(
                        onTap: pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageString.imageUploadIcon,
                                height: 50,
                                width: 50,
                              ),
                              const Text('Please select image!'),
                            ],
                          ),
                        ),
                      ),
            ),
            if (widget.selectedImage != null)
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: widget.onImageDelete,
                  child: Icon(Icons.delete_forever, color: Colors.red),
                ),
              ),
          ],
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
