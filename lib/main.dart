import 'package:flutter/material.dart';
import 'package:whatsapp_like_audio_video/audio_call.dart';
import 'package:whatsapp_like_audio_video/incoming_call.dart';
import 'package:whatsapp_like_audio_video/video_call.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CallApp());
}

class CallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CallHomeScreen(),
    );
  }
}

class CallHomeScreen extends StatefulWidget {
  @override
  _CallHomeScreenState createState() => _CallHomeScreenState();
}

class _CallHomeScreenState extends State<CallHomeScreen> {
  String callState = 'Idle'; // Idle, Ringing, InCall
  bool isMuted = false;
  bool isVideo = false;

  void startCall(bool video) {
    setState(() {
      isVideo = video;
      callState = 'InCall';
    });
  }

  void simulateIncomingCall() {
    setState(() {
      callState = 'Ringing';
    });
  }

  void acceptCall() {
    setState(() {
      callState = 'InCall';
      isVideo = false;
    });
  }

  void declineCall() {
    setState(() {
      callState = 'Idle';
    });
  }

  void endCall() {
    setState(() {
      callState = 'Idle';
    });
  }

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Call Interface'),
        //   centerTitle: true,
        // ),
        body: Center(
          child: callState == 'Idle'
              ? buildIdleView()
              : callState == 'Ringing'
                  ? IncomingCallScreen(
                      onAccept: () {
                        setState(() {
                          callState = 'InCall';
                          isVideo = false;
                        });
                      },
                      onReject: () {
                        setState(() {
                          callState = 'Idle';
                        });
                      },
                    )
                  : isVideo
                      ? VideoCall(
                          onAudio: () {
                            setState(() {
                              callState = 'InCall';
                              isVideo = false;
                            });
                          },
                          onReturn: () {
                            setState(() {
                              callState = 'Idle';
                            });
                          },
                        )
                      : AudioCall(
                          onVideo: () {
                            setState(() {
                              callState = 'InCall';
                              isVideo = true;
                            });
                          },
                          onReturn: () {
                            setState(() {
                              callState = 'Idle';
                            });
                          },
                        ),
        ),
      ),
    );
  }

  Widget buildIdleView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => startCall(false),
          child: const Text('Start Audio Call'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => startCall(true),
          child: const Text('Start Video Call'),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: simulateIncomingCall,
          child: const Text('Simulate Incoming Call'),
        ),
      ],
    );
  }

  Widget buildIncomingCallView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Incoming Call...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: acceptCall,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Accept'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: declineCall,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Decline'),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInCallView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isVideo)
          Container(
            height: 200,
            width: 200,
            color: Colors.black26,
            child: const Center(
              child: Text(
                'Video Feed Placeholder',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        else
          const Icon(
            Icons.account_circle,
            size: 100,
            color: Colors.grey,
          ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: toggleMute,
              style: ElevatedButton.styleFrom(
                  backgroundColor: isMuted ? Colors.orange : Colors.blue),
              child: Text(isMuted ? 'Unmute' : 'Mute'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: endCall,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('End Call'),
            ),
            if (isVideo) ...[
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Placeholder for switch camera functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Switch Camera simulated')));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text('Switch Camera'),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
