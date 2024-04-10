import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(222, 222, 222, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/muscle_icon.svg',
              height: 220,
              width: 220,
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              'Твой Gym Tracker',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              '«Тело достигает того, во что верит разум»',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 70)),
              ),
              child: const Text(
                'Начать',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
