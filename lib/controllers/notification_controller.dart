import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../services/database_service.dart';

class NotificationController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  void loadNotifications(String userId) {
    _isLoading = true;
    notifyListeners();

    _db.getNotifications(userId).listen((notifications) {
      _notifications = notifications;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> markAsRead(String notificationId) async {
    await _db.markNotificationAsRead(notificationId);
  }

  Future<void> markAllAsRead() async {
    for (var notification in _notifications) {
      if (!notification.isRead) {
        await _db.markNotificationAsRead(notification.id);
      }
    }
  }
}