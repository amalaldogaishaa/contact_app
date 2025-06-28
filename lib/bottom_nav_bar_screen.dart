import 'dart:io';
import 'package:contact_app/UserData.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contact_app/CustomElevatedButton.dart';
import 'package:contact_app/CustomTextFormField.dart';
import 'package:contact_app/CustomUnderlineTextField.dart';
import 'package:contact_app/colors.dart';
import 'package:email_validator/email_validator.dart';

class BottomNavBarScreen extends StatefulWidget {
  static const String routeName = '/navbar';

  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  File? _selectedImage;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      if (mounted) Navigator.pop(context);
    } else {}
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.none,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: _showImagePickerBottomSheet,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.buttonsColors,
                          width: 1.0,
                        ),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                "assets/images/image_pik.gif",
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CustomUnderlineTextField(
                        hintText: 'User Name',
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        hintStyle: TextStyle(color: AppColors.buttonsColors),
                        enabledBorderSide: BorderSide(
                          color: AppColors.buttonsColors,
                          width: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomUnderlineTextField(
                        hintText: 'example@email.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintStyle: TextStyle(color: AppColors.buttonsColors),
                        enabledBorderSide: BorderSide(
                          color: AppColors.buttonsColors,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomUnderlineTextField(
                        hintText: '+200000000000',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        hintStyle: TextStyle(color: AppColors.buttonsColors),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'Enter User Name',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter User Name';
                      }
                      if (RegExp(r'^\d+$').hasMatch(value)) {
                        return 'User Name cannot be numbers only';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Enter User Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter User Email...';
                      }
                      if (!value.contains('@') &&
                          !EmailValidator.validate(value)) {
                        return 'Invalid Email Format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: 'Enter User Phone',
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter User Phone';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Phone number must contain digits only';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'Enter user',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final user = User(
                    name: _nameController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneController.text,
                    imageUrl: _selectedImage?.path ?? '',
                    uniqueId: DateTime.now().millisecondsSinceEpoch.toString(),
                  );
                  Navigator.pop(context, user);
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
