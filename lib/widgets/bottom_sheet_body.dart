import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../database/db_helper.dart';
import 'input_field.dart';
import 'upload_img.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({super.key});

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String time = DateFormat('hh:mm a').format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromRGBO(250, 240, 230,0.4),
        width: double.infinity,
        height: height * 0.69,
        child: Column(
          children: [
            InputField(
              title: 'Title',
              hint: 'The title of your memory',
              controller: titleController,
            ),
            InputField(
              title: 'Description',
              hint: 'Describe your memory',
              controller: descController,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InputField(
                    title: "Date",
                    hint: DateFormat.yMd().format(selectedDate),
                    widget: IconButton(
                      onPressed: () => _getDateFromUser(),
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                  child: InputField(
                    title: "Time",
                    hint: time,
                    widget: IconButton(
                      onPressed: () => _getTimeFromUser(),
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: fetchImage,
              child: pickedImage == null
                  ? const UploadImg()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.file(pickedImage!,
                            fit: BoxFit.cover,
                            height: 190,
                            width: double.infinity),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8)),
                  ),
                  child: const Icon(Icons.delete_outline),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () => _validation(),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8)),
                    ),
                    child: const Icon(Icons.done_outline_sharp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    } else {
      print("IT'S NULL OR SOMETHING IS WRONG!!");
    }
  }

  _getTimeFromUser() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);

      setState(() {
        time = formattedTime;
      });
    } else {
      print("It's Null");
    }
  }

  final ImagePicker picker = ImagePicker();
  File? pickedImage;
  ImageProvider<Object>? imageProvider;

  fetchImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(image.path);
      imageProvider = FileImage(pickedImage!);
    });
  }

  _validation() async{
    if ((titleController.text.isNotEmpty) &&
        (descController.text.isNotEmpty)&&
        (pickedImage != null)
    ) {
      await insertToDatabase(
        title: titleController.text,
        desc: descController.text,
        img: pickedImage!.path,
        date: DateFormat.yMMMd().format(selectedDate),
        time: time,
      ).then((value) {
        getDataFromDatabase(database).then((value) {
          setState(() {
            memories = value;
          });
          print(memories);
        });
      });
      print(pickedImage!.path);
      Navigator.pop(context);
    } else if (titleController.text.isEmpty || descController.text.isEmpty || pickedImage == null) {
      showToast(
        "Required,All Fields Are Required",
        textStyle: GoogleFonts.aDLaMDisplay(color: Colors.grey),
        context: context,
        animation: StyledToastAnimation.rotate,
        reverseAnimation: StyledToastAnimation.fade,
        position: const StyledToastPosition(
            align: Alignment.bottomCenter, offset: 50),
        animDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor: const Color.fromRGBO(249, 249, 224, 0.6),
      );
    } else {
      print("############SOMETHING BAD HAPPENED##########");
    }
  }

}