import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_row_item.dart';

import 'more_info_row_item.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

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
            onPressed: () => debugPrint('refresh!!'),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
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
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '23°C',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Icon(
                          Icons.thunderstorm_outlined,
                          color: Colors.blueAccent,
                          size: 60,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Rain',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              //2nd row
              Text(
                'Hourly Weather Forecast :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecastRowItem(
                        temperature: '21°C',
                        icon: Icons.thunderstorm_outlined,
                        time: '05:00'),
                    HourlyForecastRowItem(
                        temperature: '23°C',
                        icon: Icons.thunderstorm_outlined,
                        time: '09:00'),
                    HourlyForecastRowItem(
                        temperature: '28°C',
                        icon: Icons.thunderstorm_outlined,
                        time: '13:00'),
                    HourlyForecastRowItem(
                        temperature: '25°C',
                        icon: Icons.thunderstorm_outlined,
                        time: '17:00'),
                    HourlyForecastRowItem(
                        temperature: '18°C',
                        icon: Icons.thunderstorm_outlined,
                        time: '21:00'),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              //3rd row
              Text(
                'More Information :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MoreInfoRowItem(
                      icon: Icons.water_drop_outlined,
                      label: 'Humidity',
                      labelvalue: '94'),
                  MoreInfoRowItem(
                      icon: Icons.air, label: 'Wind Speed', labelvalue: '94'),
                  MoreInfoRowItem(
                      icon: Icons.timer_outlined,
                      label: 'Pressure',
                      labelvalue: '94'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
