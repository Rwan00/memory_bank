import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField(
      {required this.title,
      required this.hint,
      this.controller,
      this.widget,
      super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin:  const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.aDLaMDisplay(),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: double.infinity,
              height: title == "Description"? height*0.12 : height*0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueGrey)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          maxLines: title == "Description"? 5:1,
                          controller: controller,
                          autofocus: false,
                          readOnly: widget != null ? true : false,
                          style: GoogleFonts.aDLaMDisplay(),
                          decoration:InputDecoration(
                            hintText: hint,
                            hintStyle: GoogleFonts.aDLaMDisplay(),

                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0
                              )
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent,
                                width: 0
                              ),
                            
                            )
                          ) ,
                        ),
                      ),
                  ),
                  widget ?? Container()
                ],
              ),
            ),
          ],
        ));
  }
}
