import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restaurant_app/utils/colors.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  final List<TeamMember> teamMembers = [
    TeamMember(
      name: "Maroua OURAHMA",
      email: "marouaourahma@gmail.com",
      avatarPath: "assets/images/maroua.png",
    ),
    TeamMember(
      name: "Wiame ANEJJAR",
      email: "wiameanejjar@gmail.com",
      avatarPath: "assets/images/wiame.jpg",
    ),
  ];

  final List<Tech> technologies = [
    Tech(
      name: "Flutter",
      description: "UI framework for building native cross-platform apps.",
      imagePath: "assets/images/flutter.png",
    ),
    Tech(
      name: "Dart",
      description: "Object-oriented programming language used with Flutter.",
      imagePath: "assets/images/dart.png",
    ),
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Contact via the application'},
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open mail application")),
      );
    }
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      final feedback = _feedbackController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thank you for your feedback!")),
      );
      _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Team", style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          Switch.adaptive(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: teamMembers.map((member) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(member.avatarPath),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      member.name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () => _launchEmail(member.email),
                      child: Text(
                        member.email,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Technologies
            Text(
              "Technologies Used",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            Column(
              children: technologies.map((tech) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: AppColors.yellow,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.asset(
                          tech.imagePath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tech.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                tech.description,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Feedback form
            Text(
              "Send Feedback",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _feedbackController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Your message",
                      filled: true,
                      fillColor: themeProvider.isDarkMode ? AppColors.textDark : AppColors.textLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.green, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a message";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitFeedback,
                      icon: const Icon(Icons.send),
                      label: Text("Send", style: Theme.of(context).textTheme.bodySmall),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String email;
  final String avatarPath;

  TeamMember({
    required this.name,
    required this.email,
    required this.avatarPath,
  });
}

class Tech {
  final String name;
  final String description;
  final String imagePath;

  Tech({
    required this.name,
    required this.description,
    required this.imagePath,
  });
}
