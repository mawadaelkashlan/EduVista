import 'package:edu_vista/services/user_service.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileImage extends StatefulWidget {
  final String? downloadUrl;

  const ProfileImage({super.key, this.downloadUrl});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  bool _isUploading = false;
  String? downloadUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfileImage();
  }

  void _loadUserProfileImage() {
    setState(() {
      downloadUrl = widget.downloadUrl ?? UserService.getProfileImageUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_isUploading) const Center(child: CircularProgressIndicator()),
        Container(
          padding: EdgeInsets.zero,
          width: 88,
          height: 88,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: downloadUrl != null ? NetworkImage(downloadUrl!) : null,
            radius: 44,
            child: downloadUrl == null
                ? SvgPicture.asset(ImageUtility.profile, fit: BoxFit.cover)
                : null,
          ),
        ),
        Positioned(
          bottom: 5,
          child: GestureDetector(
            onTap: () async {
              var imageResult = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
              if (imageResult != null) {
                var storageRef = FirebaseStorage.instance.ref('images/${imageResult.files.first.name}');
                try {
                  var uploadResult = await storageRef.putData(
                    imageResult.files.first.bytes!,
                    SettableMetadata(
                      contentType: 'image/${imageResult.files.first.name.split('.').last}',
                    ),
                  );

                  if (uploadResult.state == TaskState.success) {
                    downloadUrl = await uploadResult.ref.getDownloadURL();
                    setState(() {});
                    print('>>>>> Image uploaded: $downloadUrl');

                    // Update user's photoURL
                    await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
                    await FirebaseAuth.instance.currentUser?.reload();
                    setState(() {
                      downloadUrl = FirebaseAuth.instance.currentUser?.photoURL;
                    });
                  } else {
                    print('Upload failed');
                  }
                } catch (e) {
                  print('Error uploading image: $e');
                }
              } else {
                print('No file selected');
              }
            },
            child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(ImageUtility.camera)),
          ),
        ),
      ],
    );
  }
}
