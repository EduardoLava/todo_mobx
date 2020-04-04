import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {

  _TodoStore(this.title);

  // nao vai modificar, então não precisa de observable
  final String title;

  @observable
  bool done = false;

  @action
  void toggleDone() => done = !done;

}