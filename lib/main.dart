import 'dart:math' as math;

import 'package:flutter/material.dart';

enum SidePoint { above, under }

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
      ),
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
  Matrix4 matrix = Matrix4.identity();

  SidePoint side = SidePoint.under;
  FractionalOffset alignment = FractionalOffset.topCenter;
  Offset currentOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final cardH = (w) * 3 / 1.6;
    final cardW = w;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder<Matrix4>(
                duration: const Duration(milliseconds: 250),
                tween: Matrix4Tween(
                  begin: matrix,
                  end: matrix,
                ),
                builder: (context, value, child) {
                  return Transform(
                    transform: value,
                    alignment: alignment,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          matrix
                            ..rotateZ(
                              (side == SidePoint.under ? -1 : 1) *
                                  details.delta.dx *
                                  (math.pi / 12) /
                                  (w / 2),
                            )
                            ..translate(details.delta.dx / 3, details.delta.dy);
                        });
                        currentOffset += details.delta;
                      },
                      onPanStart: (details) {
                        currentOffset = Offset.zero;
                        _getSidePoint(details, cardH);
                      },
                      onPanEnd: (details) {
                        setState(() {
                          matrix = Matrix4.identity();
                        });
                        if (currentOffset.dx > cardW / 4) {
                          print("Like");
                        } else if (currentOffset.dx < -cardW / 4) {
                          print("Dislike");
                        } else if (currentOffset.dy < -cardH / 4) {
                          print('Super Like');
                        } else {
                          print("Cancel");
                        }
                      },
                      child: Container(
                        height: cardH,
                        width: cardW,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const FlutterLogo(),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void _getSidePoint(DragStartDetails details, double heightCard) {
    side = details.localPosition.dy < heightCard / 2
        ? SidePoint.above
        : SidePoint.under;

    setState(() {
      alignment = side == SidePoint.above
          ? FractionalOffset.bottomCenter
          : FractionalOffset.topCenter;
    });
  }
}
