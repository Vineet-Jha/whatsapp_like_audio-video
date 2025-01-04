import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class IncomingCallScreen extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;
  const IncomingCallScreen(
      {super.key, required this.onAccept, required this.onReject});

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    showIncomingCallNotification();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: onSelectNotification,
    );

    // TODO: implement initState
    super.initState();
  }

  Future<void> showIncomingCallNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'incoming_call_channel', // Channel ID
      'Incoming Calls', // Channel Name
      channelDescription: 'Channel for incoming call notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Incoming Call',
      fullScreenIntent: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Incoming Call', // Notification Title
      'Name is calling...', // Notification Body
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background design
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          // Name and Incoming Call text at the top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Incoming Call",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Profile placeholder or image in the center
          Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[800],
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          // Buttons for Accept and Decline
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Decline Button
                  GestureDetector(
                    onTap: () {
                      // Handle decline action
                      widget.onReject(); // Navigate back
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.call_end,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Decline",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Accept Button
                  GestureDetector(
                    onTap: () {
                      // Handle accept action
                      widget.onAccept();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.call,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Accept",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
