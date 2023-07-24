import 'package:flutter/material.dart';
import 'package:news_app/providers/themes.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DiscoverWidget extends StatelessWidget {
  Function filterFunction ;

  DiscoverWidget({
    super.key,
    required this.filterFunction
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(
            height: 20,
          ),
          Text(
            "Découvrir",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                // .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Actualités de partout en Algérie",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 15, letterSpacing: 1.2),
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            onChanged: (value) => filterFunction(value) ,
            style: TextStyle(color: themeProvider.isDarkMode ? const Color.fromARGB(255, 1, 23, 41) : Colors.grey.shade500),
            decoration: InputDecoration(
              prefixIcon:  Icon(Icons.search, color: themeProvider.isDarkMode ? const Color.fromARGB(255, 1, 23, 41) : Colors.grey.shade700,),
              hintText: "Rechercher",
              fillColor: Colors.grey.shade200,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}