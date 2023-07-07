import 'package:flutter/material.dart';

class ImageDisplayScreen extends StatelessWidget {
  const ImageDisplayScreen({super.key});

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
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              height: size.height * .4,
            ),
          ),
          SizedBox(
              width: size.width * .45,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Capture"))),
          SizedBox(
            width: size.width * .45,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Sent To Whatsapp")),
          ),
          SizedBox(
            width: size.width * .45,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Save To gallery")),
          )
        ],
      )),
    );
  }
}
