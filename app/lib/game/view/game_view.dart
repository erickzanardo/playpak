import 'package:app/domain/domain.dart';
import 'package:app/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit()
        ..loadFromURL(
          'https://cherrybit-studios.github.io/paks/mini_dwarven_mine/pak.json',
        ),
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GameCubit>();
    final state = cubit.state;

    return Scaffold(
      body: Center(
        child: switch (state) {
          GameLoading() => const CircularProgressIndicator(),
          GameLoaded(pak: final pak) => _GameView(pak: pak),
          GameError(error: final error) => Text('Error: $error'),
        },
      ),
    );
  }
}

class _GameView extends StatefulWidget {
  const _GameView({required this.pak});

  final Pak pak;

  @override
  State<_GameView> createState() => _GameViewState();
}

class _GameViewState extends State<_GameView> {
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_playing)
          Expanded(child: _GameWebView(pak: widget.pak))
        else ...[
          Image.network(widget.pak.logoUrl, height: 200),
          Text(
            widget.pak.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(widget.pak.description),
          ElevatedButton(
            onPressed: () {
              setState(() => _playing = true);
            },
            child: const Text('Start Game'),
          ),
        ],
      ],
    );
  }
}

class _GameWebView extends StatefulWidget {
  const _GameWebView({required this.pak});

  final Pak pak;

  @override
  State<_GameWebView> createState() => _GameWebViewState();
}

class _GameWebViewState extends State<_GameWebView> {
  late final _controller = WebViewController()
    ..loadRequest(Uri.parse(widget.pak.gameUrl));

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
