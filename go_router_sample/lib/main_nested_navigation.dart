import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 参考: https://blog.pentagon.tokyo/1935/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/tab/:index', // :hoge とすることでパラメタとして値を与えられる
        builder: (context, state) {
          final index = state.params['index'];
          return TabScreen(currentIndex: int.parse(index!));
        },
      ),
      GoRoute(
        path: '/tab/:index/next/:number', // :hoge とすることでパラメタとして値を与えられる
        builder: (context, state) {
          final number = state.params['number'];
          return TabNextScreen(number: number!);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MaterialButton(
              child: Text('Tabへ'),
              onPressed: () {
                GoRouter.of(context).push('/tab/0'); // スタックで操作する場合
                // GoRouter.of(context).go('/tab'); // 現ルートと入れ替える場合
                // context.go('/tab'); // 現ルートと入れ替える場合
              },
            )
          ],
        ),
      ),
    );
  }
}

class TabScreen extends StatefulWidget {
  late final int index;

  TabScreen({required int currentIndex, Key? key}) : super(key: key) {
    assert(currentIndex != -1);
    index = currentIndex;
  }

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with TickerProviderStateMixin {
  late final TabController _controller;
  static const length = 3;

  @override
  void initState() {
    _controller = TabController(
      length: length,
      vsync: this,
      initialIndex: widget.index,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TabScreen oldWidget) {
    _controller.index = widget.index;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タブ'),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            for (final f in [0, 1, 2]) Tab(text: f.toString())
          ],
          onTap: (index) => _tap(context, index),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          for (final f in [0, 1, 2])
            TabDetailScreen(
              index: f,
            )
        ],
      ),
    );
  }

  void _tap(BuildContext context, int index) =>
      context.go('/tab/$index'); // 画面遷移させることでタブとして機能させる
}

class TabDetailScreen extends StatefulWidget {
  const TabDetailScreen({required this.index, Key? key}) : super(key: key);
  final int index;

  @override
  _TabDetailScreenState createState() => _TabDetailScreenState();
}

class _TabDetailScreenState extends State<TabDetailScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        for (var i = 0; i < 20; i++)
          ListTile(
            title: Text(i.toString()),
            onTap: () => context.push('/tab/${widget.index}/next/$i'),
          ),
      ],
    );
  }
}

class TabNextScreen extends StatefulWidget {
  const TabNextScreen({required this.number, Key? key}) : super(key: key);

  final String number;

  @override
  _TabNextScreenState createState() => _TabNextScreenState();
}

class _TabNextScreenState extends State<TabNextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('次の画面'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(widget.number),
        ),
      ),
    );
  }
}
