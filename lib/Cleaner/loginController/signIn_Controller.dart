/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uosc/Supervisor/Supervisor%20Dashboard/Supervisor%20Dashboard.dart';






class AppRouteNames {
  static const String WELCOME = "/";
  static const String SIGN_IN = "/signIn";
  static const String SIGN_UP = "/SignUpPage";
  static const String APPLICATION = "/application";
  static const String HOME = "/Home";
}

class RouteEntity {
  final String path;
  final Widget page;

  RouteEntity({required this.path, required this.page});
}

class AppPages {
  static List<RouteEntity> routes() {
    return [
      //RouteEntity(path: AppRouteNames.WELCOME, page: Welcome()),
      RouteEntity(path: AppRouteNames.SIGN_IN, page: SupervisorDashboard()),
      RouteEntity(path: AppRouteNames.SIGN_UP, page: SignUpPage()),
      RouteEntity(path: AppRouteNames.SIGN_UP, page: application()),
      RouteEntity(path: AppRouteNames.HOME, page: Home()),
    ];
  }


  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);

      if (result.isNotEmpty) {
        bool deviceFirstTime = Global.storageService.getDeviceOpenFirst();

        if (result.first.path == AppRouteNames.WELCOME&&deviceFirstTime) {

          bool isLoggedIn = Global.storageService.isloggedIn();
          if(isLoggedIn){
            return MaterialPageRoute(
              builder: (_) =>application(),
              settings: settings,
            );
          }else {
            return MaterialPageRoute(
              builder: (_) => Home(),
              settings: settings,
            );
          }
        }else{
          if(kDebugMode){
            print("App ran for the first time");
          }
          return MaterialPageRoute(
            builder: (_) =>result.first.page,
            settings: settings,
          );
        }
      }
    }

    // Default (fallback) route
    return MaterialPageRoute(
      builder: (_) => Welcome(),
      settings: settings,
    );
  }
}
*/

