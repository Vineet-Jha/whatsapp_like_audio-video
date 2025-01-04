import 'package:flutter/material.dart';

class AudioCall extends StatefulWidget {
  final VoidCallback onReturn;
  final VoidCallback onVideo;
  const AudioCall({super.key, required this.onReturn, required this.onVideo});

  @override
  State<AudioCall> createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {
  bool isMuted = false;
  bool isSpeakerOn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Color
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            // Transparent Overlay
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular Placeholder for Profile
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[800],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 20),
                // Contact Name and Call Status
                const Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Calling',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                // Call Controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Mute Button
                      _buildActionButton(
                        icon: isMuted ? Icons.mic_off : Icons.mic,
                        color: isMuted ? Colors.red : Colors.white,
                        onPressed: () {
                          setState(() {
                            isMuted = !isMuted;
                          });
                        },
                      ),
                      // Video Button (Placeholder)
                      _buildActionButton(
                        icon: Icons.videocam_off,
                        color: Colors.white,
                        onPressed: () {
                          widget.onVideo();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Video call simulated')),
                          );
                        },
                      ),
                      // Speaker Button
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
                          widget.onReturn();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
