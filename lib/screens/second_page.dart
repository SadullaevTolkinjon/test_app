import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_zadaniya/constant/constant.dart';
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
  final _commentsController = TextEditingController();
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();

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
     
      body: SingleChildScrollView(child: Column(
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
              child: TextFieldMy(
                controller: _titleController,
                hint: "title for comment...",
              )),
          Padding(
            padding: EdgeInsets.only(
                left: getProportionScreenWidth(20),
                right: getProportionScreenWidth(20),
                top: getProportionScreenHeight(10)),
            child: TextFieldMy(
              controller: _emailController,
              hint: "email...",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: getProportionScreenHeight(20),
                right: getProportionScreenWidth(20),
                top: getProportionScreenHeight(10)),
            child: Form(
              child: TextFormField(
                controller: _commentsController,
                decoration: InputDecoration(
                  hintText: "comment...",
                  contentPadding: ConstantsMy.padding,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(
                          getProportionScreenHeight(100))),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      getProportionScreenHeight(100),
                    ),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Shouldn't be empty";
                  }
                  return null;
                },
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
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_globalKey3.currentState!.validate()) {
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
