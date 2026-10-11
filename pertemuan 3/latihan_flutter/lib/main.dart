import 'package:flutter/material.dart';

void main() {
  //   runApp(
  //     MaterialApp(
  //       title: 'Flutter Demo',
  //       debugShowCheckedModeBanner: false,
  //       debugShowMaterialGrid: false,
  //       home: Scaffold(
  //         body: Center(
  //           child: Text(
  //             'Hello, World!',
  //             style: TextStyle(
  //               fontSize: 24,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.blue,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Pertemuan 3',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Widget Text - Flutter'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SectionTitle(title: '1. Basic Text Widget'),
              SizedBox(height: 8),
              BasicTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '2. Font, Weight dan Style'),
              SizedBox(height: 8),
              FontTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '3. Spacing'),
              SizedBox(height: 8),
              SpacingTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '4. Decoration dan Shadow'),
              SizedBox(height: 8),
              DecorationTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '5. Text Alignment'),
              SizedBox(height: 8),
              AlignmentTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '6. maxLines dan overflow'),
              SizedBox(height: 8),
              OverflowTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '7. RichText dan TextSpan'),
              SizedBox(height: 8),
              RichTextWidget(),
              SizedBox(height: 20),

              SectionTitle(title: '8. TextScaler'),
              SizedBox(height: 8),
              TextScalerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/** Jika variabel dibuat di dalam class (di luar fungsi), dan Anda ingin membuatnya tetap (const), wajib ditambah static.
Jika variabel dibuat di dalam fungsi/metode, Anda tidak boleh pakai static. Cukup gunakan const atau tipe data biasa seperti String hello = ....
*/

class MyHello extends StatelessWidget {
  const MyHello({super.key});
  static const String hello = "Hello, World!";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(hello),
        ),
      ),
    );
  }
}

class BasicTextWidget extends StatelessWidget {
  const BasicTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Hello Flutter',
      style: TextStyle(
        fontSize: 24,
        color: Colors.blue,
      ),
    );
  }
}

class FontTextWidget extends StatelessWidget {
  const FontTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Normal',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          'Bold',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Semi Bold',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Italic',
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class SpacingTextWidget extends StatelessWidget {
  const SpacingTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Normal Text',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Letter Spacing',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 5,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Word Spacing Example',
          style: TextStyle(
            fontSize: 20,
            wordSpacing: 10,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Line 1\nLine 2\nLine 3',
          style: TextStyle(
            fontSize: 20,
            height: 2,
          ),
        ),
      ],
    );
  }
}

class DecorationTextWidget extends StatelessWidget {
  const DecorationTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Underline',
          style: TextStyle(
            fontSize: 20,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Line Through',
          style: TextStyle(
            fontSize: 20,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Background',
          style: TextStyle(
            fontSize: 20,
            backgroundColor: Colors.yellow,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Text Shadow',
          style: TextStyle(
            fontSize: 30,
            shadows: [
              Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AlignmentTextWidget extends StatelessWidget {
  const AlignmentTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: const Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'Left',
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Center',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Right',
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Justify: Flutter adalah framework untuk membuat aplikasi menggunakan satu codebase.',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class OverflowTextWidget extends StatelessWidget {
  const OverflowTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: const Text(
        'Flutter adalah framework UI dari Google yang dapat digunakan untuk membuat aplikasi Android, iOS, Web dan Desktop.',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: 'Saya sedang belajar '),
          TextSpan(
            text: 'Flutter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          TextSpan(text: ' dan '),
          TextSpan(
            text: 'Dart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class TextScalerWidget extends StatelessWidget {
  const TextScalerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Text normal',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Text dengan ukuran lebih besar',
          textScaler: TextScaler.linear(1.5),
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}