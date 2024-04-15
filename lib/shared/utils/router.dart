import 'package:go_router/go_router.dart';
import 'package:wave_app/layout/main_page.dart';
import 'package:wave_app/screens/center/center_page.dart';
import 'package:wave_app/screens/sections/section_page.dart';
import 'package:wave_app/screens/splash/splash_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
        path: '/section',
        name: 'section',
        builder: (context, state) {
          final data = state.extra! as Map<String, dynamic>;
          return SectionPage(listSection: (data['section']));
        }),
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) {
        final data = state.extra! as Map<String, dynamic>;
        return MainLayout(
          sectionMain: data['sectionMain'],
          homeModel: data['home'],
        );
      },
      /*   pageBuilder: (context, state) => MaterialPage(
        fullscreenDialog: true,
        child: MainLayout(sectionMain: Section()),
      ),*/
    ),
    GoRoute(
        path: '/center',
        name: 'center',
        builder: (context, state) {
          final data = state.extra! as Map<String, dynamic>;
          return CenterPage(currentStore: (data['currentStore']));
        }),
  ],
);
