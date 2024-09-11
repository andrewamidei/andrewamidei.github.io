import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_website/pages/linker_page.dart';
import 'home_page.dart';
import '../src/tools.dart';
import '../src/theme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState(); // underscore in the widget makes the class private
}

class _NavigationPageState extends State<NavigationPage> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const LinkerPage(),

        '/home': (context) => Scaffold(
          // TODO: add new pages here
          appBar: currentPageIndex == 0 ? topNavigationBar() : null,
          body: /*currentPageIndex != 0 ? leftNavigationBar(page) :*/ const HomePage(),
        ),
      },
    );
  }


  PreferredSize topNavigationBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: NavigationBar(
          // fix theme not applying to this
          backgroundColor: const Color.fromARGB(255, 19, 124, 223), // Theme.of(context).colorScheme.primary,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0), child: ToolbarWidget()),
            SizedBox()
          ],
        ),
      );
  }

  Row leftNavigationBar(Widget page) {
    return Row(
      children: [
        NavigationRail(
        extended: true,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        useIndicator: false,
        leading: const SizedBox(
          width: 256,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: ProfilePictureWidget(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: NameWidget(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SubtitleWidget(),
                ),
              ],
            ),
          ),
        ),
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.archive),
            label: Text('All Posts'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.category),
            label: Text('Categories'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.info),
            label: Text('About'),
          ),
        ],
        trailing: const Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ToolbarWidget(),
          ),
        ),
      ),
      Expanded(child: page),
      ],
    );
  }
}

