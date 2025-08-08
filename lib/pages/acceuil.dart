import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restaurant_app/utils/colors.dart';
import 'package:restaurant_app/utils/theme_provider.dart';

class Acceuil extends StatelessWidget {
  final String name;
  final String desc;
  final String telephone;
  final String addresse;

  const Acceuil({
    super.key,
    required this.name,
    required this.desc,
    required this.telephone,
    required this.addresse,
  });

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (!await launchUrl(phoneUri)) {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      debugPrint('Error launching phone call: $e');
      // You can also show a snackbar or dialog here if you want
    }
  }

  Future<void> _launchMaps(String query) async {
    final Uri googleMapsUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {'api': '1', 'query': query},
    );

    try {
      if (!await launchUrl(googleMapsUri)) {
        throw 'Could not open Google Maps for $query';
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Golden Fork",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/logo2.png"),
            ),
            const SizedBox(height: 15),
            Text(
              "The restaurant that puts little dishes in the big ones.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 32,
                  color: AppColors.green,
                  icon: const Icon(Icons.place),
                  onPressed: () {
                    _launchMaps(addresse);
                  },
                ),
                const SizedBox(width: 40),
                IconButton(
                  iconSize: 32,
                  color: AppColors.yellow,
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    _launchPhone(telephone);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Card(
              shadowColor: AppColors.primary,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Restaurant Name:",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(name, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 20),
                    Text("Description:",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(desc, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 20),
                    Text("Address:",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(addresse,
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 20),
                    Text("Phone:",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(telephone,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
