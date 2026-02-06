import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app/domain/pak.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({http.Client? client})
    : _client = client ?? http.Client(),
      super(GameLoading());

  final http.Client _client;

  Future<void> loadFromURL(String url) async {
    emit(GameLoading());

    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final pak = Pak.fromJson(json);
        emit(GameLoaded(pak: pak));
      } else {
        emit(
          GameError(error: 'Failed to load game data: ${response.statusCode}'),
        );
      }
    } catch (e) {
      emit(GameError(error: 'An error occurred while loading game data: $e'));
    }
  }
}
