import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_todo_mobx/app/lib/screens/login_screen.dart';
import 'package:flutter_todo_mobx/app/lib/stores/list_store.dart';
import 'package:flutter_todo_mobx/app/lib/stores/login_store.dart';
import 'package:flutter_todo_mobx/app/lib/widgets/custom_text_field.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ListStore listStore = ListStore();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsetsDirectional.only(
              start: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            'Tarefas',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                end: MediaQuery.of(context).size.width * 0.05),
            child: IconButton(
                onPressed: () {
                  Provider.of<LoginStore>(context, listen: false).logout();
                  Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                },
                icon: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Observer(
                    builder: (_) => CustomTextField(
                          controller: controller,
                          hint: 'Tarefas',
                          suffix: listStore.isFormValid
                              ? InkWell(
                                  child: Icon(Icons.add),
                                  onTap: () {
                                    listStore.addTodo();
                                    controller.clear();
                                  })
                              : null,
                          preffix: null,
                          changed: listStore.setNewTodoTitle,
                        )),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Observer(
                    builder: (_) => ListView.separated(
                      itemCount: listStore.todoList.length,
                      itemBuilder: (_, index) {
                        final todo = listStore.todoList[index];
                        return Observer(
                            builder: (_) => ListTile(
                                  title: Text(
                                    todo.title,
                                    style: TextStyle(
                                        decoration: todo.done
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: todo.done
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                  onTap: todo.toggleDone,
                                ));
                      },
                      separatorBuilder: (_, index) {
                        return Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            height: 2,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
