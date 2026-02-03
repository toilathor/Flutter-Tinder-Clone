import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinder_card_swipe/tinder_card_swipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
                backgroundColor: Colors.white, shadowColor: Colors.black87),
          )),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> items = [];
  final random = Random.secure();
  final CardSwiperController _controller = CardSwiperController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sizeScreen = MediaQuery.of(context).size;
      items.addAll(List.generate(
        5,
        (index) {
          return Container(
            height: sizeScreen.height * 0.8,
            width: sizeScreen.width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Color.fromRGBO(
                random.nextInt(255),
                random.nextInt(255),
                random.nextInt(255),
                1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://picsum.photos/id/${random.nextInt(100)}/${sizeScreen.width.toInt()}/${(sizeScreen.height * 0.8).toInt()}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const FlutterLogo(),
                cacheHeight: 500,
                cacheWidth: 500,
              ),
            ),
          );
        },
      ));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CardSwiper(
                initialIndex: 1,
                cardBuilder: (context, index, horizontalOffsetPercentage,
                        verticalOffsetPercentage) =>
                    items[index],
                cardsCount: items.length,
                controller: _controller,
              ),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton.filled(
                onPressed: () {
                  _controller.undo();
                },
                padding: const EdgeInsets.all(20),
                color: Colors.yellow[800],
                icon: const Icon(Icons.refresh),
              ),
              IconButton.filled(
                onPressed: () {
                  _controller.swipe(CardSwiperDirection.left);
                },
                padding: const EdgeInsets.all(20),
                color: Colors.red,
                icon: const Icon(Icons.close),
              ),
              IconButton.filled(
                onPressed: () {
                  _controller.swipe(CardSwiperDirection.top);
                },
                padding: const EdgeInsets.all(20),
                icon: const Icon(Icons.star),
                color: Colors.blueAccent,
              ),
              IconButton.filled(
                onPressed: () {
                  _controller.swipe(CardSwiperDirection.right);
                },
                padding: const EdgeInsets.all(20),
                icon: const Icon(Icons.favorite),
                color: Colors.greenAccent,
              ),
              IconButton.filled(
                onPressed: () {
                  // Nạp thêm item;
                  setState(() {
                    items.addAll(List.from(items));
                  });
                },
                padding: const EdgeInsets.all(20),
                icon: const Icon(Icons.bolt),
                color: Colors.purpleAccent,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
