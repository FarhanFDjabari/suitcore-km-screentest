import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitcore_screen_test/feature/third/third_controller.dart';
import 'package:suitcore_screen_test/feature/third/widgets/user_tile.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key, required this.controller}) : super(key: key);
  final ThirdController controller;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: controller.hasNext,
      controller: controller.refreshController,
      onRefresh: controller.getUsers,
      onLoading: controller.loadNextPage,
      child: ListView.builder(
          itemCount: controller.dataList.length,
          itemBuilder: (listContext, index) {
            return UserTile(
              user: controller.dataList[index],
              onPressed: () =>
                  controller.selectUser(controller.dataList[index]),
            );
          }),
    );
  }
}
