import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/helper/db_helper.dart';
import 'package:todo_riverpod/common/models/user_model.dart';
import 'package:todo_riverpod/features/onboarding/onboarding_screen.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';
import 'package:todo_riverpod/main.dart';

final userProvider = StateNotifierProvider<UserState, List<UserModel>>((ref) {
  return UserState();
});

class UserState extends StateNotifier<List<UserModel>> {
  UserState() : super([]);
  void refresh() async {
    final data = await DBHelper.getUsers();
    state = data.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<void> logout(int id) async {
    await DBHelper.logout(id);
    refresh();
    defaultEntry(state);
  }

// entry point

  defaultEntry(List<UserModel> users) {
    if (users.isNotEmpty) {
      entrypoint = const HomePage();
    } else {
      entrypoint = const HomePage();
    }
    return entrypoint;
  }
}
