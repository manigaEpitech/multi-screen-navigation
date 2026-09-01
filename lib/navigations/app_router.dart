import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/details_sreen.dart';
import '../screens/add_recipe_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/detail/:id',
      name: 'detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailScreen(recipeId: id);
      },
    ),

    GoRoute(
      path: '/add',
      name: 'add_recipe',
      builder: (context, state) => const AddRecipeScreen(),
    ),

    GoRoute(
      path: '/setting',
      name: 'settings',
      builder: (context, state) => SettingsScreen(),
    ),
  ],
);
