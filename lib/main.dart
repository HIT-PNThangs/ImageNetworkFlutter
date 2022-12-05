import 'package:flutter/material.dart';
import 'package:image_network/meet_network_image.dart';

void main() {
  runApp(const MyApp());
}

List list = [
  "https://i.ibb.co/K76D7h8/christmas-30.jpg",
  "https://i.ibb.co/RBYBbhR/christmas-35.jpg",
  "https://i.ibb.co/W0NYjkF/3.jpg",
  "https://i.ibb.co/Qnr4C7J/5.jpg",
  "https://i.ibb.co/jGQWBPV/3.jpg",
  "https://i.ibb.co/DrGc3vc/car-s1-13.jpg",
  "https://i.ibb.co/3WWtz5f/car-s1-25.jpg",
  "https://i.ibb.co/YR3jGq1/lake-s1-9.jpg",
  "https://i.ibb.co/sFSR5xh/mountain-s1-28.jpg"
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        children: list
            .map((e) => MeetNetworkImage(
                  imageUrl: e,
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (BuildContext context, Object? error) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red
                      )
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
