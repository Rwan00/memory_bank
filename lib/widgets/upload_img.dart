import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadImg extends StatelessWidget {
  const UploadImg({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(16),
        height: height*0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
         //border: Border.all(style: BorderStyle.solid),
         color: Colors.grey[300],
        ),
      child: DottedBorder(
        color: Colors.black.withOpacity(0.4),
      strokeWidth: 1,
      padding: const EdgeInsets.all(8),
      radius: const Radius.circular(15),
      borderType: BorderType.RRect,
      dashPattern : const <double>[8, 3],
       child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Icon(Icons.image_rounded,size: 64,color: Colors.grey,),
           SizedBox(height: height*0.03,),
          Text("Upload Photo Of Your Memory",style: GoogleFonts.aDLaMDisplay(color: Colors.grey),)
        ]),
       ),
        
    
      ),
    );
  }
}