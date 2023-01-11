import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clone/common/widgets/short_h_bar.dart';
import 'package:whatsapp_clone/features/auth/pages/image_picker_page.dart';
import 'package:whatsapp_clone/features/auth/widgets/custom_text_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShortHBar(),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Profile photo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                CustomIconButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Divider(
              color: context.color.greyColor!.withOpacity(0.3),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                imagePickerIcon(
                  onTap: pickImagefromCamera,
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                ),
                const SizedBox(
                  width: 15,
                ),
                imagePickerIcon(
                  onTap: () async {
                    Navigator.pop(context);
                    final image = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImagePickerPage(),
                      ),
                    );
                    if (image == null) return;
                    setState(() {
                      imageGallery = image;
                      imageCamera = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: 'Gallery',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }

  pickImagefromCamera() async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(
        context: context,
        message: e.toString(),
      );
    }
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          icon: icon,
          iconColor: Coloors.greenDark,
          minWidth: 50,
          border: Border.all(
            color: context.color.greyColor!.withOpacity(.2),
            width: 1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: context.color.greyColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Profile info',
          style: TextStyle(
            color: context.color.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Please provide your name and an optional profile photo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.color.greyColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.color.photoIconBgColor,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        : context.color.greyColor!.withOpacity(0.4),
                  ),
                  image: imageCamera != null || imageGallery != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: imageGallery != null
                              ? MemoryImage(imageGallery!) as ImageProvider
                              : FileImage(imageCamera!),
                        )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 3,
                    right: 3,
                  ),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageCamera == null && imageGallery == null
                        ? context.color.photoIconColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                  child: CustomTextField(
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.color.photoIconColor,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: () {},
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}
