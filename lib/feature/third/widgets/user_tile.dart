import 'package:flutter/material.dart';
import 'package:suitcore_screen_test/model/user.dart';

class UserTile extends StatelessWidget {
  const UserTile({required this.user, Key? key, this.onPressed})
      : super(key: key);
  final User user;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      leading: CircleAvatar(
        radius: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            '${user.avatarUrl}',
            scale: 0.95,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        '${user.firstName} ${user.lastName}',
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        '${user.email}',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
