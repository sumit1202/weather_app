import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/hourly_forecast_row_item.dart';
import 'package:http/http.dart' as http;

import 'more_info_row_item.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Map<String, dynamic>> weather = getCurrentWeather();
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Bangalore';
      const secretAppKey = '';
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$secretAppKey'));

      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bangalore, KA, India',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //main card - 1st row
                  SizedBox(
                    width: double.infinity,
                    //height: 200,
                    child: Card(
                      elevation: 5,
                      // color: Colors.indigo,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$currentTemp °K',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Icon(
                              currentSky == 'Clouds' || currentSky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 60,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              currentSky,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  //2nd row
                  const Text(
                    'Hourly Weather Forecast :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 5; i++)
                  //         HourlyForecastRowItem(
                  //             temperature: data['list'][i + 1]['main']['temp']
                  //                 .toString(),
                  //             icon: data['list'][i + 1]['weather'][0]['main'] ==
                  //                         'Clouds' ||
                  //                     data['list'][i + 1]['weather'][0]
                  //                             ['main'] ==
                  //                         'Rain'
                  //                 ? Icons.cloud
                  //                 : Icons.sunny,
                  //             time: data['list'][i + 1]['dt'].toString()),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, i) {
                        final time =
                            DateTime.parse(data['list'][i + 1]['dt_txt']);
                        return HourlyForecastRowItem(
                          temperature:
                              '${data['list'][i + 1]['main']['temp'].toString()} °K',
                          icon: data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          time: DateFormat.jm().format(time),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  //3rd row
                  const Text(
                    'More Information :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MoreInfoRowItem(
                          icon: Icons.water_drop_outlined,
                          label: 'Humidity',
                          labelvalue: currentHumidity.toString()),
                      MoreInfoRowItem(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          labelvalue: currentWindSpeed.toString()),
                      MoreInfoRowItem(
                          icon: Icons.timer_outlined,
                          label: 'Pressure',
                          labelvalue: currentPressure.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
