import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class monday extends StatelessWidget {
  const monday({
    super.key,
    required this.height,
    required this.width,
    required this.day,
    required this.imgUrl,
    required this.degree,
  });

  final double height;
  final double width;
  final String day;
  final String imgUrl;
  final String degree;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: height * 0.2,
            width: width * 0.2,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 131, 109, 163),
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    day,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Image.network(imgUrl),
                Text(
                  degree.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
