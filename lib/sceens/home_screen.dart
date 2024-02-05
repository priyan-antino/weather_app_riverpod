import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  WeatherViewModel weatherViewModel = WeatherViewModel();
  @override
  void initState() {
    super.initState();
  }

  int temp = 0;

  TextEditingController cont = TextEditingController();
  String? val;
  late String loc;
  @override
  Widget build(BuildContext context) {
    loc = ref.watch(locationProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: cont,
                decoration: const InputDecoration(
                  labelText: "Enter Location :",
                  hintText: "Your desired location is...",
                  border: OutlineInputBorder(
                    gapPadding: 6,
                  ),
                ),
                onChanged: (value) {
                  val = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // ! , ?
                loc = val?.toString() ?? "";
                ref.read(locationProvider.notifier).refreshlocation(loc);
              },
              child: const Text(
                "Fetch Weather",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            Text(
              "Temperature of $loc :",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                return ref.watch(weatherProvider).when(
                  data: (data) {
                    return Text(
                      data.current.tempC.toString(),
                      style: const TextStyle(fontSize: 20),
                    );
                  },
                  error: (error, stackTrace) {
                    return Text("Sorry couldnt get weather data. $error");
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                );
              },
            )

            // Text(loc),
            // FutureBuilder(
            //   future: weatherViewModel.getWeather(loc),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       print("Error = ${snapshot.error}");
            //     } else if (snapshot.hasData == true) {
            //       return Text(snapshot.data!.current!.tempC.toString());
            //     }
            //     return const Text("failed !");
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
