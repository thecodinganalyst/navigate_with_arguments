import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) => const ExtractArgumentsScreen()
      },
      onGenerateRoute: (settings) {
        if(settings.name == PassArgumentScreen.routeName){
          final args = settings.arguments as ScreenArguments;

          return MaterialPageRoute(builder: (context) {
            return PassArgumentScreen(title: args.title, message: args.message);
          });
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      title: 'Navigation with Arguments',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments('Extract Arguments Screen', 'This message is extracted in the build method.'));
            }, child: const Text('Navigate to screen that extracts argument')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PassArgumentScreen.routeName,
                    arguments: ScreenArguments('Accept Arguments Screen', 'This message is extracted in the onGenerateRoute function')
                  );
                }, 
                child: const Text('Navigate to a named that accepts arguments'))
          ],
        ),
      ),
    );
  }
}

class PassArgumentScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  const PassArgumentScreen({
    super.key,
    required this.title,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      )
    );
  }
}


class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({Key? key}) : super(key: key);

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}


class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}