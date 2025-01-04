import 'package:flutter/material.dart';

class VideoCall extends StatefulWidget {
  final VoidCallback onReturn;
  final VoidCallback onAudio;
  const VideoCall({
    super.key,
    required this.onReturn,
    required this.onAudio,
  });

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  bool isFrontCamera = true;
  bool isMuted = false;
  bool isSpeakerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Placeholder for the other person's "video feed"
          Container(
            color: Colors.black,
            child: Center(
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          // Placeholder for "your face" (small preview)
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: Center(
                child: Icon(
                  Icons.face,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Call Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Switch Camera Button (for simulation only, no real switching)
                  _buildActionButton(
                    icon: isMuted ? Icons.mic_off : Icons.mic,
                    color: isMuted ? Colors.red : Colors.white,
                    onPressed: () {
                      setState(() {
                        isMuted = !isMuted;
                      });
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.switch_camera,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        isFrontCamera = !isFrontCamera;
                      });
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.videocam,
                    color: Colors.white,
                    onPressed: () {
                      widget.onAudio();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Audio call simulated')),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                    color: isSpeakerOn ? Colors.green : Colors.white,
                    onPressed: () {
                      setState(() {
                        isSpeakerOn = !isSpeakerOn;
                      });
                    },
                  ),
                  // End Call Button
                  _buildActionButton(
                    icon: Icons.call_end,
                    color: Colors.red,
                    onPressed: () {
                      // Navigate back to the previous screen
                      widget.onReturn();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Button Widget
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }
}
