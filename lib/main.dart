import 'package:flutter/material.dart';
import 'package:flutter_message_project/widgets/email_list_view.dart';
import 'models/models.dart';
import 'models/data.dart' as data;
import 'widgets/disappearing_bottom_navigation_bar.dart';
import 'widgets/disappearing_navigation_rail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Feed(
        currentUser: data.user_0,
      ),
    );
  }
}

class Feed extends StatefulWidget {
  const Feed({
    super.key,
    required this.currentUser,
  });

  final User currentUser;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(
      _colorScheme.primary.withOpacity(0.14), _colorScheme.surface);
  int selectedIndex = 0;

  bool wideScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    wideScreen = width > 600;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (wideScreen)
            DisappearingNavigationRail(
              backgroungColor: _backgroundColor,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          Expanded(
              child: Container(
            color: _backgroundColor,
            child: EmailListView(
              currentUser: widget.currentUser,
              selectedIndex: selectedIndex,
              onSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ))
        ],
      ),
      floatingActionButton: wideScreen
          ? null
          : FloatingActionButton(
              onPressed: () {},
              backgroundColor: _colorScheme.tertiaryContainer,
              foregroundColor: _colorScheme.onTertiaryContainer,
              child: const Icon(Icons.add),
            ),
      bottomNavigationBar: wideScreen
          ? null
          : DisappearingBottomNavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
    );
  }
}
