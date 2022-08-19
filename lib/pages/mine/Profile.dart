import 'package:dio/dio.dart';
import 'package:final_demo/providers/UserProvider.dart';
import 'package:final_demo/services/file/FileService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../utils/Global.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final picker = ImagePicker();
  File? _image;
  bool _isEditable = false;
  String _initText = '';
  String? tempPath;

  late TextEditingController _editingController;

  Future _takePhoto() async {
    // final pickedFile = await picker.getImage(source: ImageSource.camera);
    // if (pickedFile != null) {
    //   _image = File(pickedFile.path);
    //   String? path = _image?.path;
    //   print(path);
    //   var file = await MultipartFile.fromFile(path);
    //   var res = await FileService.singleUploadFile(
    //       file: FormData.fromMap({"file": file, "b": 1}));
    //   print(res);
    //   setState(() {
    //     tempPath = res['path'];
    //     // _image = File(pickedFile.path);
    //   });
    // }
  }

  /// 在相册选
  Future _takeGallery() async {
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   _image = File(pickedFile.path);
    //   String? path = _image?.path;
    //   print(path);
    //   var file = await MultipartFile.fromFile(path);
    //   var res = await FileService.singleUploadFile(
    //       file: FormData.fromMap({"file": file, "b": 1}));
    //   print(res);
    //
    //   setState(() {
    //     tempPath = res['path'];
    //     // _image = File(pickedFile.path);
    //   });
    // }
  }

  Widget renderBottomSheet(BuildContext context) {
    return Container(
      height: 160,
      child: Column(
        children: [
          Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  _takePhoto();
                  G.router.pop(context);
                },
                child: Text('拍照'),
              )),
          Container(
              alignment: Alignment.center,
              height: 50,
              child: InkWell(
                onTap: () {
                  _takeGallery();
                  G.router.pop(context);
                },
                child: Text('从相册中选择'),
              )),
          Container(
            color: Colors.grey[200],
            height: 10,
          ),
          Container(
              height: 50,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  G.router.pop(context);
                },
                child: Text('取消'),
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initText =
        G.getCurrentContext().watch<UserProvider>().userInfo['username'];
    _editingController = TextEditingController(text: _initText);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    Map userInfo = userProvider.userInfo;

    return Scaffold(
      appBar: AppBar(
        title: Text("个人资料"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text("头像"),
              // trailing: _image == null
              //     ? userInfo['avatar'] != null
              //         ? CircleAvatar(
              //             backgroundImage: NetworkImage(userInfo['avatar']),
              //           )
              //         : Icon(
              //             Icons.account_circle,
              //             size: 50,
              //           )
              //     : Image.file(_image!),
              trailing: tempPath != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(tempPath!),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return renderBottomSheet(context);
                    });
              },
            ),
            ListTile(
              title: Text("昵称"),
              trailing: renderUserName(),
            )
          ],
        ),
      ),
    );
  }

  renderUserName() {
    if (_isEditable) {
      return Container(
        width: 100,
        child: TextField(
          controller: _editingController,
          autofocus: true,
          onSubmitted: (value) {
            print(value);
            setState(() {
              _initText = value;
              _isEditable = false;
            });
          },
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            _isEditable = !_isEditable;
          });
        },
        child: Text(
          _initText,
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }
}
