import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/pages/home_page.dart';

class AppRoutes {
  static const home = "home";

  static Page _homePageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(child: HomePage());
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        name: home,
        path: "/",
        pageBuilder: _homePageBuilder,
      ),
    ],
  );

}