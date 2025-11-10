import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'utils/routes.dart';
import 'config/theme_config.dart';
import 'controllers/auth_controller.dart';
import 'controllers/course_controller.dart';
import 'controllers/quiz_controller.dart';
import 'controllers/progress_controller.dart';
import 'controllers/reward_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/notification_controller.dart';
import 'controllers/admin_controller.dart';
import 'services/storage_service.dart';
import 'views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize local storage
  await StorageService.init();
  
  runApp(const ELearningApp());
}

class ELearningApp extends StatelessWidget {
  const ELearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => CourseController()),
        ChangeNotifierProvider(create: (_) => QuizController()),
        ChangeNotifierProvider(create: (_) => ProgressController()),
        ChangeNotifierProvider(create: (_) => RewardController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => AdminController()),
      ],
      child: MaterialApp(
        title: 'E-Learning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
        home: const LoginScreen(),
      ),
    );
  }
}