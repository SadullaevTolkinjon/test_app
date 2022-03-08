import 'package:flutter/material.dart';
import 'package:test_zadaniya/constant/constant.dart';
import 'package:test_zadaniya/core/size_config/size_config.dart';
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
              builder: (_, AsyncSnapshot snap) {
                if (!snap.hasData) {
                  return Center(
                    child: ConstantsMy.circleProg,
                  );
                } else if (snap.hasError) {
                  return Center(
                    child: ConstantsMy.nointernet,
                  );
                } else {
                  List data = snap.data;
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
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing:
                                          getProportionScreenWidth(10),
                                      mainAxisExtent:
                                          getProportionScreenHeight(150)),
                              itemBuilder: (_, __) {
                                return Container(
                                  width: getProportionScreenWidth(180),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        getProportionScreenHeight(10),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length),
                        ),
                      )
                    ],
                  );
                }
              })),
    );
  }
}
