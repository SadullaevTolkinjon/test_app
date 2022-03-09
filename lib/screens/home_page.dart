import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:test_zadaniya/constant/constant.dart';
import 'package:test_zadaniya/core/data_avatars.dart';
import 'package:test_zadaniya/core/size_config/size_config.dart';
import 'package:test_zadaniya/model/user_model.dart';
import 'package:test_zadaniya/service/my_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: UserService.getUserService(),
          builder: (_, AsyncSnapshot<List<UserModel>> snap) {
            if (!snap.hasData) {
              return Center(
                child: ConstantsMy.circleProg,
              );
            } else if (snap.hasError) {
              return Center(
                child: ConstantsMy.nointernet,
              );
            } else {
              var data = snap.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getProportionScreenWidth(10),
                      right: getProportionScreenWidth(5),
                      top: getProportionScreenHeight(20),
                    ),
                    child: SizedBox(
                      height: getProportionScreenHeight(160),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: getProportionScreenWidth(10),
                            mainAxisExtent: getProportionScreenHeight(150)),
                        itemBuilder: (_, __) {
                          return GestureDetector(
                            child: Container(
                              width: getProportionScreenWidth(180),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    getProportionScreenHeight(10),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: getProportionScreenHeight(120),
                                    child: Image.asset(
                                      avatars[__],
                                    ),
                                  ),
                                  Text(
                                    "id: ${data![__].id}",
                                  ),
                                  SizedBox(
                                    child: AutoSizeText(
                                      data[__].name.toString(),
                                    ),
                                    height: getProportionScreenHeight(20),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, "/second",
                                  arguments: [data[__], avatars[__]]);
                            },
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: data!.length,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
