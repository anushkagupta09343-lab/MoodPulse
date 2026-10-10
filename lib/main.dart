import 'package:flutter/material.dart';

void main() {
  runApp(const MoodPulseApp());
}

class MoodPulseApp extends StatelessWidget {
  const MoodPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoodPulse',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF10101A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB9A1FF),
          brightness: Brightness.dark,
        ),
      ),
      home: const MoodHomeScreen(),
    );
  }
}

class MoodHomeScreen extends StatefulWidget {
  const MoodHomeScreen({super.key});

  @override
  State<MoodHomeScreen> createState() => _MoodHomeScreenState();
}

class _MoodHomeScreenState extends State<MoodHomeScreen> {
  String selectedMood = 'Calm';

  final List<Map<String, dynamic>> moods = [
    {
      'name': 'Happy',
      'emoji': '😊',
      'color': Color(0xFFFFC857),
    },
    {
      'name': 'Calm',
      'emoji': '🌿',
      'color': Color(0xFF79D8B0),
    },
    {
      'name': 'Sad',
      'emoji': '🌧️',
      'color': Color(0xFF8CA8FF),
    },
    {
      'name': 'Energetic',
      'emoji': '⚡',
      'color': Color(0xFFFF8A65),
    },
    {
      'name': 'Stressed',
      'emoji': '🫧',
      'color': Color(0xFFD4A5FF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentMood = moods.firstWhere(
      (mood) => mood['name'] == selectedMood,
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'MOODPULSE ✦',
              style: TextStyle(
                color: Color(0xFFB9A1FF),
                fontSize: 14,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'How are you\nfeeling today?',
              style: TextStyle(
                fontSize: 34,
                height: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Your mood matters. Take a moment for yourself.',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'CHOOSE YOUR MOOD',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: moods.map((mood) {
                final isSelected =
                    selectedMood == mood['name'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood['name'];
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? mood['color']
                          : const Color(0xFF20202E),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? mood['color']
                            : Colors.white12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mood['emoji'],
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          mood['name'],
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF171522)
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: currentMood['color'].withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: currentMood['color'].withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'YOUR CURRENT VIBE',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Text(
                        currentMood['emoji'],
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Feeling ${currentMood['name']}',
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    getMoodMessage(selectedMood),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'A LITTLE SOMETHING FOR YOU',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            Card(
              color: const Color(0xFF20202E),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF39304F),
                  child: Icon(
                    Icons.headphones_rounded,
                    color: Color(0xFFCFBFFF),
                  ),
                ),
                title: Text(
                  getActivityTitle(selectedMood),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(getActivityDescription(selectedMood)),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMoodMessage(String mood) {
    switch (mood) {
      case 'Happy':
        return 'Hold on to this little spark. You deserve moments like these.';
      case 'Calm':
        return 'There is no rush. Enjoy this moment and let yourself breathe.';
      case 'Sad':
        return 'You do not have to feel okay all the time. Be gentle with yourself.';
      case 'Energetic':
        return 'You have some energy to spare. Find something fun to do with it!';
      case 'Stressed':
        return 'Take things one step at a time. You do not have to solve everything now.';
      default:
        return 'Take a moment to check in with yourself.';
    }
  }

  String getActivityTitle(String mood) {
    switch (mood) {
      case 'Happy':
        return 'Make a happy playlist';
      case 'Calm':
        return 'Enjoy a quiet moment';
      case 'Sad':
        return 'Listen to something comforting';
      case 'Energetic':
        return 'Move to your favourite beat';
      case 'Stressed':
        return 'Try a breathing break';
      default:
        return 'Take a moment for yourself';
    }
  }

  String getActivityDescription(String mood) {
    switch (mood) {
      case 'Happy':
        return 'Save your favourite songs and enjoy the moment.';
      case 'Calm':
        return 'Put on some soft music and take a little break.';
      case 'Sad':
        return 'Choose music that feels comforting to you.';
      case 'Energetic':
        return 'Stretch, dance, or take a refreshing walk.';
      case 'Stressed':
        return 'Pause for a moment and take a few comfortable breaths.';
      default:
        return 'Do something kind for yourself today.';
    }
  }
}