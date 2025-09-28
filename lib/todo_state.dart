part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

final class InitToDoStates extends TodoState {}
final class ChangeNavBarStates extends TodoState{}
final class ChangeBottomSheetStates extends TodoState{}
final class CreateDBStates extends TodoState{}
final class InsertDBStates extends TodoState{}
final class GetDBStates extends TodoState{}
final class UpdateDBStates extends TodoState{}
final class DeleteDBStates extends TodoState{}
