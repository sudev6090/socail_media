import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socail_api/controller/user_provider.dart';
import 'package:socail_api/model/users_model.dart';
import 'package:socail_api/service/user_function.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Followers')),
      ),
      body: FutureBuilder(
        future: fetchAllUsers(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('error${snapshot.error}'),
            );
          } else {
            return Consumer<UserProvider>(
              builder: (context, pro, child) {
                return ListView.separated(
                  itemCount: pro.users.length,
                  itemBuilder: (context, index) {
                    UsersModel data = pro.users[index];
                    final bool isFollowing = pro.isFollowinguser(data.id!);
                    return ListTile(
                      trailing: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 10)),
                              foregroundColor: WidgetStatePropertyAll(
                                  isFollowing ? Colors.black : Colors.white),
                              backgroundColor: WidgetStatePropertyAll(
                                  isFollowing ? Colors.white : Colors.blue)),
                          onPressed: () {
                            if (isFollowing) {
                              Userservice().unfollowuser(context, data.id!);
                              pro.removeFollowing(data.id!);
                            } else {
                              Userservice().followUser(context, data.id!);
                              pro.addfollowing(data.id!);
                            }
                          },
                          child: Text(isFollowing ? 'unfollow' : 'follow')),
                      title: Text(
                        data.username.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.blue),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> fetchAllUsers(BuildContext context) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    await provider.fetchusers(context);
  }
}