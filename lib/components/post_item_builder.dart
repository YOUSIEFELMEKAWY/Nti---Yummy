import 'package:flutter/material.dart';

import '../models/post.dart';

class PostItemBuilder extends StatelessWidget {
  final Post post;
  const PostItemBuilder({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          post.comment,
        ),
        subtitle: Text('${post.timestamp} minutes ago'),
        leading: ClipOval(
          child: Image.asset(
            post.profileImageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
