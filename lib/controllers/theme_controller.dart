import 'package:flutter/material.dart';
import '../models/theme_item.dart';
import '../services/database_service.dart';

class ThemeController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<ThemeItem> _themes = [];
  ThemeItem? _currentTheme;
  bool _isLoading = false;

  List<ThemeItem> get themes => _themes;
  ThemeItem? get currentTheme => _currentTheme;
  bool get isLoading => _isLoading;

  Future<void> loadThemes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _themes = await _db.getThemes();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> purchaseTheme(
    String userId,
    String themeId,
    int userPoints,
    int themeCost,
  ) async {
    if (userPoints < themeCost) {
      return false;
    }

    try {
      await _db.purchaseTheme(userId, themeId, themeCost);
      return true;
    } catch (e) {
      return false;
    }
  }

  void setCurrentTheme(ThemeItem theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}