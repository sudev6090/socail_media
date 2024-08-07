import 'package:flutter/material.dart';
import 'package:socail_api/model/users_model.dart';
import 'package:socail_api/service/user_function.dart';

class UserProvider extends ChangeNotifier {
  List<UsersModel> users = [];
  List<String> followingusers = [];

  Future<void> fetchusers(BuildContext context) async {
    try {
      final response = await Userservice.fetchallusers();
      if (response.isEmpty) {
        throw Exception('failed to fetch data');
      }
      users = response;
    } catch (e) {
      Center(
        child: Text('error $e'),
      );
    }
    notifyListeners();
  }

  void addfollowing(String userId) {
    if (!followingusers.contains(userId)) {
      followingusers.add(userId);
    }
    notifyListeners();
  }

  void removeFollowing(String userId) {
    followingusers.remove(userId);
    notifyListeners();
  }

  bool isFollowinguser(String userId) {
    return followingusers.contains(userId);
  }
}
