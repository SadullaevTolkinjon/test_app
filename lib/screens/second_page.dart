import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_zadaniya/core/size_config/size_config.dart';
import 'package:test_zadaniya/core/widget.dart';
import 'package:test_zadaniya/model/post_model.dart';
import 'package:test_zadaniya/model/user_model.dart';
import 'package:test_zadaniya/service/post_service.dart';

class SecondPage extends StatefulWidget {
  var datas;
  SecondPage({
    Key? key,
    this.datas,
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  UserModel? data;
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  final _globalKey2 = GlobalKey<FormState>();
  final _globalKey3 = GlobalKey<FormState>();
  CommentsModel? _model;

  @override
  void initState() {
    super.initState();
    data = widget.datas[0];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data!.name.toString()),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getProportionScreenHeight(300),
            width: double.infinity,
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: getProportionScreenHeight(150),
                      width: getProportionScreenWidth(130),
                      child: Image.asset(widget.datas[1]),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username: ${data!.username.toString()}"),
                    Text("City: ${data!.address!.city}"),
                    Text("Street: ${data!.address!.street}"),
                    Text("Phone number: ${data!.phone}"),
                    Text("Email: ${data!.email}"),
                    Text("Website: ${data!.website}"),
                    Text("Company name: ${data!.company!.name}")
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: getProportionScreenWidth(20)),
            child: const Text("Add comments"),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: getProportionScreenWidth(20),
                  right: getProportionScreenWidth(20),
                  top: getProportionScreenHeight(15)),
              child: Form(
                key: _globalKey,
                child: TextFieldMy(
                  key: _globalKey,
                  controller: _titleController,
                  hint: "title for comment...",
                ),
              )),
          Padding(
              padding: EdgeInsets.only(
                  left: getProportionScreenWidth(20),
                  right: getProportionScreenWidth(20),
                  top: getProportionScreenHeight(10)),
              child: Form(
                  key: _globalKey2,
                  child: TextFieldMy(
                    controller: _emailController,
                    hint: "email...",
                  ))),
          Padding(
            padding: EdgeInsets.only(
                left: getProportionScreenHeight(20),
                right: getProportionScreenWidth(20),
                top: getProportionScreenHeight(10)),
            child: Form(
              child: TextFieldMy(
                controller: _globalKey3,
              ),
              key: _globalKey3,
            ),
          ),
          SizedBox(
            height: getProportionScreenHeight(30),
          ),
          _model == null
              ? Container()
              : Container(
                  padding: EdgeInsets.only(left: getProportionScreenWidth(20)),
                  height: getProportionScreenHeight(120),
                  width: double.infinity,
                  child: AutoSizeText(
                      "Title: ${_model!.name},Email: ${_model!.email}, body: ${_model!.body}"),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_globalKey.currentState!.validate() &&
              _globalKey2.currentState!.validate() &&
              _globalKey3.currentState!.validate()) {
            final CommentsModel model = await PostService.postComment(
              _titleController.text,
              _emailController.text,
              _commentsController.text,
            );
            setState(() {
              _model = model;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
