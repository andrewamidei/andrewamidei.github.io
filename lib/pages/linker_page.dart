import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../src/tools.dart';
import '../src/definitions.dart';
import '../src/brand_icons.dart';
import '../src/theme.dart';

class LinkerPage extends StatefulWidget {
  const LinkerPage({super.key});

  @override
  State<LinkerPage> createState() => _LinkerPageState();
}

class _LinkerPageState extends State<LinkerPage> {

  final double padding = 20;

  @override
  Widget build(BuildContext context) {

    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Provider.of<ThemeProvider>(context).patternPath),
            opacity: 0.6,
            fit: BoxFit.cover,
          )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: 450,
              child: Card(
                color: Theme.of(context).colorScheme.surfaceDim,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                    child: CustomScrollView(
                    center: centerKey,
                    slivers:<Widget> [
                      SliverList(
                        key: centerKey,
                        delegate: SliverChildBuilderDelegate(
                          childCount: 1, // do not make any duplicates
                          (BuildContext context, int index) {
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                const ProfilePictureWidget(size: 180),
                                const SizedBox(height: 20),
                                const NameWidget(),
                                const SizedBox(height: 20),
                                const SubtitleWidget(),
                                const SizedBox(height: 20),
                                
                                // Website Page
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(const Size(400, 60)),
                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  icon: const Icon(Icons.web, color: Colors.white),
                                  label: const Text('Website', style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(height: padding),
                            
                                linkButton('Linkedin', BrandIcons.linkedin, Colors.white, const Color.fromARGB(255, 10, 102, 194), linkedinLink),
                                SizedBox(height: padding),

                                linkButton('Github', BrandIcons.github, Colors.white, const Color.fromARGB(255, 0, 0, 0), githubLink),
                                SizedBox(height: padding),
                            
                                // Resume Button
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(const Size(400, 60)),
                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary),
                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  ),
                                  onPressed: () => downloadFile(resumeFileLocation),
                                  icon: const Icon(Icons.description, color: Colors.white),
                                  label: const Text('Resume', style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(height: padding),
                            
                                // Share Button
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(const Size(400, 60)),
                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => const ShareDialog()
                                    );
                                  },
                                  icon: const Icon(Icons.share, color: Colors.white),
                                  label: const Text('Share', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ]
                  )
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = resumeFileName;
    anchorElement.click();
  }


  ElevatedButton linkButton(String labelText, IconData icon, Color textColor, Color backgroundColor, String link) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(400, 60)),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      onPressed: () => launchUrlStr(link),
      icon: Icon(icon, color: textColor),
      label: Text(labelText, style: TextStyle(color: textColor)),
    );
  }
}

