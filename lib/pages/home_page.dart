import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show AssetManifest, rootBundle;
import 'package:my_website/src/definitions.dart';


import '../src/tools.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<String> _files = [];
  final List<String> _skillsPath = [];
  final List<String> _workedWithPath = [];

  _HomePageState() {
    // take the future list and update it as a current list
    loadAsset().then((val) => setState(() {
          _files = val;
          // print(_files);
          createLogoManifest();
      }));
  }
  
  Future<List<String>> loadAsset() async {
    // load all file locations from the assets directory(s) and puts them in a list
    final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    return assetManifest.listAssets();
  }

  void createLogoManifest(){
    for(String path in _files) {
      if(path.contains('images/logos/skills/')) {
        _skillsPath.add(path);
      }
      if(path.contains('images/logos/worked_with/')) {
        _workedWithPath.add(path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    const Key centerKey = ValueKey<String>('bottom-sliver-list');

    return CustomScrollView(
      center: centerKey,
      slivers:<Widget> [
        SliverList(
          key: centerKey,
          delegate: SliverChildBuilderDelegate(
            childCount: 1, // do not make any duplicates
            (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          height: 300,
                          child: Image.asset(
                            'assets/images/panorama.jpg',
                            width: MediaQuery.sizeOf(context).width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 175,
                          left: MediaQuery.sizeOf(context).width / 2 - 100,
                          height: 200,
                          child: const ProfilePictureWidget(size: 200.0,)
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(helloMessage, style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(60.0),
                          child: Text(
                            introText,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 920,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Skills & Experience",
                            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)
                          ),
                          const SizedBox(
                            width: 900,
                            child: Text(
                              skillsAndExperienceMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)
                            ),
                          ),
                          IconRow(logosPath: _skillsPath, size: 80),
                          const SizedBox(height: 20),
                          const Text(
                            "Tech I Use",
                            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)
                          ),
                          IconRow(logosPath: _workedWithPath, size: 80),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: Text(
                      "What I'm Working on",
                      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: Text(
                      whatImWorkingOnMessage,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)
                    ),
                  ),
                  const SizedBox(height: 80)
                ],
              );
            }
          ),
        ),
      ]
    );
  }
}

class IconRow extends StatelessWidget {
  const IconRow({
    super.key,
    required List<String> logosPath,
    required this.size,
  }):
  
  _logosPath = logosPath;

  final List<String> _logosPath;
  final double size;

  String extractFileName(String path) {
    return path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(String path in _logosPath)Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  path,
                  width: size,
                  height: size,
                ),
                Text(extractFileName(path), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
