import 'package:flutter/material.dart';

import '../models/weatherModel.dart';

// ignore: must_be_immutable
class WeatherWidget2 extends StatelessWidget {
  Weather? data;
  WeatherWidget2({
    this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              children: [
                Text(
                  'Rafales',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data!.gust} kp/h ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  'UV',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data!.uv}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Précipitations',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data!.pricipe}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                )
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              children: [
                Text(
                  'Pression',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data!.pressure} hpa',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                )
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Dernière mise à jour',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${data!.last_update}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                )
              ],
            )),
          ],
        )
      ],
    );
  }
}
