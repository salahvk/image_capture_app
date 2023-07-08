import 'package:flutter/material.dart';
import 'package:image_capture_app/screens/presentation/image_display_screen.dart';
import 'package:image_capture_app/screens/presentation/start_screen.dart';

class Routes {
  static const String startScreen = '/';
  static const String imageDisplayScreen = '/imageDisplayScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.startScreen:
        return FadePageRoute(page: const StartScreen());
      case Routes.imageDisplayScreen:
        return FadePageRoute(page: const ImageDisplayScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
