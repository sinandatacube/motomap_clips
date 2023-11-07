// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'impression_cubit.dart';

abstract class ImpressionState extends Equatable {
  const ImpressionState();

  @override
  List<Object> get props => [];
}

class ImpressionInitial extends ImpressionState {}

class ImpressionLoading extends ImpressionState {}

class ImpressionRemoveLoading extends ImpressionState {}


class ImpressionError extends ImpressionState {
  final String error;
 const ImpressionError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}


class ImpressionSet extends ImpressionState {}

class ImpressionNoUser extends ImpressionState {}


class ImpressionRemoved extends ImpressionState {}


class ImpressionsLoaded extends ImpressionState {
  final List<Impressions?> data;
  const ImpressionsLoaded({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}







