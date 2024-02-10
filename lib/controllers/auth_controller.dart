import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/welcome_screen.dart';
import '../controllers/note_controller.dart';
import '../api/google_signin_api.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var noteController = Get.put(NoteController());

  @override
  void onInit() {
    redirect();
    // noteController.getNotes();
    super.onInit();
  }

  Future<void> redirect() async {
    var token = await GetStorage().read('login_token');
    if (token != null) {
      isLoggedIn.value = true;
    }
    Get.off(() => WelcomeScreen());
  }

  Future<void> loginWithGoogle() async{
    await GoogleSignInApi.login();
  }


}
