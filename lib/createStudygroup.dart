import 'package:flutter/material.dart';
import 'api.dart' as api;
import 'data.dart' as data;

class CreateStudygroup extends StatefulWidget {
  
  

  @override
  CreateStudygroupState createState() {
    return CreateStudygroupState();
  }

}

class CreateStudygroupState extends State<StatefulWidget> {

  int _selectedCategory;
  final name = TextEditingController();
  final description = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스터디그룹 생성'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: postStudygroup,
          )
        ],
      ),
      body: Container(padding: EdgeInsets.all(12), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton<int> (
            value: _selectedCategory,
            hint: Text('카테고리'),
            items: [
              DropdownMenuItem(value: 0, child: Text('대학진학')),
              DropdownMenuItem(value: 1, child: Text('취업')),
              DropdownMenuItem(value: 2, child: Text('프로그래밍')),
            ],
            onChanged: (item) {
              setState(() {
                _selectedCategory = item;      
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: '스터디그룹 이름',
              contentPadding: EdgeInsets.only(bottom: 5)
            ),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
            controller: name,
          ),
          Container(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: '스터디그룹 설명',
              contentPadding: EdgeInsets.only(bottom: 5)
            ),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
            maxLines: null,
            controller: description,
          ),
          
        ],
      ),
    ));
  }

  postStudygroup() {
    api.post('/studygroups', headers: {
      "authorization": "Bearer " + data.main.token
    }, body: {
      "category": _selectedCategory,
      "name": name.text,
      "description": description.text
    }).then((response) {
      if(response.statusCode == 200) {
        Navigator.pop(context);
      }
    });
  }

}