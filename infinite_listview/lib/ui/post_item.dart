import 'package:flutter/material.dart';
import 'package:infinite_listview/model/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${post.id}"),
          Container(
            width: (MediaQuery.of(context).size.width - 40) * 7 / 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${post.title}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Text("${post.body}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
