import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Page2Screen extends StatelessWidget {
  const Page2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go to home page'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => context.go('/page2/page3'),
                child: const Text('Go to page 3'),
              ),
            ],
          ),
        ),
      );
}
