import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weathe_api.dart';

void main() {
  runApp(MaterialApp(
    home: Main_Page(),
    debugShowCheckedModeBanner: false,
  ));
}

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  Dio dio = Dio();

  Future<WeatheApi> getData() async {
    var response = await dio.get(
        "http://api.weatherapi.com/v1/forecast.json?key=8c9416d38c45437a8a9105439231109&q=London&days=4");
    if (response.statusCode == 200) {
      return WeatheApi.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  String date = DateFormat("dd").format(DateTime.now());
  String today = DateFormat("MMM dd").format(DateTime.now());
  int week_day = DateTime.now().weekday;
  Map<int, String> weekdayName = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<WeatheApi> snapshot) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/paris.png"), fit: BoxFit.cover)),
            child: Stack(children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Icon(
                              Icons.location_on_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Text(
                              "${snapshot.data?.location?.name}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                today,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Text(
                                "Updated ${snapshot.data?.current?.lastUpdated}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06),
                          Column(
                            children: [
                              Image.network(
                                "${snapshot.data?.current?.condition?.icon}",
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Text(
                                "${snapshot.data?.current?.condition?.text}",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data?.current?.tempC}",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "°C",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Image.asset("assets/humidity.png")),
                            Text(
                              "HUMIDITY",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${snapshot.data?.current?.humidity} %",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Image.asset("assets/wind.png")),
                            Text(
                              "Wind",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${snapshot.data?.current?.windKph} km/h",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Image.asset("assets/FeelsLike.png")),
                            Text(
                              "FEELS LIKE",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${snapshot.data?.current?.feelslikeC} °C",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${weekdayName[index == 0 ? week_day + 1 : index == 1 ? week_day + 2 : index == 2 ? week_day + 3 : week_day + 4]}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child:
                                              Image.asset("assets/wind.webp")),
                                      Text(
                                          "${snapshot.data?.forecast?.forecastday?[index].day?.avgtempC} °C",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))
                                    ],
                                  ),
                                  Text(
                                      "${snapshot.data?.forecast?.forecastday?[index].day?.maxwindKph}\n"
                                      "km/h",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))
                                ],
                              ),
                            );
                          },
                        )),
                  )
                ],
              ),
            ]));
      },
    ));
  }
}
