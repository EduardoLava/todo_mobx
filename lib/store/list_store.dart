import 'package:mobx/mobx.dart';
import 'package:todomobx/store/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {


  @observable
  String newTodoTitle = "";

  // se for list comum o observable nao reconhece adicao ou alteração de itens
//  @observable
  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void setNewTodoTitle(String value) => this.newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0,TodoStore(newTodoTitle));
    newTodoTitle = "";
  }

  @computed
  bool get isFormValid => newTodoTitle.trim().isNotEmpty;

}