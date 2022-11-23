import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Page3Screen extends StatelessWidget {
  const Page3Screen({Key? key}) : super(key: key);

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
                onPressed: () => GoRouter.of(context).pop(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      );
}
