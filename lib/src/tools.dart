import 'package:flutter/material.dart';
import 'package:my_website/src/definitions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import 'brand_icons.dart';
import 'theme.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      name,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  final double size;

  const ProfilePictureWidget({
    super.key,
    this.size = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image.asset(
        'assets/images/profile_photo.jpeg',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        // Theme Button
        Card(child: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Provider.of<ThemeProvider>(context).icon
        )),

        // Linker Page Button
        Card(child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: const Icon(Icons.link)
        )),

        // Github Button
        Card(child: IconButton(
          onPressed: () => launchUrlStr(githubLink),
          icon: const Icon(BrandIcons.github)
        )),

        // Share Button
        Card(child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const ShareDialog()
              );
            },
            icon: const Icon(Icons.share)
        )),
      ],
    );
  }
}

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key});

  @override
  Widget build(BuildContext context) {

    Clipboard.setData(const ClipboardData(text: linkerPageLink));

    const Color qrBackground = Color.fromARGB(255, 238, 248, 255); // needs a light background for better contrast for scanning.

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
          height: 270,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                color: qrBackground,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: qrBackground,
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/web_qr_code.png'),
                      fit: BoxFit.fitHeight
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(sharingPrompt, style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface)),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> launchUrlStr(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      //throw Exception('Could not launch $link'); // freeze's the code
      return false;
    }
    return true;
  }