import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_apps_php/main.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list, this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController firstName = TextEditingController();

  TextEditingController phone = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = Uri.parse('http://127.0.0.1/crud_app/edit.php');
      http.post(url, body: {
        'id': widget.list[widget.index]['id'],
        'firstname': firstName.text,
        'phone': phone.text,
      });
    } else {
      var url = Uri.parse('http://127.0.0.1/crud_app/add.php');
      http.post(url, body: {
        'firstname': firstName.text,
        'phone': phone.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      firstName.text = widget.list[widget.index]['firstname'];

      phone.text = widget.list[widget.index]['phone'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(editMode ? 'edit' : 'Add'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phone,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  addUpdateData();
                  debugPrint('Adding running');
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.yellow,
              child: Text(
                editMode ? 'Update' : 'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
