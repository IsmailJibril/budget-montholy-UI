import 'package:budget_monthly/json/category_json.dart';
import 'package:budget_monthly/json/merchant_json.dart';
import 'package:budget_monthly/theme/theme_color.dart';
import 'package:budget_monthly/widgets/chart_line.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YourBalancePage extends StatefulWidget {
  YourBalancePage({Key? key}) : super(key: key);

  @override
  State<YourBalancePage> createState() => _YourBalancePageState();
}

var bgcolor = Color.fromARGB(225, 255, 255, 255);

class _YourBalancePageState extends State<YourBalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: bgcolor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: black,
          size: 22,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 15),
          child: Text(
            "Set Budge",
            style: TextStyle(
              fontSize: 15,
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          getBalance(),
          SizedBox(
            height: 20,
          ),
          getChartAndBalance(),
          const SizedBox(height: 30),
          getTopMerchants(),
          const SizedBox(height: 20),
          getTopCategories(),
          const SizedBox(height: 50)
        ],
      ),
    );
  }

  Widget getBalance() {
    return Center(
      child: Column(
        children: [
          Text(
            "Your balance is \$1,752",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "By this time last month, you spent\n slightly higher (\$2,450)",
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
            ),
          )
        ],
      ),
    );
  }

  Widget getChartAndBalance() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: LineChart(activityData()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120, right: 20, left: 20),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: black.withOpacity(0.015),
                        spreadRadius: 10,
                        blurRadius: 10)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Spent",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "\$1,460",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: primary, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Earned",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black.withOpacity(0.5)),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "\$3,850",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTopMerchants() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Merchant",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(merchantList.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: black.withOpacity(0.015),
                                        spreadRadius: 10,
                                        blurRadius: 10)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Image.network(merchantList[index]['image']),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  merchantList[index]['name'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  merchantList[index]['transaction'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black.withOpacity(0.5)),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          merchantList[index]['price'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget getTopCategories() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Category",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(categoryList.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 150,
                  height: 220,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.015),
                          spreadRadius: 10,
                          blurRadius: 10,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 0, top: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 80,
                          child: CircleProgressBar(
                            foregroundColor: primary,
                            backgroundColor: black.withOpacity(0.1),
                            value: categoryList[index]['percentage'],
                            child: Center(
                              child: Text(
                                categoryList[index]['img'],
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          categoryList[index]['name'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          categoryList[index]['price'],
                          style: TextStyle(
                              fontSize: 15,
                              color: black.withOpacity(0.5),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            color: bgcolor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "On track",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: black.withOpacity(0.7)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })),
          )
        ],
      ),
    );
  }
}
