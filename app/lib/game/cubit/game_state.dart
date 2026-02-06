part of 'game_cubit.dart';

sealed class GameState extends Equatable {}

class GameLoading extends GameState {
  @override
  List<Object?> get props => [];
}

class GameLoaded extends GameState {
  GameLoaded({required this.pak});

  final Pak pak;

  @override
  List<Object?> get props => [pak];
}

class GameError extends GameState {
  GameError({required this.error});

  final Object error;

  @override
  List<Object?> get props => [error];
}
