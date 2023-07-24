import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/weatherModel.dart';

// ignore: must_be_immutable
class WeatherWidget1 extends StatelessWidget {

  String formatDateTime(DateTime dateTime) {
  final frenchLocale = Locale("fr", "FR");
  final dateFormat = DateFormat("EEEE d MMMM y", frenchLocale.toString());
  return dateFormat.format(dateTime);
}
  WeatherWidget1({
    this.data,
    super.key,
    required this.size,
  });

  final Size size;
  Weather? data;

  @override
  Widget build(BuildContext context) {
    print(data?.icon);
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 80),
            margin: const EdgeInsets.only(right: 12, left: 12),
            height: size.height * 0.75,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xff955cd1),
                      Color(0xff3fa2fa),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.2, 0.65])),
            child: Column(
              children: [
                Text(
                  '${data?.cityName}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 35,
                  ),
                ),
                Text(
                  // formatDateTime(DateTime.now()) ,
  DateFormat('yMd').format(DateTime.now()),
  style: TextStyle(
    color: Colors.white.withOpacity(0.9),
    fontSize: 15,
  ),
),

                Image.network(
                  'https:${data!.icon}',
                  scale: 0.5,
                  // width: size.width * 0.4,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${data!.condition} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                Text(
                  '${data!.temp}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 75,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Image.asset(
                          'assets/pictures/wind.png',
                          width: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            '${data!.wind} km/h',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'Vent',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Image.asset(
                          'assets/pictures/cloud.png',
                          width: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            '${data!.humidity}',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'Humidité',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        Image.asset(
                          'assets/pictures/windspeed.png',
                          width: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            '${data!.wind_dir}',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            'Vitesse du vent',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
